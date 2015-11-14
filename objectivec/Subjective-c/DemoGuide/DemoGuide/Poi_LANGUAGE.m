//
//  Poi_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Poi_LANGUAGE.h"

@implementation Poi (Poi_LANGUAGE)


@contexts French
-(NSString*) address{
    return [self.addresses objectForKey:@"fr"];
}

@contexts English
-(NSString*) address{
    return [self.addresses objectForKey:@"en"];
}

@contexts Dutch
-(NSString*) address{
    return [self.addresses objectForKey:@"nl"];
}

@contexts Dutch
-(NSString*) name{
    return [self.names objectForKey:@"nl"];
}

@contexts English
-(NSString*) name{
    return [self.names objectForKey:@"en"];
}

@contexts French
-(NSString*) name{
    return [self.names objectForKey:@"fr"];
}

@end