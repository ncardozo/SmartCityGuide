//
//  SQLManager.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//

#import <Foundation/Foundation.h>
#import <sqlite3.h>
#import "Town.h"
#import "Poi.h"
#import "Description.h"
#import "CategoryPoi.h"
#import "Itinerary.h"
#import "Schedule.h"
#import "ScheduleDay.h"

@class Town;
@interface SQLManager : NSObject{
    NSString * dbName;
    NSString * dbPath;    
}

@property (nonatomic, retain) NSString * dbName;
@property (nonatomic, retain) NSString * dbPath;

//SELECT queries
-(NSMutableArray *) selectDescriptions;
-(NSMutableArray *) selectPois:(NSMutableArray*)descriptions imagesDico:(NSMutableDictionary*)imagesDico;
-(NSMutableArray *) selectCategories;
-(NSMutableArray *) selectItineraries:(NSMutableDictionary*)poisById;
-(void) selectCategorizedPois:(NSMutableArray*)curPois categories:(NSMutableArray*)cat;
-(void) selectIcons:(NSMutableDictionary*)imagesDico;
-(void) selectImages:(NSMutableDictionary*)imagesDico;
-(void)selectScheduleForPois:(NSMutableDictionary*)poiById;


@end
