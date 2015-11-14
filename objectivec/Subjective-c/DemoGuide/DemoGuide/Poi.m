//
//  Poi.m
//  MiniGuide
//
//  Created by Guillaume Kaisin on 23/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Poi.h"

@implementation Poi
@synthesize addresses, latitude, names, poiId, longitude, descriptions, imagePoi, publicPoi, categories;
@synthesize imagesDico, poiSchedule, distFromCurLoc, categoryPoi;

-(id)initWithAddress:(NSDictionary*)addressDico latitude:(double)aLat longitude:(double)aLong ident:(int)anId name:(NSDictionary*)namesDico imageUrl:(NSString*)anUrl {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.poiId = anId;
        self.addresses = addressDico;
        self.latitude = aLat;
        self.longitude = aLong;
        self.names = namesDico;
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
    return [self.names objectForKey:@"fr"];
}

-(NSString*) address{
    return [NSString stringWithFormat:@"INIT_ERROR-%@", [self.addresses objectForKey:@"fr"]];
}

-(NSString*) name{
    return [NSString stringWithFormat:@"INIT_ERROR-%@", [self.names objectForKey:@"fr"]];
}

- (BOOL) isClosed{
    NSDate *now = [NSDate date];
    return ![self.poiSchedule isInSchedule:now];
    /*NSCalendar *calendar = [NSCalendar currentCalendar];
    
    unsigned int unitFlags = NSHourCalendarUnit|NSMinuteCalendarUnit;
    NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
    
    NSInteger hour = [comp hour];
    NSInteger minute = [comp minute];
    
    NSString * nowHours = [NSString stringWithFormat:@"%d:%d", hour, minute];
    NSDate * toCheck  = */
    
}

-(NSString*) category{
    NSMutableArray * catNameArray = [[NSMutableArray alloc] init];
    for(CategoryPoi * cat in self.categories){
        [catNameArray addObject:[cat name]];
    }
    NSString * categoriesNames = [catNameArray componentsJoinedByString:@", "];
    [catNameArray release];
    return categoriesNames;
}

-(UIImage*) image{
    
    NSString * url = [NSString stringWithFormat:@"%@%@", @"afternoon_", self.imagePoi];
    return [self.imagesDico objectForKey:url];
}

-(NSComparisonResult) compareName:(Poi *)otherPoi{
    NSString * myName = [self name];
    NSString * otherName = [otherPoi name];
    NSComparisonResult result = [myName compare:otherName];
    return result;
}

-(NSString*) descriptionString{
    return [self.descriptions description];
}

@end