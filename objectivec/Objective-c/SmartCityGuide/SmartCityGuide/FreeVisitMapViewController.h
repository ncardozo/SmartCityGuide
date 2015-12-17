//
//  FreeVisitMapViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 23/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "MKAnnotation.h"
#import "DescViewController.h"
#import "GlobalConstants.h"

@interface BaseFreeVisitMapViewController : UIViewController {
    CacheManager * cacheManager;
}

@property (retain, nonatomic) CacheManager * cacheManager;

@end

@interface FreeVisitMapViewControllerColor : BaseFreeVisitMapViewController
- (UIImageView*)getPinLook:(Poi*) p;
@end

@interface FreeVisitMapViewController : BaseFreeVisitMapViewController {
    
    IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
    NSString* currentLatitude;
    NSString* currentLongitude;
    
    NSMutableArray * annotations;
    NSMutableArray * mapPoiList;
    
    id<MKAnnotation> currentLocation;
    
    DescViewController * descView;
    
    id strategy;
}

@property (retain, nonatomic) DescViewController * descView;
@property (retain, nonatomic) id<MKAnnotation> currentLocation;
@property (retain, nonatomic) NSMutableArray * mapPoiList;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray * annotations;

@property (retain, nonatomic) NSString* currentLatitude;
@property (retain, nonatomic) NSString* currentLongitude;
@property (retain, nonatomic) CLLocationManager *locationManager;

@property (retain, nonatomic) id strategy;

- (void)mapViewDidFinishLoadingMap:(MKMapView*)mapView;
- (void)mapViewDidFailLoadingMap:(MKMapView*)mapView withError:(NSError*) error;
- (void)addPOILocations:(NSMutableArray *) poisList;
- (void)zoomToLocation:(MKAnnotation*)annotation;
- (void)zoomToCurrentLocation;
- (void)recenterMap;
- (void)updateAnnotations;
- (UIImageView*) getPinLook:(Poi*) p;

+ (void) setStrategy: _strategy;
+ (id) getStrategy;

@end