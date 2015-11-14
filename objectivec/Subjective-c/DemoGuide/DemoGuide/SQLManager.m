//
//  SQLManager.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SQLManager.h"


@implementation SQLManager
@synthesize dbName, dbPath;

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.    
        NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDir = [documentPaths objectAtIndex:0];
        self.dbPath = [documentsDir stringByAppendingPathComponent:@"miniDB.sqlite"];
        //self.dbPath = @"/Users/guillaumekaisin/Dropbox/Mémoire/donnees_app/miniDB.sqlite";
        self.dbName = @"miniDB.sqlite";
    }
    return self;
}

- (void)dealloc {
    [dbName release];
    [dbPath release];
    [super dealloc];
}

-(NSMutableArray *) selectDescriptions{
    sqlite3 * db ;
    int res;
    NSMutableArray * selectedDesc = [[[NSMutableArray alloc] init] autorelease];
    const char *sqlStatement = "SELECT * FROM description";
    sqlite3_stmt *compiledStatement;
    
    if( (res = sqlite3_open([self.dbPath UTF8String], &db)) == SQLITE_OK) {
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                int anId = sqlite3_column_int(compiledStatement, 0);
                int poi_id = sqlite3_column_int(compiledStatement, 1);
                
                NSString *textFr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString *textEn = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSString *textNl = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSMutableDictionary * textDico = [NSMutableDictionary 
                                                  dictionaryWithObjects:[NSArray arrayWithObjects:textFr, textEn, textNl, nil] 
                                                  forKeys:[NSArray arrayWithObjects:@"fr", @"en", @"nl", nil]];
                Description * newDesc = [[Description alloc] initWithText:textDico ident:anId poiId:poi_id];
                
                [selectedDesc addObject:newDesc];
                
                [newDesc release];
            }
        }
        sqlite3_finalize(compiledStatement);        
	}
    return selectedDesc;
}

-(NSMutableArray *) selectPois:(NSMutableArray*)descriptions imagesDico:(NSMutableDictionary *)imagesDico{
    sqlite3 * db ;
    int res;
    NSMutableArray * selectedPois = [[[NSMutableArray alloc] init] autorelease];
    const char *sqlStatement = "SELECT * FROM poi";
    sqlite3_stmt *compiledStatement;
    
    if( (res = sqlite3_open([self.dbPath UTF8String], &db)) == SQLITE_OK) {
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                int anId = sqlite3_column_int(compiledStatement, 0);
                
                NSString *name_fr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *name_en = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString *name_nl = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                NSDictionary * namesDico = [NSDictionary 
                                            dictionaryWithObjects:[NSArray arrayWithObjects:name_fr, name_en, name_nl, nil] 
                                            forKeys:[NSArray arrayWithObjects:@"fr", @"en", @"nl", nil]];
                
                NSString *address_fr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
                NSString *address_en = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
                NSString *address_nl = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
                NSDictionary * addressDico = [NSDictionary 
                                            dictionaryWithObjects:[NSArray arrayWithObjects:address_fr, address_en, address_nl, nil] 
                                            forKeys:[NSArray arrayWithObjects:@"fr", @"en", @"nl", nil]];
                
                NSString *url = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
                double latitude = sqlite3_column_double(compiledStatement, 9);
                double longitude = sqlite3_column_double(compiledStatement, 10);
            
                Poi * poi = [[Poi alloc] initWithAddress:addressDico latitude:latitude longitude:longitude ident:anId name:namesDico imageUrl:url];
                for(Description * d in descriptions){
                    if([d poidId] == anId){
                        poi.descriptions = d;
                        break;
                    }
                }
                poi.imagesDico = imagesDico;
                [selectedPois addObject:poi];
                
                [poi release];
            }
        }
        sqlite3_finalize(compiledStatement);        
	}
    return selectedPois;
}

-(NSMutableArray *) selectCategories{
    sqlite3 * db ;
    int res;
    NSMutableArray * selectedCategories = [[[NSMutableArray alloc] init] autorelease];
    const char *sqlStatement = "SELECT * FROM Category";
    sqlite3_stmt *compiledStatement;
    
    if( (res = sqlite3_open([self.dbPath UTF8String], &db)) == SQLITE_OK) {
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                int anId = sqlite3_column_int(compiledStatement, 0);
                
                NSString *frName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString *enName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString *nlName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                
                CategoryPoi * newCat = [[CategoryPoi alloc] initWithId:anId frName:frName enName:enName nlName:nlName];
                
                [selectedCategories addObject:newCat];
                
                [newCat release];
            }
        }
        sqlite3_finalize(compiledStatement);        
	}
    return selectedCategories;
}

-(void) selectCategorizedPois:(NSMutableArray*)curPois categories:(NSMutableArray*)curCategories{
    sqlite3 * db ;
    int res;
    const char *sqlStatement = "SELECT * FROM Categorized_poi";
    sqlite3_stmt *compiledStatement;
    
    if( (res = sqlite3_open([self.dbPath UTF8String], &db)) == SQLITE_OK) {
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                int poiId = sqlite3_column_int(compiledStatement, 1);
                int categoryId = sqlite3_column_int(compiledStatement, 2);
                CategoryPoi * poiCat;
                Poi * modifyPoi;
                for(CategoryPoi * tempCat in curCategories){
                    if(tempCat.idCat == categoryId){
                        poiCat = tempCat;
                    }
                }
                for(Poi * tempPoi in curPois){
                    if(tempPoi.poiId == poiId){
                        modifyPoi = tempPoi;
                    }
                }
                [modifyPoi.categories addObject:poiCat];
                modifyPoi.categoryPoi = poiCat;
            }
        }
        sqlite3_finalize(compiledStatement);        
	}
}

