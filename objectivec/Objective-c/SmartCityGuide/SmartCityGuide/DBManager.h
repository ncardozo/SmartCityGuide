//
//  DBManager.h
//  SmartCityGuide
//
//  Created by NicolasCardozo on 17/11/2015.
//  Copyright (c) 2015 NicolasCardozo. All rights reserved.
//

#import <sqlite3.h>

@interface DBManager : NSObject

@property(nonatomic, strong) NSMutableArray *columnNames;
@property(nonatomic) int affectedRows;
@property(nonatomic) long long lastInsertedRowID;

- (instancetype) initWithDatabaseFilename: (NSString *) dbFilename;

@end

@interface DBManager()

@property(nonatomic, strong) NSString *documentsDirectory;
@property(nonatomic, strong) NSString *databaseFilename;
@property(nonatomic, strong) NSMutableArray *results;

- (void) copyDatabaseIntoDocumentsDirectory;
- (void) runQuery: (const char *) query isQueryExecutable: (BOOL) queryExecutable;
- (NSArray *) loadDataFromDB: (NSString *) query;

@end