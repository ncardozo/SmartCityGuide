//
//  CacheManager_PREFEREDPOIS.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CacheManager_PREFEREDPOIS.h"

@implementation CacheManager (CacheManager_PREFEREDPOIS)

@contexts PreferedPois
- (NSMutableArray*)poisList{
    return self.preferedPois;
}

@end
