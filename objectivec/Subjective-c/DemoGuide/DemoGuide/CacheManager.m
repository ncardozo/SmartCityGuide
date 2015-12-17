//
//  CacheManager.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CacheManager.h"

@implementation CacheManager
@synthesize descriptionsList, poisList, sqlManager, langaguesDict, categoryList, itineraryList;
@synthesize poiByName, poiByCategory, preferedPois, poiById, removedPois, imagesDico, activeItinerary;

- (id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
        NSArray * frLang = [NSArray arrayWithObjects:@"Français", @"Anglais", @"Néerlandais", nil];
        NSArray * enLang = [NSArray arrayWithObjects:@"French", @"English", @"Dutch", nil];
        NSArray * nlLang = [NSArray arrayWithObjects:@"Frans", @"Engels", @"Nederlands", nil];
        self.langaguesDict = [NSDictionary dictionaryWithObjectsAndKeys:frLang, @"fr", enLang, @"en", nlLang, @"nl", nil];
        self.imagesDico = [[NSMutableDictionary alloc] init];
        
        self.sqlManager = [[SQLManager alloc] init];
        [self updateDescriptions];
        [self updatePois];
        [self updateCategories];
        [self updateItineraries];
        [self updateImages];
        [self updateSchedules];
        self.preferedPois = [[NSMutableArray alloc] init];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePoisList:) 
                                                     name:SCContextDidActivate
                                                   object:[[SCContextManager sharedContextManager] contextWithName:@"French"]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePoisList:) 
                                                     name:SCContextDidActivate
                                                   object:[[SCContextManager sharedContextManager] contextWithName:@"English"]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(updatePoisList:) 
                                                     name:SCContextDidActivate
                                                   object:[[SCContextManager sharedContextManager] contextWithName:@"Dutch"]];
        
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
        NSString * catName = [pCat nameFr];
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
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"PreferedPois"];
    if([selectedCategories containsObject:[NSNumber numberWithBool:NO]]){
        
        //if all the categories are not selected
        [self.preferedPois removeAllObjects];
        self.removedPois = [[NSMutableArray alloc] init];
        for(NSInteger i =0; i<[self.categoryList count]; i++){
            //For each category
            if([[selectedCategories objectAtIndex:i] boolValue]){
                //if the category is selected then check all pois in this category and
                //add it to the preferedPois
                CategoryPoi * cat = [categoryList objectAtIndex:i];
                for(Poi * tempPoi in self.poisList){
                    if([tempPoi.categoryPoi.nameFr compare:cat.nameFr]==0){
                        [self.preferedPois addObject:tempPoi];
                    }
                }
            }
        }
        [[SCContextManager sharedContextManager] activateContextWithName:@"PreferedPois"];
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