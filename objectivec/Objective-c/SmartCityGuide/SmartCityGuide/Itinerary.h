//
//  Itinerary.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 17/11/15.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"

@interface BaseItinireray : NSObject {}

@property(nonatomic) DBManager *dbManager;
@property(assign, nonatomic) int itiId;
@property(retain, nonatomic) NSString *descText;

- (NSString *) description;
@end

@interface ItineraryEN : BaseItinireray
- (NSString *) description;
@end

@interface ItineraryFR : BaseItinireray
- (NSString *) description;
@end

@interface ItineraryNL : BaseItinireray
- (NSString *) description;
@end


@interface Itinerary : BaseItinireray {
    int itiId;
    NSArray * itineraryPois;
    NSDictionary * descriptions;
    int count;
    int curPoiNb;
}

@property (assign, nonatomic) int count;
@property (assign, nonatomic) int curPoiNb;
@property (retain, nonatomic) NSArray * itineraryPois;


- (id)initWithId:(int)ide descriptions:(NSDictionary*)descs nb:(int)len pois:(NSArray*)poisList;
- (NSString*) description;
- (void) setStrategy: (id) _strategy;

@end