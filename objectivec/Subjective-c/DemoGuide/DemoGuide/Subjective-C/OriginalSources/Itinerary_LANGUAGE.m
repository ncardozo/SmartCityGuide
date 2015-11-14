//
//  Itinerary_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Itinerary_LANGUAGE.h"

@implementation Itinerary (Itinerary_LANGUAGE)

@contexts French
- (NSString *) description{
    return [self.descriptions objectForKey:@"fr"];
}

@contexts English
- (NSString *) description{
    return [self.descriptions objectForKey:@"en"];
}

@contexts Dutch
- (NSString *) description{
    return [self.descriptions objectForKey:@"nl"];
}

/*
 @contexts French
 - (NSString *) description{
 return [self.descriptions objectForKey:@"fr"];
 }
 
 @contexts English
 - (NSString *) description{
 return [self.descriptions objectForKey:@"fr"];
 }
 
 @contexts Dutch
 - (NSString *) description{
 return [self.descriptions objectForKey:@"fr"];
 }
 */

@end
