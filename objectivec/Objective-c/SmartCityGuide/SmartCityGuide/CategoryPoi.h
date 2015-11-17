//
//  CategoryPoi.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 14/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GREENCAT @"Culture"
#define BLUECAT @"Divertissement"
#define PINKCAT @"Shopping"
#define YELLOWCAT @"Restaurant"


@interface CategoryPoi : NSObject{
    NSString * nameFr;
    NSString * nameEn;
    NSString * nameNl;
    UIColor * catColor;
    int idCat;
    NSString * idString;
}

@property(retain, nonatomic) NSString * nameFr;
@property(retain, nonatomic) NSString * nameEn;
@property(retain, nonatomic) NSString * nameNl;
@property(assign, nonatomic) int idCat;
@property(retain, nonatomic) NSString * idString;
@property(retain, nonatomic) UIColor * catColor;

- (UIColor*) categoryColor;
- (id)initWithId:(int)anId frName:(NSString*)frName enName:(NSString*)enName nlName:(NSString*)nlName;
- (NSString*) name;

@end