//
//  POiViewController_ITINERARY.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "POiViewController_ITINERARY.h"

@implementation POIViewController (POiViewController_ITINERARY)

@contexts ItineraryPoiOrder
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
        imgUrl = [NSString stringWithFormat:@"number%d", indexPath.row+1];
    } else {
        imgUrl = [NSString stringWithFormat:@"number%d_grey", indexPath.row+1];
    }
    itiImage.image = [self.appDelegate.cacheManager.imagesDico objectForKey:imgUrl];
    
    [self setUpCell:cell ForPoi:curPoi];
    
    return cell;
}

@contexts ItineraryPoiOrder
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.appDelegate.cacheManager.activeItinerary.itineraryPois count];
}

@contexts ItineraryPoiOrder
- (void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSArray * poisList = [[[self.appDelegate cacheManager] activeItinerary] itineraryPois];
    Poi * curPoi = [poisList objectAtIndex:indexPath.row];
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