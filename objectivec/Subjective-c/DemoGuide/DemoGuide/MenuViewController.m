//
//  MenuViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 09/12/11.
//

#import "MenuViewController.h"

@implementation MenuViewController
@synthesize menuTitles, visitTitles;
@synthesize poiView, mapView, guidedView, cacheManager;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];

    self.menuTitles = [NSArray arrayWithObjects:@"Points of interest", @"Visits", nil];
    self.visitTitles = [NSArray arrayWithObjects:@"Guided tour", @"Free tour", nil];
    
    DemoGuideAppDelegate * appDelegate = (DemoGuideAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.cacheManager = [appDelegate cacheManager];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
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
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.menuTitles count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if(section==1) return [self.visitTitles count];
    else return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    int section = indexPath.section;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    if(section == 0){//POI
        cell.textLabel.text = [self.menuTitles objectAtIndex:indexPath.section];
        cell.imageView.image = [[self.cacheManager imagesDico] objectForKey:@"info"];
    }
    else if(section == 1){//VISITS
        cell.textLabel.text = [self.visitTitles objectAtIndex:indexPath.row];
        if(indexPath.row==0)cell.imageView.image = [[self.cacheManager imagesDico] objectForKey:@"milestone"];
        else cell.imageView.image = [[self.cacheManager imagesDico] objectForKey:@"earth"];
    }
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	if(section==1) return [self.menuTitles objectAtIndex:section];
    else return @"";
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    long selectedRow = indexPath.row;
    long selectedSection = indexPath.section;

    if(selectedSection==0) [self loadPoisList];
    else if(selectedSection==1 && selectedRow==0) [self loadGuidedTour];
    else [self loadFreeTour];

}

-(void) loadGuidedTour{
    if(self.guidedView == nil){
        GuidedVisitMapController * viewController = [[GuidedVisitMapController alloc] initWithNibName:@"GuidedVisitMapController" bundle:nil];
        self.guidedView = viewController;
        [viewController release];
        [self.guidedView viewDidLoad];
    }
    [self.navigationController pushViewController:self.guidedView animated:YES]; 
}

-(void) loadFreeTour{
    if(self.mapView == nil){
        
        FreeVisitMapViewController * viewController = [[FreeVisitMapViewController alloc] initWithNibName:@"FreeVisitMapViewController" bundle:nil];
        self.mapView = viewController;
        [viewController release];
        [self.mapView viewDidLoad];
    }
    [self.navigationController pushViewController:self.mapView animated:YES]; 
}

-(void) loadPoisList{
    if(self.poiView == nil){
        POIViewController * viewController = [[POIViewController alloc] initWithNibName:@"POIViewController" bundle:nil];
        self.poiView = viewController;
        [viewController release];
        [self.poiView viewDidLoad];
    }
    [self.navigationController pushViewController:self.poiView animated:YES]; 
}

@end