-(NSMutableArray *) selectItineraries:(NSMutableDictionary*)poisById{
    sqlite3 * db ;
    int res;
    NSMutableArray * selectedItineraries = [[[NSMutableArray alloc] init] autorelease];
    const char *sqlStatement = "SELECT * FROM Itinerary";
    sqlite3_stmt *compiledStatement;
    
    if( (res = sqlite3_open([self.dbPath UTF8String], &db)) == SQLITE_OK) {
        if( (res = sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL)) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while((res = sqlite3_step(compiledStatement)) == SQLITE_ROW) {
                // Read the data from the result row
                int anId = sqlite3_column_int(compiledStatement, 0);
                
                NSString * textFr = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSString * textEn = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
                NSString * textNl = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
                
                int aCount = sqlite3_column_int(compiledStatement, 4);
                int idPoi1 = sqlite3_column_int(compiledStatement, 5);
                int idPoi2 = sqlite3_column_int(compiledStatement, 6);
                int idPoi3 = sqlite3_column_int(compiledStatement, 7);
                int idPoi4 = sqlite3_column_int(compiledStatement, 8);
                int idPoi5 = sqlite3_column_int(compiledStatement, 9);
                int idPoi6 = sqlite3_column_int(compiledStatement, 10);
                int idPoi7 = sqlite3_column_int(compiledStatement, 11);
                int idPoi8 = sqlite3_column_int(compiledStatement, 12);
                int idPoi9 = sqlite3_column_int(compiledStatement, 13);
                int idPoi10 = sqlite3_column_int(compiledStatement, 14);
                
                NSArray * poiIdArray = [NSArray arrayWithObjects:
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi1]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi2]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi3]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi4]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi5]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi6]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi7]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi8]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi9]], 
                                        [poisById objectForKey:[NSString stringWithFormat:@"%d", idPoi10]], nil];
                
                NSDictionary * descDico = [NSDictionary dictionaryWithObjects:
                                           [NSArray arrayWithObjects:textFr, textEn, textNl,nil]
                                            forKeys:[NSArray arrayWithObjects:@"fr", @"en", @"nl", nil]];
                
                Itinerary * newItinerary = [[Itinerary alloc] initWithId:anId descriptions:descDico nb:aCount pois:poiIdArray];
                
                [selectedItineraries addObject:newItinerary];
                
                [newItinerary release];
            }
        }
        sqlite3_finalize(compiledStatement);        
	}
    return selectedItineraries;
}

-(void) selectIcons:(NSMutableDictionary*)imagesDico{
    sqlite3 * db ;
    int res;
    const char *sqlStatement = "SELECT * FROM Icons";
    sqlite3_stmt *compiledStatement;
    
    if( (res = sqlite3_open([self.dbPath UTF8String], &db)) == SQLITE_OK) {
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                int anId = sqlite3_column_int(compiledStatement, 0);
                
                NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSData * dataForCachedImage = [[NSData alloc] initWithBytes:sqlite3_column_blob(compiledStatement,2) length:sqlite3_column_bytes(compiledStatement,2)];
                [imagesDico setObject:[UIImage imageWithData:dataForCachedImage] forKey:aName];
                [dataForCachedImage release];
            }
        }
        sqlite3_finalize(compiledStatement);        
	}
}

-(void) selectImages:(NSMutableDictionary*)imagesDico{
    sqlite3 * db ;
    int res;
    const char *sqlStatement = "SELECT * FROM Images";
    sqlite3_stmt *compiledStatement;
    
    if( (res = sqlite3_open([self.dbPath UTF8String], &db)) == SQLITE_OK) {
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                int anId = sqlite3_column_int(compiledStatement, 0);
                
                NSString *aName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
                NSData * dataForCachedImage = [[NSData alloc] initWithBytes:sqlite3_column_blob(compiledStatement,2) length:sqlite3_column_bytes(compiledStatement,2)];
                [imagesDico setObject:[UIImage imageWithData:dataForCachedImage] forKey:aName];
                [dataForCachedImage release];
            }
        }
        sqlite3_finalize(compiledStatement);        
	}
}

-(void)selectScheduleForPois:(NSMutableDictionary*)poiById{
    sqlite3 * db ;
    int res;
    const char *sqlStatement = "SELECT * FROM WeekSchedule";
    sqlite3_stmt *compiledStatement;
    NSDateFormatter * dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"HH:mm"];
    
    if( (res = sqlite3_open([self.dbPath UTF8String], &db)) == SQLITE_OK) {
        if(sqlite3_prepare_v2(db, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                NSMutableArray * dateArray = [NSMutableArray array];
                // Read the data from the result row
                int anId = sqlite3_column_int(compiledStatement, 0);
                int poiId = sqlite3_column_int(compiledStatement, 1);
                
                int i = 2;
                while(i<15) {
                    NSString * startString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i)];
                    NSDate * start = [dateFormatter dateFromString:startString];
                    NSString * endString = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, i+1)];
                    NSDate * end = [dateFormatter dateFromString:endString];
                    ScheduleDay * daySchedule = [[ScheduleDay alloc] initWithStart:start end:end];
                    [dateArray addObject:daySchedule];
                    [daySchedule release];
                    i=i+2;
                }
                Poi * p = [poiById objectForKey:[NSString stringWithFormat:@"%d",poiId]];
                Schedule * schedule = [[Schedule alloc] initWithWeek:dateArray];
                p.poiSchedule = schedule;
                
                [schedule release];
            }
        }
        sqlite3_finalize(compiledStatement);        
	}
}

@end