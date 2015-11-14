//
//  Itinerary.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 18/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Itinerary : NSObject{
    int itiId;
    NSArray * itineraryPois;
    NSDictionary * descriptions;
    int count;
    int curPoiNb;
}

@property (assign, nonatomic) int itiId;
@property (assign, nonatomic) int count;
@property (assign, nonatomic) int curPoiNb;
@property (retain, nonatomic) NSArray * itineraryPois;
@property (retain, nonatomic) NSDictionary * descriptions;

- (id)initWithId:(int)ide descriptions:(NSDictionary*)descs nb:(int)len pois:(NSArray*)poisList;
- (NSString*) description;

@end