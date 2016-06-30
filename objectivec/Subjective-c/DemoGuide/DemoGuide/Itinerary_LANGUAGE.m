//
//  Itinerary_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
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

@end