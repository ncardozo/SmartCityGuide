//
//  POIViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "POIViewController.h"

@implementation BasePOIViewController
@synthesize poiCell;
@synthesize appDelegate;
@synthesize descView;

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
@end

@implementation POIViewControllerGuidedTourEN
-(NSArray *) poiSortList{
    return [self.itiSortList objectForKey:@"en"];
}

@end

@implementation POIViewControllerGuidedTourNL
-(NSArray *) poiSortList{
    return [self.itiSortList objectForKey:@"nl"];
}

@end

@implementation POIViewControllerGuidedTourFR
-(NSArray *) poiSortList{
    return [self.itiSortList objectForKey:@"fr"];
}

@end

@implementation POIViewControllerEN
-(NSArray *) poiSortList{
    return [self.normalSortList objectForKey:@"en"];
}

@end

@implementation POIViewControllerNL
-(NSArray *) poiSortList{
    return [self.normalSortList objectForKey:@"nl"];
}

@end

@implementation POIViewControllerFR
-(NSArray *) poiSortList{
    return [self.normalSortList objectForKey:@"fr"];
}

@end

@implementation POIViewControllerTime
- (void)setUpCell:(UITableViewCell*)cell ForPoi:(Poi *)p {
    BOOL pClosed = [p isClosed];
    if(pClosed){
        UIImageView * closedImage = (UIImageView *)[cell viewWithTag:CLOSED_TAG];
        closedImage.image = [[p imagesDico] objectForKey:@"closed"];
    }
    
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:TITLE_TAG];
    UILabel * subTitle = (UILabel *)[cell viewWithTag:SUBTITLE_TAG];
    UIImageView * poiImage = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
    
    titleLabel.text = [p name];
    subTitle.text = [p category];
    poiImage.image = [p image];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
}

@end

@implementation POIViewControllerKid
@synthesize poiCell_KID;
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    NSMutableArray * poisList = [[self.appDelegate cacheManager] poisList];
    Poi * curPoi = [poisList objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        /*cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];*/
        [[NSBundle mainBundle] loadNibNamed:@"POIViewCell_KID" owner:self options:nil];
        cell = poiCell_KID;
        self.poiCell_KID = nil;
    }
    
    // Configure the cell...
    /*cell.textLabel.text = [curPoi name];
     UIImageView * poiImage = [[UIImageView alloc] initWithImage:[curPoi imagePoi]];
     [cell.contentView addSubview:poiImage];
     [poiImage release];*/
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:TITLE_TAG];
    UIImageView * poiImage = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
    
    titleLabel.text = [curPoi name];
    poiImage.image = [curPoi image];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)index {
    return 120;
}

@end

@implementation POIViewControllerGuidedTour
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    NSArray * poisList = [[[self.appDelegate cacheManager] activeItinerary] itineraryPois];
    Poi * curPoi = [poisList objectAtIndex:indexPath.row];
    Itinerary * curIti = [self.appDelegate.cacheManager activeItinerary];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"POIViewCell" owner:self options:nil];
        cell = poiCell;
        self.poiCell = nil;
    }
    
    BOOL nextPoi = (indexPath.row == curIti.curPoiNb);
    UIImageView * itiImage = (UIImageView *)[cell viewWithTag:ITI_TAG];
    NSString * imgUrl;
    if(nextPoi) {
        imgUrl = [NSString stringWithFormat:@"number%ld", indexPath.row+1];
    } else {
        imgUrl = [NSString stringWithFormat:@"number%ld_grey", indexPath.row+1];
    }
    itiImage.image = [self.appDelegate.cacheManager.imagesDico objectForKey:imgUrl];
    
    [self setUpCell:cell ForPoi:curPoi];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.appDelegate.cacheManager.activeItinerary.itineraryPois count];
}

- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * poisList = [[[self.appDelegate cacheManager] activeItinerary] itineraryPois];
    Poi * curPoi = [poisList objectAtIndex:indexPath.row];
    Description *curDesc = [curPoi description];
    
    if(self.descView == nil){
        DescViewController * viewController = [[DescViewController alloc] initWithNibName:@"DescViewController" bundle:nil];
        self.descView = viewController;
        [self.descView viewDidLoad];
    }
    [self.navigationController pushViewController:self.descView animated:YES];
    //Set view attributes
    [self.descView setupView:curPoi];
}

@end

@implementation POIViewControllerCategory
@synthesize poiCell_CATEGORY;
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
    return[[poisList allKeys] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
    NSMutableArray * array = [poisList objectForKey:[[poisList allKeys] objectAtIndex:section]];
    return [array count];
}

- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
    return [[poisList allKeys] objectAtIndex:section];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
    NSMutableArray * array = [poisList objectForKey:[[poisList allKeys] objectAtIndex:indexPath.section]];
    
    Poi * curPoi = [array objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        [[NSBundle mainBundle] loadNibNamed:@"POIViewCell" owner:self options:nil];
        cell = poiCell;
        self.poiCell = nil;
    }
    
    UILabel * titleLabel = (UILabel *)[cell viewWithTag:TITLE_TAG];
    UILabel * subTitle = (UILabel *)[cell viewWithTag:SUBTITLE_TAG];
    UIImageView * poiImage = (UIImageView *)[cell viewWithTag:IMAGE_TAG];
    
    titleLabel.text = [curPoi name];
    subTitle.text = [curPoi address];
    poiImage.image = [curPoi image];
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poiByCategory];
    NSMutableArray * array = [poisList objectForKey:[[poisList allKeys] objectAtIndex:indexPath.section]];
    
    Poi * curPoi = [array objectAtIndex:indexPath.row];
    Description * curDesc = [curPoi description];
    
    if(self.descView == nil){
        DescViewController * viewController = [[DescViewController alloc] initWithNibName:@"DescViewController" bundle:nil];
        self.descView = viewController;
        [self.descView viewDidLoad];
    }
    [self.navigationController pushViewController:self.descView animated:YES];
    //Set view attributes
    [self.descView setupView:curPoi];
}

@end

@implementation POIViewController
@synthesize categoryPoiDict;
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
    
    [POIViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"BasePOIViewController"]) alloc] init]];
    
    if(maxIndex == 3) { // Guided tour active
        if(index==0){
            [POIViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"POIViewController%@", @"GuidedTour"]) alloc] init]];
        } else if(index==2) {
            [POIViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"POIViewController%@", @"Category"]) alloc] init]];
        }
    } else if(maxIndex==2) { // Guided tour inactive
        if(index==1) {
            [POIViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"POIViewController%@", @"GuidedTour"]) alloc] init]];
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