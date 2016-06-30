//
//  CategoryPoi_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
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

@end