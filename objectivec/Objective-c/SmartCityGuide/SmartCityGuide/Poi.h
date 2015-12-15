//
//  Poi.h
//  MiniGuide
//
//  Created by Nicolas Cardozo on 17/11/15.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CategoryPoi.h"
#import "Schedule.h"
#import "DBManager.h"
#import "Description.h"


@interface BasePoi : NSObject {}

@property(nonatomic) DBManager *dbManager;
@property(assign, nonatomic) int poiId;
@property(retain, nonatomic) Description *description;
@property(retain, nonatomic) NSMutableDictionary * imagesDico;
@property(retain, nonatomic) NSString *imagePoi;

- (NSString *) name;
- (NSString *) address;
- (NSString *) descriptionString;
- (UIImage *) image;
@end

@interface PoiEN : BasePoi
- (NSString *) name;
- (NSString *) address;
- (NSString *) descriptionString;
@end

@interface PoiFR : BasePoi
- (NSString *) name;
- (NSString *) address;
- (NSString *) descriptionString;
@end

@interface PoiNL : BasePoi
- (NSString *) name;
- (NSString *) address;
- (NSString *) descriptionString;
@end

@interface PoiMorning : BasePoi
- (UIImage *) image;
@end

@interface PoiEvening : BasePoi
- (UIImage *) image;
@end


@interface Poi : BasePoi{
    int poiId;
    NSString *name;
    NSString *addresses;
    NSString * imagePoi;
    NSString * publicPoi;
    CLLocationDistance distFromCurLoc;
    float latitude;
    float longitude;
    Description *description;
    NSMutableArray *categories;
    CategoryPoi  *categoryPoi;
    NSMutableDictionary *imagesDico;
    Schedule * poiSchedule;
    
    id strategy;
}

@property(retain, nonatomic) NSString *name;
@property(retain, nonatomic) NSString *address;
@property(retain, nonatomic) NSString *publicPoi;
@property(assign, nonatomic) float latitude;
@property(assign, nonatomic) float longitude;
@property(retain, nonatomic) NSMutableArray * categories;
@property(retain, nonatomic) Schedule * poiSchedule;
@property(assign, nonatomic) CLLocationDistance distFromCurLoc;
@property(nonatomic) CategoryPoi *categoryPoi;

-(id)initWithAddress:(NSDictionary*)addresses latitude:(double)latitude longitude:(double)longitude ident:(int)anId name:(NSDictionary*)namesDico imageUrl:(NSString*)anUrl;

-(BaseDescription *) description;
-(NSString *) descriptionString;
-(NSString *) category;
-(UIImage *) image;
-(NSString *) name;

-(NSComparisonResult) compareName:(Poi *) otherPoi;
-(int) distanceBetween:(CLLocationCoordinate2D) otherPlace;
-(BOOL) isClosed;

+(void) setStrategy: (id) _strategy;
@end