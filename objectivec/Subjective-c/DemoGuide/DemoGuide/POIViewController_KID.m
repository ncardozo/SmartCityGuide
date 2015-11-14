//
//  POIViewController_KID.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 04/12/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "POIViewController_KID.h"

@implementation POIViewController (POIViewController_KID)

@contexts SimpleInterface
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

@contexts SimpleInterface
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)index {
    return 120;
}

@end