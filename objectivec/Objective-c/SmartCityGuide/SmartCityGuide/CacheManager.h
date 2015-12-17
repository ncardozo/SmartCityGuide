//
//  CacheManager.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 17/12/16.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "GlobalConstants.h"
#import "SQLManager.h"
#import "Poi.h"
#import "CategoryPoi.h"

@interface BaseCacheManager : NSObject {
    
}

@end

@interface CacheManagerPreferredPois : BaseCacheManager {
    NSMutableArray *pois;
}

@property(nonatomic, retain) NSMutableArray *pois;

- (NSMutableArray*) poisList;
@end

@interface CacheManagerEN : BaseCacheManager
- (NSArray*) languageList;
- (NSString*) currentLang;
@end

@interface CacheManagerFR : BaseCacheManager
- (NSArray*) languageList;
- (NSString*) currentLang;
@end

@interface CacheManagerNL : BaseCacheManager
- (NSArray*) languageList;
- (NSString*) currentLang;
@end

@interface CacheManager : BaseCacheManager {

    //SQL objects
    SQLManager * sqlManager;
    NSMutableArray * poisList;
    NSMutableArray * descriptionsList;
    NSMutableArray * categoryList;
    NSMutableArray * itineraryList;
    Itinerary * activeItinerary;
    
    //Sorted poiList
    NSArray * poiByName;
    NSMutableDictionary * poiById;
    NSMutableDictionary * poiByCategory;
    NSMutableArray * removedPois;
    
    //Images
    NSMutableDictionary * imagesDico;
    
    id strategy;
}

@property (retain, nonatomic) NSMutableArray * poisList;
@property (retain, nonatomic) NSMutableArray * itineraryList;
@property (retain, nonatomic) NSMutableArray * descriptionsList;
@property (retain, nonatomic) SQLManager * sqlManager;
@property (retain, nonatomic) NSDictionary * langaguesDict;
@property (retain, nonatomic) NSMutableArray * categoryList;

@property (retain, nonatomic) NSArray * poiByName;
@property (retain, nonatomic) NSMutableDictionary * poiByCategory;
@property (retain, nonatomic) NSMutableDictionary * poiById;
@property (retain, nonatomic) NSMutableArray * removedPois;
@property (retain, nonatomic) NSMutableDictionary * imagesDico;
@property (retain, nonatomic) Itinerary * activeItinerary;

-(void) updatePois;
-(void) updateDescriptions;
-(void) updateCategories;
-(void) updateItineraries;
-(void) updatePreferedPois:(NSMutableArray*)selectedCategories;
-(void) updateImages;
-(void) updateSchedules;

-(NSArray *) langageList;
-(NSString*) currentLang;
- (void)updatePoisList:(NSNotification *)notification;

-(NSMutableArray*)poisList;
-(NSArray*) poiArray;

+ (void) setStrategy: _strategy;
+ (id) getStrategy;

@end