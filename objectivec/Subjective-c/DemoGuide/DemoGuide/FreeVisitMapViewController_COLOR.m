//
//  FreeVisitMapViewController_COLOR.m
//  DemoGuide
//
//  Created by Kim Mens on 13/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FreeVisitMapViewController_COLOR.h"

@implementation FreeVisitMapViewController (FreeVisitMapViewController_COLOR)

@contexts ColoredCategories
- (UIImageView*)getPinLook:(Poi*)p {
    
    UIImage * image;
    NSString * pCategory = [p category];
    if([pCategory compare:@"Culture"]==0){
        image = [[self.cacheManager imagesDico] objectForKey:@"green_pin"];
    }
    else if([pCategory compare:@"Divertissement"]==0){
        image = [[self.cacheManager imagesDico] objectForKey:@"blue_pin"];
    }
    else if([pCategory compare:@"Shopping"]==0){
        image = [[self.cacheManager imagesDico] objectForKey:@"pink_pin"];
    }
    else{
        image = [[self.cacheManager imagesDico] objectForKey:@"yellow_pin"];
    }
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
    return imageView;
}

@end