//
//  CacheManager.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManagerPreferredPois
@synthesize pois;

- (NSMutableArray*)poisList{
    return self.pois;
}

@end

@implementation CacheManagerFR
- (NSArray*)languageList {
    return nil;
}

- (NSString*)currentLang{
    return @"FR";
}

@end

@implementation CacheManagerEN

- (NSArray*)languageList {
    return nil;
}

- (NSString*)currentLang{
    return @"EN";
}
@end

@implementation CacheManagerNL

- (NSArray*)languageList {
    return nil;
}

- (NSString*)currentLang{
    return @"NL";
}
@end

@implementation CacheManager
@synthesize descriptionsList, poisList, sqlManager, langaguesDict, categoryList, itineraryList;
@synthesize poiByName, poiByCategory, poiById, removedPois, imagesDico, activeItinerary;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        self.imagesDico = [[NSMutableDictionary alloc] init];
        
        self.sqlManager = [[SQLManager alloc] init];
        [self updateDescriptions];
        [self updatePois];
        [self updateCategories];
        [self updateItineraries];
        [self updateImages];
        [self updateSchedules];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePoisList:) 
                                                     name:SCContextDidActivate
                                                   object:[CacheManager getStrategy]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePoisList:) 
                                                     name:SCContextDidActivate
                                                   object:[CacheManager getStrategy]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePoisList:) 
                                                     name:SCContextDidActivate
                                                   object:[CacheManager getStrategy]];
        
    }
    
    return self;
}

-(void) updateItineraries{
    self.itineraryList = [self.sqlManager selectItineraries:self.poiById];
}

- (void)updateSchedules{
    [self.sqlManager selectScheduleForPois:poiById];
}

-(void) updateDescriptions{
    self.descriptionsList = [self.sqlManager selectDescriptions];
}

-(void) updatePois{
    self.poisList = [self.sqlManager selectPois:self.descriptionsList imagesDico:self.imagesDico];
    self.poiByName = [self.poisList sortedArrayUsingSelector:@selector(compareName:)];
    self.poiById = [NSMutableDictionary dictionary];
    for(Poi * p in self.poisList){
        [self.poiById setObject:p forKey:[NSString stringWithFormat:@"%d", [p poiId]]];
    }
}

-(void) updateCategories{
    self.categoryList = [self.sqlManager selectCategories];
    [self.sqlManager selectCategorizedPois:self.poisList categories:categoryList];
    [self poiByCategory];
}

-(NSMutableDictionary*) poiByCategory{
    NSMutableDictionary * curPoiByCategory = [NSMutableDictionary dictionary];
    
    for(Poi * p in [self poisList]){
        CategoryPoi * pCat = [p categoryPoi];
        NSString * catName = [pCat name];
        NSMutableArray * pArray = [curPoiByCategory objectForKey:catName];
        if(pArray==nil){
            [curPoiByCategory setValue:[NSMutableArray arrayWithObject:p] forKey:catName];
        }
        else{
            [pArray addObject:p];
        }
        
    }
    self.poiByCategory = curPoiByCategory;
    return curPoiByCategory;
}

-(void) updatePreferedPois:(NSMutableArray*)selectedCategories{
    [CacheManager setStrategy:[[NSClassFromString([NSString stringWithFormat:@"BaseCacheManager"])alloc] init]];

    if([selectedCategories containsObject:[NSNumber numberWithBool:NO]]){
        
        //if all the categories are not selected
        self.removedPois = [[NSMutableArray alloc] init];
        for(NSInteger i =0; i<[self.categoryList count]; i++){
            //For each category
            if([[selectedCategories objectAtIndex:i] boolValue]){
                //if the category is selected then check all pois in this category and
                //add it to the preferedPois
                CategoryPoi * cat = [categoryList objectAtIndex:i];
                for(Poi * tempPoi in self.poisList){
                    if([tempPoi.categoryPoi.name compare:cat.name]==0){
                        [CacheManager setStrategy:[[NSClassFromString([NSString stringWithFormat:@"CacheManager%@", @"PreferredPois"])alloc] init]];
                        [[[CacheManager getStrategy] pois] addObject:tempPoi];
                    }
                }
            }
        }
    }
    
    [self updatePoisList:nil];
}

-(void) updateImages{
    [self.sqlManager selectIcons:imagesDico];
    [self.sqlManager selectImages:imagesDico];
}

-(NSArray*) poiArray{
    return self.poiByName;
}

-(NSMutableDictionary*) poisByCategory{
    return self.poiByCategory;
}

-(NSArray*) poiByItinerary{
    return [self.activeItinerary itineraryPois];
}

- (void)updatePoisList:(NSNotification *)notification {
    self.poiByName = [[self poisList] sortedArrayUsingSelector:@selector(compareName:)];
    
}

-(NSString*) currentLang{
    return @"error lang context init";
}

@end