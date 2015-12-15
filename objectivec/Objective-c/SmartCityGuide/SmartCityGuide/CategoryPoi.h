//
//  CategoryPoi.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 17/11/15.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
@import UIKit;

@class Poi;

#define GREENCAT @"Culture"
#define BLUECAT @"Divertissement"
#define PINKCAT @"Shopping"
#define YELLOWCAT @"Restaurant"


@interface BaseCategory : NSObject {
    DBManager *dbManager;
}

@property(nonatomic) DBManager *dbManager;
@property(assign, nonatomic) int idCat;
@property(retain, nonatomic) NSString * idString;

- (NSString *) name;
@end

@interface CategoryPoiEN : BaseCategory {}
- (NSString *) name;
@end

@interface CategoryPoiFR : BaseCategory {}
- (NSString *) name;
@end

@interface CategoryPoiNL : BaseCategory {}
- (NSString *) name;
@end

@interface CategoryPoi : BaseCategory {
    NSString * name;
    UIColor * catColor;
    int idCat;
    NSString * idString;
    id strategy;
}

@property(retain, nonatomic, readwrite) NSString *name;
@property(retain, nonatomic) UIColor * catColor;

- (UIColor *) categoryColor;
- (id)initWithId:(int)anId name:(NSString *) aName;
- (NSString *) name;

+(void) setStrategy: (id) _strategy;

@end