//
//  FreeVisitMapViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 23/03/12.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "MKAnnotation.h"
#import "DescViewController.h"

@interface FreeVisitMapViewController : UIViewController{
    
    IBOutlet MKMapView *mapView;
    CLLocationManager *locationManager;
    NSString* currentLatitude;
    NSString* currentLongitude;
    
    NSMutableArray * annotations;
    NSMutableArray * mapPoiList;
    CacheManager * cacheManager;
    
    id<MKAnnotation> currentLocation;
    
    DescViewController * descView;
}

@property (retain, nonatomic) DescViewController * descView;
@property (retain, nonatomic) id<MKAnnotation> currentLocation;
@property (retain, nonatomic) NSMutableArray * mapPoiList;
@property (retain, nonatomic) CacheManager * cacheManager;

@property (nonatomic, retain) IBOutlet MKMapView *mapView;
@property (nonatomic, retain) NSMutableArray * annotations;

@property (retain, nonatomic) NSString* currentLatitude;
@property (retain, nonatomic) NSString* currentLongitude;
@property (retain, nonatomic) CLLocationManager *locationManager;

- (void)mapViewDidFinishLoadingMap:(MKMapView*)mapView;
- (void)mapViewDidFailLoadingMap:(MKMapView*)mapView withError:(NSError*) error;
- (void)addPOILocations:(NSMutableArray *) poisList;
- (void)zoomToLocation:(MKAnnotation*)annotation;
- (void)zoomToCurrentLocation;
- (void)recenterMap;
- (void)updateAnnotations;
- (UIImageView*) getPinLook:(Poi*)p;

@end