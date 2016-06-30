//
//  MKAnnotation.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 02/02/12.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "DemoGuideAppDelegate.h"
#import "DescViewController.h"

@interface MKAnnotation : NSObject
<MKAnnotation>{
	NSString *title;
	CLLocationCoordinate2D coordinate;
    CLLocation * location;
    Poi * poi;
    int indexIti;
    
}

@property (nonatomic, copy) NSString *title;
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;
@property (nonatomic, retain) CLLocation * location;
@property (nonatomic, retain) Poi * poi;
@property (nonatomic, assign) int indexIti;

- (id)initWithPoi:(Poi*)p;
- (id)initWithPoi:(Poi*)p index:(int)i;

@end