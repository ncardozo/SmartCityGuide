//
//  CategoryPoi_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CategoryPoi_LANGUAGE.h"

@implementation CategoryPoi (CategoryPoi_LANGUAGE)

@contexts French
-(NSString*) name{
    return self.nameFr;
}

@contexts English
-(NSString*) name{
    return self.nameEn;
}

@contexts Dutch
-(NSString*) name{
    return self.nameNl;
}

/*
 @contexts French
 -(NSString*) name{
 return self.nameFr;
 }
 
 @contexts English
 -(NSString*) name{
 return self.nameEn;
 }
 
 @contexts Dutch
 -(NSString*) name{
 return self.nameNl;
 }
 */

@end
