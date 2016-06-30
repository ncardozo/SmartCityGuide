//
//  CacheManager_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//

#import "CacheManager_LANGUAGE.h"

@implementation CacheManager (CacheManager_LANGUAGE)

@contexts French
- (NSArray*)langageList{
    return [self.langaguesDict objectForKey:@"fr"];
}
@contexts English
- (NSArray*)langageList{
    return [self.langaguesDict objectForKey:@"en"];
}
@contexts Dutch
- (NSArray*)langageList{
    return [self.langaguesDict objectForKey:@"nl"];
}

@contexts French
- (NSString*)currentLang{
    return @"Français";
}
@contexts English
- (NSString*)currentLang{
    return @"English";
}
@contexts Dutch
- (NSString*)currentLang{
    return @"Nederlands";
}

@end