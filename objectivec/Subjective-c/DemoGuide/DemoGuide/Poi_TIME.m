//
//  Poi_TIME.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//

#import "Poi_TIME.h"

@implementation Poi (Poi_TIME)

@contexts Morning TimeAdaptation
- (UIImage*)image {
    NSString * url = [NSString stringWithFormat:@"%@%@", @"afternoon_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}

@contexts Evening TimeAdaptation
- (UIImage*) image{
    NSString * url = [NSString stringWithFormat:@"%@%@", @"evening_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}

@end