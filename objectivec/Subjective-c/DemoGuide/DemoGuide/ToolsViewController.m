//  ToolsViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ToolsViewController.h"

@implementation ToolsViewController
@synthesize toolsOption, appDelegate;
@synthesize langView, catView, updateMessage, updateAlert;

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
    
    self.toolsOption = [[NSArray alloc] initWithObjects:@"Language", @"Categories", @"Time adaptation", @"SimpleInterface", @"Low Memory", @"Low Battery", @"Colored categories", @"Update data",  nil];
    self.appDelegate = (DemoGuideAppDelegate *)[[UIApplication sharedApplication] delegate];
    [super viewDidLoad];
    
    self.updateAlert = [[UpdateAlertViewController alloc] init];

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
    [[SCContextManager sharedContextManager] activateContextWithName:@"RefreshPoiMap"];
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

-(void) timeAdaptationToggled{
    SCContext * context = [[SCContextManager sharedContextManager]
                           contextWithName:@"TimeAdaptation"];
    if(context.isActive) {
        [[SCContextManager sharedContextManager] deactivateContextWithName:@"TimeAdaptation"];
    } else [[SCContextManager sharedContextManager] activateContextWithName:@"TimeAdaptation"];
}

-(void) SimpleInterfaceAdaptationToggled{
    SCContext * context = [[SCContextManager sharedContextManager]
                           contextWithName:@"SimpleInterface"];
    if(context.isActive) {
        [[SCContextManager sharedContextManager] deactivateContextWithName:@"SimpleInterface"];
    } else {
        [[SCContextManager sharedContextManager] activateContextWithName:@"SimpleInterface"];
    }
}

-(void) MemoryAdaptationToggled{
    SCContext * context = [[SCContextManager sharedContextManager]
                           contextWithName:@"LowMemory"];
    if(context.isActive) {
        [[SCContextManager sharedContextManager] deactivateContextWithName:@"LowMemory"];
    } else {
        [[SCContextManager sharedContextManager] activateContextWithName:@"LowMemory"];
    }
}

-(void) BatteryAdaptationToggled{
    SCContext * context = [[SCContextManager sharedContextManager]
                           contextWithName:@"LowBattery"];
    if(context.isActive) {
        [[SCContextManager sharedContextManager] deactivateContextWithName:@"LowBattery"];
    } else {
        [[SCContextManager sharedContextManager] activateContextWithName:@"LowBattery"];
    }
}

-(void) ColorAdaptationToggled{
    SCContext * context = [[SCContextManager sharedContextManager]
                           contextWithName:@"ColoredCategories"];
    if(context.isActive) {
        [[SCContextManager sharedContextManager] deactivateContextWithName:@"ColoredCategories"];
    } else {
        [[SCContextManager sharedContextManager] activateContextWithName:@"ColoredCategories"];
        [[SCContextManager sharedContextManager] activateContextWithName:@"RefreshPoiMap"];
    }
}


#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [self.toolsOption count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    long section = indexPath.section;
    NSString * sectionName = [self.toolsOption objectAtIndex:section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = sectionName;
    if(section == 0){//LANGUAGES
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        cell.detailTextLabel.text = [[self.appDelegate cacheManager] currentLang];
    } else if(section == 1){//CATEGORIES
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    } else if(section==2 && cell.accessoryView==nil){//TIME OF DAY
        UISwitch * timeAdaptation = [[UISwitch alloc] initWithFrame:CGRectZero];
        [timeAdaptation addTarget:self action:@selector(timeAdaptationToggled) forControlEvents: UIControlEventTouchUpInside];
        [timeAdaptation setOn:NO animated:NO];
        [cell addSubview:timeAdaptation];
        cell.accessoryView = timeAdaptation;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if(section==3 && cell.accessoryView==nil){//KID
        UISwitch * kidAdaptation = [[UISwitch alloc] initWithFrame:CGRectZero];
        [kidAdaptation addTarget:self action:@selector(SimpleInterfaceAdaptationToggled) forControlEvents: UIControlEventTouchUpInside];
        [kidAdaptation setOn:NO animated:NO];
        [cell addSubview:kidAdaptation];
        cell.accessoryView = kidAdaptation;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if(section==4 && cell.accessoryView==nil){//MEMORY
        UISwitch * memoryAdaptation = [[UISwitch alloc] initWithFrame:CGRectZero];
        [memoryAdaptation addTarget:self action:@selector(MemoryAdaptationToggled) forControlEvents: UIControlEventTouchUpInside];
        [memoryAdaptation setOn:NO animated:NO];
        [cell addSubview:memoryAdaptation];
        cell.accessoryView = memoryAdaptation;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if(section==5 && cell.accessoryView==nil){//BATTERY
        UISwitch * batteryAdaptation = [[UISwitch alloc] initWithFrame:CGRectZero];
        [batteryAdaptation addTarget:self action:@selector(BatteryAdaptationToggled) forControlEvents: UIControlEventTouchUpInside];
        [batteryAdaptation setOn:NO animated:NO];
        [cell addSubview:batteryAdaptation];
        cell.accessoryView = batteryAdaptation;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if(section==6 && cell.accessoryView==nil){//COLORED ANNOTATIONS
        UISwitch * colorAdaptation = [[UISwitch alloc] initWithFrame:CGRectZero];
        [colorAdaptation addTarget:self action:@selector(ColorAdaptationToggled) forControlEvents: UIControlEventTouchUpInside];
        [colorAdaptation setOn:NO animated:NO];
        [cell addSubview:colorAdaptation];
        cell.accessoryView = colorAdaptation;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    } else if(section==7){
        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.detailTextLabel.text = @"";
    }
    
    return cell;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    long section = indexPath.section;
    
    if(section==0){//LANGUAGE
        if(self.langView == nil){
            ToolsLangViewController * viewController = [[ToolsLangViewController alloc] initWithNibName:@"ToolsLangViewController" bundle:nil];
            self.langView = viewController;
        }
        self.langView.langList = [[self.appDelegate cacheManager] langageList];
        [self.navigationController pushViewController:self.langView animated:YES];
    } else if(section==1){//CATEGORIES
        if(self.catView == nil){
            ToolsCategoriesViewController * viewController = [[ToolsCategoriesViewController alloc] initWithNibName:@"ToolsCategoriesViewController" bundle:nil];
            self.catView = viewController;
        }
        [self.navigationController pushViewController:self.catView animated:YES];
    } else if(section==7){
        [self updateDataAction];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
    }
}

@end