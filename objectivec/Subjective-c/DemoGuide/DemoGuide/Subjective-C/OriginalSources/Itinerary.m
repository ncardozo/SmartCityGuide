//
//  Itinerary.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 18/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Itinerary.h"

@implementation Itinerary
@synthesize itiId, itineraryPois, count, curPoiNb, descriptions;

- (id)initWithId:(int)ide descriptions:(NSDictionary*)descs nb:(int)len pois:(NSArray*)poisList
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.itiId = itiId;
        self.count = len;
        self.itineraryPois = [NSArray arrayWithArray:poisList];
        self.descriptions = descs;
        self.curPoiNb = 0;
    }
    
    return self;
}

- (NSString *) description{
    return [NSString stringWithFormat:@"ERR_INIT-%@", [self.descriptions objectForKey:@"fr"]];
}


@end
