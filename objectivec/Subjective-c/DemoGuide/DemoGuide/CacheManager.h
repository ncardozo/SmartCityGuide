//
//  CacheManager.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "SQLManager.h"
#import "Poi.h"
#import "CategoryPoi.h"

@interface CacheManager : NSObject{

    NSDictionary * langaguesDict;
    
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
    NSMutableArray * preferedPois;
    NSMutableArray * removedPois;
    
    //Images
    NSMutableDictionary * imagesDico;
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
@property (retain, nonatomic) NSMutableArray * preferedPois;
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

@end