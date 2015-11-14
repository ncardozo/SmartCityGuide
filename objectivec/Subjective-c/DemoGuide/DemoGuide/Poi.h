//
//  Poi.h
//  MiniGuide
//
//  Created by Guillaume Kaisin on 23/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "CategoryPoi.h"
#import "Schedule.h"

@class Description;
@interface Poi : NSObject{
    int poiId;
    NSDictionary * names;
    NSDictionary * addresses;
    NSString * imagePoi;
    NSString * publicPoi;
    CLLocationDistance distFromCurLoc;
    float latitude;
    float longitude;
    Description * descriptions;
    NSMutableArray * categories;
    CategoryPoi * categoryPoi;
    
    NSMutableDictionary * imagesDico;
    
    Schedule * poiSchedule;
}

@property(assign, nonatomic) int poiId;
@property(retain, nonatomic) NSDictionary * names;
@property(retain, nonatomic) NSDictionary * addresses;
@property(retain, nonatomic) NSString * imagePoi;
@property(retain, nonatomic) NSString * publicPoi;
@property(assign, nonatomic) float latitude;
@property(assign, nonatomic) float longitude;
@property(retain, nonatomic) Description * descriptions;
@property(retain, nonatomic) NSMutableArray * categories;
@property(retain, nonatomic) NSMutableDictionary * imagesDico;
@property(retain, nonatomic) Schedule * poiSchedule;
@property(assign, nonatomic) CLLocationDistance distFromCurLoc;
@property(assign, nonatomic) CategoryPoi * categoryPoi;

-(id)initWithAddress:(NSDictionary*)addresses latitude:(double)latitude longitude:(double)longitude ident:(int)anId name:(NSDictionary*)namesDico imageUrl:(NSString*)anUrl;

-(Description*) description;
-(NSString*) descriptionString;
-(NSString*) category;
-(UIImage*) image;
-(NSString*) name;

-(NSComparisonResult) compareName:(Poi*)otherPoi;
- (int) distanceBetween:(CLLocationCoordinate2D)otherPlace;
//-(NSComparisonResult) belongToCategory:(CategoryPoi*) aCategory;
-(BOOL) isClosed;

@end