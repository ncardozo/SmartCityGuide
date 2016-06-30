//
//  POIViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//

#import "POIViewController.h"

@implementation POIViewController
@synthesize poiCell;
@synthesize appDelegate;
@synthesize descView;
@synthesize categoryPoiDict;
@synthesize poiCell_KID, poiCell_CATEGORY;
@synthesize tableView, segmentedControl, poiSortList, normalSortList, itiSortList;

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
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

- (void)viewDidUnload {
    [self setPoiCell:nil];
    segmentedControl = nil;
    tableView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
    [self resetPoiSortTab];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source
- (IBAction)modifyPoiOrder:(id)sender {
    long index = self.segmentedControl.selectedSegmentIndex;
    long maxIndex = self.segmentedControl.numberOfSegments;
    
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"CategoryPoiOrder"];
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"ItineraryPoiOrder"];
    
    if(maxIndex == 3) { // Guided tour active
        if(index==0){
            [[SCContextManager sharedContextManager] activateContextWithName:@"ItineraryPoiOrder"];
        } else if(index==2) {
            [[SCContextManager sharedContextManager] activateContextWithName:@"CategoryPoiOrder"];
        }
    } else if(maxIndex==2) { // Guided tour inactive
        if(index==1) {
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

-(CGFloat) tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 80;
}

-(NSString*) tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return nil;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    NSArray * poisList = [[self.appDelegate cacheManager] poiByName];
    Poi * curPoi = [poisList objectAtIndex:indexPath.row];
    Description * curDesc = [curPoi description];
    
    if(self.descView == nil) {
        DescViewController * viewController = [[DescViewController alloc] initWithNibName:@"DescViewController" bundle:nil];
        self.descView = viewController;
        [self.descView viewDidLoad];
    }
	[self.navigationController pushViewController:self.descView animated:YES];       
    //Set view attributes
    [self.descView setupView:curPoi];
}

- (void) resetPoiSortTab{
    [self.segmentedControl removeAllSegments];
    int i=0;
    for(NSString * sort in self.poiSortList) {
        [self.segmentedControl insertSegmentWithTitle:sort atIndex:i animated:YES];
        i+=1;
    }
    self.segmentedControl.selectedSegmentIndex = 0;
}

@end