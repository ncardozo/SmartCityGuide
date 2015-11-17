//
//  Description.m
//  MiniGuide
//
//  Created by Guillaume Kaisin on 23/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "Description.h"

@implementation Description
@synthesize descText, poidId, descId,language;

-(id)initWithText:(NSMutableDictionary*)aDico ident:(int)anIdent poiId:(int) anId {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.descText = aDico;
        self.descId = anIdent;
        self.poidId = anId;
    }
    
    return self;
}

-(NSString*) description{
    return @"description text context error";
}

@end