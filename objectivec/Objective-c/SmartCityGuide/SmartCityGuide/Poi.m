//
//  Poi.m
//  MiniGuide
//
//  Created by Nicolas Cardozo on 17/11/15.
//

#import "Poi.h"

@implementation PoiEN
- (NSString *) name {
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Poi WITH language = %@ AND id_poi = %d", @"en", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

- (NSString *) address {
    NSString *query = [NSString stringWithFormat:@"SELECT address FROM Poi WITH language = %@ AND id_poi = %d", @"en", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

- (NSString *) descriptionString {
    [[self description] setStrategy: [[NSClassFromString([NSString stringWithFormat:@"Description%@", @"EN"]) alloc] init]];
    return [[self description] description];
}
@end

@implementation PoiFR
- (NSString *) name {
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Poi WITH language = %@ AND id_poi = %d", @"fr", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

- (NSString *) address {
    NSString *query = [NSString stringWithFormat:@"SELECT address FROM Poi WITH language = %@ AND id_poi = %d", @"fr", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

- (NSString *) descriptionString {
    [[self description] setStrategy: [[NSClassFromString([NSString stringWithFormat:@"Description%@", @"FR"]) alloc] init]];
    return [[self description] description];
}
@end

@implementation PoiNL
- (NSString *) name {
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Poi WITH language = %@ AND id_poi = %d", @"nl", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

- (NSString *) address {
    NSString *query = [NSString stringWithFormat:@"SELECT address FROM Poi WITH language = %@ AND id_poi = %d", @"nl", [self poiId]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}

- (NSString *) descriptionString {
    [[self description] setStrategy: [[NSClassFromString([NSString stringWithFormat:@"Description%@", @"NL"]) alloc] init]];
    return [[self description] description];
}
@end

@implementation PoiMorning
- (UIImage *) image {
    NSString * url = [NSString stringWithFormat:@"%@%@", @"morning_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}
@end

@implementation PoiEvening
- (UIImage *) image {
    NSString * url = [NSString stringWithFormat:@"%@%@", @"evening_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}
@end

@implementation Poi
@synthesize address, latitude, name, poiId, longitude, description, imagePoi, publicPoi, categories;
@synthesize imagesDico, poiSchedule, distFromCurLoc, categoryPoi;

-(id)initWithAddress:(NSString *) newAddress latitude:(double)aLat longitude:(double)aLong ident:(int)anId name:(NSString *) newName imageUrl:(NSString*) anUrl {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.poiId = anId;
        self.address = newAddress;
        self.latitude = aLat;
        self.longitude = aLong;
        self.name = newName;
        self.imagePoi = anUrl;
        self.categories = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (int) distanceBetween:(CLLocationCoordinate2D)otherPlace{
    CLLocationCoordinate2D poiCoord;
    poiCoord.latitude = self.latitude;
    poiCoord.longitude = self.longitude;
    MKMapPoint p1 = MKMapPointForCoordinate(poiCoord);
    MKMapPoint p2 = MKMapPointForCoordinate(otherPlace);
    CLLocationDistance dist = MKMetersBetweenMapPoints(p1, p2);
    self.distFromCurLoc = dist;
    return dist;
}

-(NSString*) description{
    return [NSString stringWithFormat:@"INIT_ERROR-%@", @"description"];
}

-(NSString*) address{
    return [NSString stringWithFormat:@"INIT_ERROR-%@", @"address"];
}

-(NSString*) name {
    return [NSString stringWithFormat:@"INIT_ERROR-%@", @"name"];
}

-(NSString*) descriptionString {
    return [NSString stringWithFormat:@"INIT_ERROR-%@", @"descriptionText"];
}

-(UIImage*) image{
    return [UIImage imageNamed:[NSString stringWithFormat:@"INIT_ERROR-%@", @"image"]];
}

- (BOOL) isClosed{
    NSDate *now = [NSDate date];
    return ![self.poiSchedule isInSchedule:now];
}

-(NSString*) category {
    NSMutableArray * catNameArray = [[NSMutableArray alloc] init];
    for(CategoryPoi * cat in self.categories){
        [catNameArray addObject:[cat name]];
    }
    NSString * categoriesNames = [catNameArray componentsJoinedByString:@", "];
    return categoriesNames;
}

-(NSComparisonResult) compareName:(Poi *)otherPoi{
    NSString * myName = [self name];
    NSString * otherName = [otherPoi name];
    NSComparisonResult result = [myName compare:otherName];
    return result;
}

-(void) setStrategy:(id)_strategy {
    self.strategy = _strategy;
}

@end