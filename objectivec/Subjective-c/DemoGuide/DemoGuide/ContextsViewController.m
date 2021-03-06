//
//  ContextsViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
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
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return [sectionNames count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [[self.contextNames objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    NSString * contextName = [[self.contextNames objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];
    SCContext * context = [[SCContextManager sharedContextManager]
                           contextWithName:contextName];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    cell.textLabel.text = contextName;
    cell.selectionStyle = UITableViewCellEditingStyleNone;
    
    UIImageView *imageView;
    if(context.isActive){
        imageView = [[UIImageView alloc] initWithImage:[[self.cacheManager imagesDico] objectForKey:@"accept"]];
    }
    else imageView = [[UIImageView alloc] initWithImage:[[self.cacheManager imagesDico] objectForKey:@"cancel"]];
    cell.accessoryView = imageView;
    [imageView release];
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