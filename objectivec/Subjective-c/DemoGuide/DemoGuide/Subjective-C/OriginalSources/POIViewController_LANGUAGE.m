//
//  POIViewController_LANGUAGE.m
//  DemoGuide
//
//  Created by Kim Mens on 21/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "POIViewController_LANGUAGE.h"

@implementation POIViewController (POIViewController_LANGUAGE)

@contexts French GuidedTour
-(NSArray *) poiSortList{
    return [self.itiSortList objectForKey:@"fr"];
}

@contexts English GuidedTour
-(NSArray *) poiSortList{
    return [self.itiSortList objectForKey:@"en"];
}

@contexts Dutch GuidedTour
-(NSArray *) poiSortList{
    return [self.itiSortList objectForKey:@"nl"];
}

@contexts French
-(NSArray *) poiSortList{
    return [self.normalSortList objectForKey:@"fr"];
}

@contexts English
-(NSArray *) poiSortList{
    return [self.normalSortList objectForKey:@"en"];
}

@contexts Dutch
-(NSArray *) poiSortList{
    return [self.normalSortList objectForKey:@"nl"];
}

/*
 @contexts French GuidedTour
 -(NSArray *) poiSortList{
 return [self.itiSortList objectForKey:@"fr"];
 }
 
 @contexts English GuidedTour
 -(NSArray *) poiSortList{
 return [self.itiSortList objectForKey:@"en"];
 }
 
 @contexts Dutch GuidedTour
 -(NSArray *) poiSortList{
 return [self.itiSortList objectForKey:@"nl"];
 }
 
 @contexts French
 -(NSArray *) poiSortList{
 return [self.normalSortList objectForKey:@"fr"];
 }
 
 @contexts English
 -(NSArray *) poiSortList{
 return [self.normalSortList objectForKey:@"en"];
 }
 
 @contexts Dutch
 -(NSArray *) poiSortList{
 return [self.normalSortList objectForKey:@"nl"];
 }
 */

@end
