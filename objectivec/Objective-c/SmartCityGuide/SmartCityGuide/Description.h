//
//  Description.h
//  MiniGuide
//
//  Created by Nicolas Cardozo on 17/11/15.
//

#import <Foundation/Foundation.h>
#import "DBManager.h"
@class Poi;

@interface BaseDescription : NSObject {}

@property(nonatomic) DBManager *dbManager;
@property(nonatomic, assign) int descId;
@property(assign, nonatomic) int poidId;

-(NSString*) description;
@end

@interface DescriptionEN : BaseDescription {}
-(NSString*) description;
@end

@interface DescriptionFR : BaseDescription {}
-(NSString*) description;
@end


@interface DescriptionNL : BaseDescription {}
-(NSString*) description;
@end

@interface Description : BaseDescription {
    int descId;
    int poidId;
    NSString * descText;
    id strategy;
}

@property(retain, nonatomic) NSString *descText;

-(id)initWithText:(NSMutableDictionary*)aDico ident:(int)anIdent poiId:(int) anId;
-(NSString*) description;

-(void) setStrategy: (id) _strategy;

@end