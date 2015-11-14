//
//  Poi_TIME.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Poi_TIME.h"

@implementation Poi (Poi_TIME)


- (UIImage*)Context_Morning_TimeAdaptation_image{
static const SEL __SCContextSelector = (SEL)"Context_Morning_TimeAdaptation_image";
static const SEL __SCOriginalSelector = (SEL)"image";

    NSString * url = [NSString stringWithFormat:@"%@%@", @"afternoon_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}


- (UIImage*)Context_Evening_TimeAdaptation_image{
static const SEL __SCContextSelector = (SEL)"Context_Evening_TimeAdaptation_image";
static const SEL __SCOriginalSelector = (SEL)"image";

    NSString * url = [NSString stringWithFormat:@"%@%@", @"evening_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}


/*
@contexts TimeAdaptation Morning
-(UIImage*)image{
    NSString * url = [NSString stringWithFormat:@"%@%@", @"morning_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}

@contexts TimeAdaptation Evening
- (UIImage*)image{
    NSString * url = [NSString stringWithFormat:@"%@%@", @"evening_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}
*/

@end
