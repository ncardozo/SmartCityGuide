//
//  POIViewController_CATEGORY.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 11/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "POIViewController_CATEGORY.h"

@implementation POIViewController (POIViewController_CATEGORY)

@contexts CategoryPoiOrder
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
    return[[poisList allKeys] count];
}

@contexts CategoryPoiOrder
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
    NSMutableArray * array = [poisList objectForKey:[[poisList allKeys] objectAtIndex:section]];
    return [array count];
}

@contexts CategoryPoiOrder
- (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
    return [[poisList allKeys] objectAtIndex:section];
}

@contexts CategoryPoiOrder
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

@contexts CategoryPoiOrder
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poiByCategory];
    NSMutableArray * array = [poisList objectForKey:[[poisList allKeys] objectAtIndex:indexPath.section]];
    
    Poi * curPoi = [array objectAtIndex:indexPath.row];
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

/*
 @contexts CategoryPoiOrder
 - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
 // Return the number of sections.
 NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
 return[[poisList allKeys] count];
 }
 
 @contexts CategoryPoiOrder
 - (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
 // Return the number of rows in the section.
 NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
 NSMutableArray * array = [poisList objectForKey:[[poisList allKeys] objectAtIndex:section]];
 return [array count];
 }
 
 @contexts CategoryPoiOrder
 - (NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
 NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poisByCategory];
 return [[poisList allKeys] objectAtIndex:section];
 }
 
 @contexts CategoryPoiOrder
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
 
 @contexts CategoryPoiOrder
 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
 // Navigation logic may go here. Create and push another view controller.
 NSMutableDictionary * poisList = [[self.appDelegate cacheManager] poiByCategory];
 NSMutableArray * array = [poisList objectForKey:[[poisList allKeys] objectAtIndex:indexPath.section]];
 
 Poi * curPoi = [array objectAtIndex:indexPath.row];
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
*/


@end
