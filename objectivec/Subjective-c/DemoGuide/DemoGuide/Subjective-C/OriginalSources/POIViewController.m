//
//  POIViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "POIViewController.h"

@implementation POIViewController
@synthesize poiCell;
@synthesize appDelegate;
@synthesize descView;
@synthesize categoryPoiDict;
@synthesize poiCell_KID, poiCell_CATEGORY;
@synthesize tableView, segmentedControl, poiSortList, normalSortList, itiSortList;

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.appDelegate = (DemoGuideAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.categoryPoiDict = [[NSMutableDictionary alloc] init];
    
    /* Create dictionary with key=category and object=array of poi */
    for(CategoryPoi * cat in [self.appDelegate.cacheManager categoryList]){
        NSMutableArray * poiArray = [[NSMutableArray alloc] init];
        for(Poi * p in [self.appDelegate.cacheManager poisList]){
            NSMutableArray * pCategories = [p categories];
            if([pCategories containsObject:cat]){
                [poiArray addObject:p];
            }
        }
        [self.categoryPoiDict setObject:poiArray forKey:[cat idString]];
        [poiArray release];
    }
    [self.segmentedControl removeAllSegments];
    self.normalSortList = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                           [NSArray arrayWithObjects:@"Name", @"Category", nil],
                           [NSArray arrayWithObjects:@"Nom", @"Catégorie", nil],
                           [NSArray arrayWithObjects:@"Naam", @"Categorie", nil], nil]
                                                      forKeys:[NSArray arrayWithObjects:@"en", @"fr", @"nl", nil]];
    
    self.itiSortList = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:
                                                               [NSArray arrayWithObjects:@"Itinerary", @"Name", @"Category", nil],
                                                               [NSArray arrayWithObjects:@"Itinéraire", @"Nom", @"Catégorie", nil],
                                                               [NSArray arrayWithObjects:@"Route", @"Naam", @"Categorie", nil], nil]
                                                      forKeys:[NSArray arrayWithObjects:@"en", @"fr", @"nl", nil]];
    [self resetPoiSortTab];
    
    /*UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"By category", @"By distance", @"By name", nil]];
    segment.segmentedControlStyle = UISegmentedControlStyleBar;
    self.tableView.tableHeaderView = [self createHeaderView];
    [segment release];*/

    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [self setPoiCell:nil];
    [segmentedControl release];
    segmentedControl = nil;
    [tableView release];
    tableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self resetPoiSortTab];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (IBAction)modifyPoiOrder:(id)sender{
    int index = self.segmentedControl.selectedSegmentIndex;
    int maxIndex = self.segmentedControl.numberOfSegments;
    NSString * orderName = [self.poiSortList objectAtIndex:index];
    
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"CategoryPoiOrder"];
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"ItineraryPoiOrder"];
    
    if(maxIndex == 3) { // Guided tour active
        if(index==0){
            [[SCContextManager sharedContextManager] activateContextWithName:@"ItineraryPoiOrder"];
        }
        else if(index==2){
            [[SCContextManager sharedContextManager] activateContextWithName:@"CategoryPoiOrder"];
        }
    }
    else if(maxIndex==2){ // Guided tour inactive
        if(index==1){
            [[SCContextManager sharedContextManager] activateContextWithName:@"CategoryPoiOrder"];
        }
    }

    [self.tableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    
    NSArray * poisList = [[self.appDelegate cacheManager] poiByName];
    return [poisList count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    static NSString *CellIdentifier = @"Cell";
    NSArray * poisList = [[self.appDelegate cacheManager] poiByName];
    Poi * curPoi = [poisList objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        /*cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];*/
        [[NSBundle mainBundle] loadNibNamed:@"POIViewCell" owner:self options:nil];
        cell = poiCell;
        self.poiCell = nil;
    }

    // Configure the cell...
    /*cell.textLabel.text = [curPoi name];
     UIImageView * poiImage = [[UIImageView alloc] initWithImage:[curPoi imagePoi]];
     [cell.contentView addSubview:poiImage];
     [poiImage release];*/

    [self setUpCell:cell ForPoi:curPoi];
    
    return cell;
}

-(void)setUpCell:(UITableViewCell*)cell ForPoi:(Poi *)p{
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:TITLE_TAG];
    UILabel * subTitle = (UILabel *)[cell viewWithTag:SUBTITLE_TAG];
    UIImageView * poiImage = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
    
    titleLabel.text = [p name];
    subTitle.text = [p category];         
    poiImage.image = [p image];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return nil;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }   
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    NSArray * poisList = [[self.appDelegate cacheManager] poiByName];
    Poi * curPoi = [poisList objectAtIndex:indexPath.row];
    Description * curDesc = [curPoi description];
    
    if(self.descView == nil){
        DescViewController * viewController = [[DescViewController alloc] initWithNibName:@"DescViewController" bundle:nil];
        self.descView = viewController;
        [viewController release];
        [self.descView viewDidLoad];
    }
	[self.navigationController pushViewController:self.descView animated:YES];       
    //Set view attributes
    [self.descView setupView:curPoi];
}

- (void) resetPoiSortTab{
    [self.segmentedControl removeAllSegments];
    int i=0;
    for(NSString * sort in self.poiSortList){
        [self.segmentedControl insertSegmentWithTitle:sort atIndex:i animated:YES];
        i+=1;
    }
    self.segmentedControl.selectedSegmentIndex = 0;
}

- (void)dealloc {
    [poiCell release];
    [segmentedControl release];
    [tableView release];
    [super dealloc];
}


@end
