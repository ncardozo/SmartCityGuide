//
//  Itinerary.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 17/11/15.
//

#import "Itinerary.h"

@implementation ItineraryEN
- (NSString *) description {
    NSString *query = [NSString stringWithFormat:@"SELECT description FROM Itinerary WITH language = %@ AND iti_id = %d", @"en", [self itiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end

@implementation ItineraryFR
- (NSString *) description {
    NSString *query = [NSString stringWithFormat:@"SELECT description FROM Itinerary WITH language = %@ AND iti_id = %d", @"fr", [self itiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end

@implementation ItineraryNL
- (NSString *) description {
    NSString *query = [NSString stringWithFormat:@"SELECT description FROM Itinerary WITH language = %@ AND iti_id = %d", @"nl", [self itiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end

@implementation Itinerary
@synthesize itiId, itineraryPois, itineraryLenght, curPoiNb, descText;

- (id)initWithId:(int)ide descriptions:(NSString *) descs nb:(int)len pois:(NSArray *)poisList {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.itiId = itiId;
        self.itineraryLenght = len;
        self.itineraryPois = [NSArray arrayWithArray:poisList];
        self.descText = descs;
        self.curPoiNb = 0;
        [Itinerary setStrategy:[[NSClassFromString([NSString stringWithFormat:@"Itinerary%@", @"EN"]) alloc] init]];
    }
    
    return self;
}

- (NSString *) description {
    return [NSString stringWithFormat:@"ERR_INIT-%@", self.descText];
}

+ (void) setStrategy: (id) _strategy {
    self.strategy = _strategy;
}

@end