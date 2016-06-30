//
//  Description.h
//  MiniGuide
//
//  Created by Guillaume Kaisin on 23/10/11.
//

#import <Foundation/Foundation.h>
@class Poi;

@interface Description : NSObject{
    int descId;
    int poidId;
    NSString * language;
    NSMutableDictionary * descText;
}

@property(assign, nonatomic) int descId;
@property(assign, nonatomic) int poidId;
@property(retain, nonatomic) NSString * language;
@property(retain, nonatomic) NSMutableDictionary * descText;

-(id)initWithText:(NSMutableDictionary*)aDico ident:(int)anIdent poiId:(int) anId;
-(NSString*) description;

@end