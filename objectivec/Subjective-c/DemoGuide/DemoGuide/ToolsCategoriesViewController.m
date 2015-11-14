//
//  ToolsCategoriesViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 04/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ToolsCategoriesViewController.h"

@implementation ToolsCategoriesViewController
@synthesize appDelegate, selectedCategories;

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
    self.appDelegate = (DemoGuideAppDelegate *)[[UIApplication sharedApplication] delegate];

    self.selectedCategories = [[NSMutableArray alloc] init];
    int max = [[[self.appDelegate cacheManager] categoryList] count];
    for(NSInteger i=0; i<max;i++){
        [self.selectedCategories addObject:[NSNumber numberWithBool:YES]];
    }

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
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [[self.appDelegate cacheManager] updatePreferedPois:self.selectedCategories];
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[[self.appDelegate cacheManager] categoryList] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryPoi * category = [[[self.appDelegate cacheManager] categoryList] objectAtIndex:indexPath.row];
    NSString * catTitle = [category name];
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = catTitle;
    cell.textLabel.textColor = [UIColor blackColor];
    if([[self.selectedCategories objectAtIndex:indexPath.row] boolValue]) cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    int nbSelectedCat=0;
    for(NSInteger i=0; i<[self.selectedCategories count]; i++){
        if([[self.selectedCategories objectAtIndex:i] boolValue]) nbSelectedCat++;
    }
    
    int selectedRow = indexPath.row;
    UITableViewCell *cell =[tableView cellForRowAtIndexPath:indexPath];
    if([[self.selectedCategories objectAtIndex:selectedRow] boolValue] && nbSelectedCat!=1) {
        cell.accessoryType = UITableViewCellAccessoryNone;
        [self.selectedCategories replaceObjectAtIndex:selectedRow withObject:[NSNumber numberWithBool:NO]];
    } else {
        cell.accessoryType = UITableViewCellAccessoryCheckmark; 
        [self.selectedCategories replaceObjectAtIndex:selectedRow withObject:[NSNumber numberWithBool:YES]];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

@end