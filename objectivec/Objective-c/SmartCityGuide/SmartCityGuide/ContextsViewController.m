//
//  ContextsViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContextsViewController.h"

@implementation ContextsViewController
@synthesize contextNames, sectionNames, cacheManager;

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
    NSArray * languages = [[NSArray alloc] initWithObjects:@"French",@"English",@"Dutch",nil];
    NSArray * classifications = [[NSArray alloc] initWithObjects:@"CategoryPoiOrder", @"ItineraryPoiOrder",nil];
    
    NSArray * timeOfDay = [[NSArray alloc] initWithObjects:@"Morning", @"Afternoon", @"Evening", nil];
    NSArray * connections = [[NSArray alloc] initWithObjects:@"Connected", @"ConnectedWifi", @"Connected3G", nil];
    NSArray * usage = [[NSArray alloc] initWithObjects:@"LowMemory", @"LowBattery",@"GPS", nil];
    NSArray * others = [[NSArray alloc] initWithObjects:@"TimeAdaptation", @"SimpleInterface",@"PreferedPois",@"GuidedTour", nil];

    
    contextNames = [[NSArray alloc] initWithObjects: languages, classifications, timeOfDay, connections, usage, others, nil];
    sectionNames = [[NSArray alloc] initWithObjects: @"Language", @"Classifications", @"Time detection", @"Connections", @"Usage",@"Others", nil];
    
    DemoGuideAppDelegate * appDelegate = (DemoGuideAppDelegate *)[[UIApplication sharedApplication] delegate];
    self.cacheManager = [appDelegate cacheManager];
    
    [super viewDidLoad];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView reloadData];
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	return [self.sectionNames objectAtIndex:section];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [sectionNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger) sectionPosition {
    // Return the number of rows in the section.
    return [[self.contextNames objectAtIndex: sectionPosition] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    NSString * contextName = [[self.contextNames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    cell.textLabel.text = contextName;
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    UIImageView *imageView;
    if(cell.isSelected){
        imageView = [[UIImageView alloc] initWithImage:[[self.cacheManager imagesDico] objectForKey:@"accept"]];
    }
    else imageView = [[UIImageView alloc] initWithImage:[[self.cacheManager imagesDico] objectForKey:@"cancel"]];
    cell.accessoryView = imageView;
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

@end