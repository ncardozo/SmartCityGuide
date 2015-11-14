//
//  POIViewController_TIME.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 07/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "POIViewController_TIME.h"

@implementation POIViewController (POIViewController_TIME)


@contexts TimeAdaptation
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

/*
 @contexts TimeAdaptation
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
 */

@end
