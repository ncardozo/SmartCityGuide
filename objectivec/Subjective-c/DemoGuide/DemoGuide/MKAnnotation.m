//
//  MKAnnotation.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 02/02/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MKAnnotation.h"

@implementation MKAnnotation
@synthesize title, coordinate, poi, indexIti, location;

- (id)initWithPoi:(Poi*)p{
	[super init];
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = [p latitude];
    annotationCoord.longitude = [p longitude];
	self.title = [p name];
	coordinate = annotationCoord;
    self.poi = p;
    self.location = [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
	return self;
}

- (id)initWithPoi:(Poi*)p index:(int)i{
	[super init];
    CLLocationCoordinate2D annotationCoord;
    annotationCoord.latitude = [p latitude];
    annotationCoord.longitude = [p longitude];
	self.title = [p name];
	coordinate = annotationCoord;
    self.poi = p;
    self.indexIti = i;
	return self;
}

@end