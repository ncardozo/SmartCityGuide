//
//  CategoryPoi.m
//  DemoGuide
//
//  Created by Nicolas Cardozo on 17/11/15.
//

#import "CategoryPoi.h"
#import "DBManager.h"

@implementation CategoryPoiEN
- (NSString *) name {
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Category WITH language = %@ AND id = %@", @"en", [self idString]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end

@implementation CategoryPoiFR
- (NSString *) name {
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Category WITH language = %@ AND id = %@", @"fr", [self idString]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end

@implementation CategoryPoiNL
- (NSString *) name {
    NSString *query = [NSString stringWithFormat:@"SELECT name FROM Category WITH language = %@ AND id = %@", @"nl", [self idString]];
    NSArray *res = [[NSArray alloc] initWithArray:[[self dbManager] loadDataFromDB:query]];
    return [res objectAtIndex:0];
}
@end

@implementation CategoryPoi
@synthesize name, idCat, idString, catColor;

- (id)initWithId:(int)anId name:(NSString*) aName {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.name = aName;
        self.idCat = anId;
        self.idString = [NSString stringWithFormat:@"%d", anId];
        self.dbManager = [[DBManager alloc] initWithDatabaseFilename:@"miniDB.sqlite"];
        [CategoryPoi setStrategy:[[NSClassFromString([NSString stringWithFormat:@"CategoryPoi%@", @"EN"])alloc] init]];
        
            self.catColor = [UIColor colorWithRed:255/255.0f green:230/255.0f blue:102/255.0f alpha:1];
    }
    
    return self;
}

- (UIColor *) categoryColor {
    return self.catColor;
}


- (NSString*) name {
    return @"ERR-CategoryPoi-name";
}

+ (void) setStrategy:(id)_strategy {
    self.strategy = _strategy;
}

@end