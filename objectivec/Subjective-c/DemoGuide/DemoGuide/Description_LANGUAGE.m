//
//  Description_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//

#import "Description_LANGUAGE.h"

@implementation Description (Description_LANGUAGE)

@contexts French
-(NSString*) description{
    return [self.descText objectForKey:@"fr"];
}

@contexts English
-(NSString*) description{
    return [self.descText objectForKey:@"en"];
}

@contexts Dutch
-(NSString*) description{
    return [self.descText objectForKey:@"nl"];
}

@end