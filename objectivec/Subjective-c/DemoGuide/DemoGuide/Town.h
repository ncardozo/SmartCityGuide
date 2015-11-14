//
//  Town.h
//  MiniGuide
//
//  Created by Guillaume Kaisin on 23/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Town : NSObject{
    int townId;
    NSString * name;
    NSMutableArray * pois;
}

@property(assign, nonatomic) int townId;
@property(retain, nonatomic) NSString * name;
@property(retain, nonatomic) NSMutableArray * pois;

- (id)initWithId:(int)anId name:(NSString*)aName pois:(NSMutableArray*)aPoiArray;

@end