//
//  GuidedVisitMapController.h
//  DemoGuide
//
//  Created by Nicolás Cardozo 16/12/2015
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "MKAnnotation.h"
#import "DescViewController.h"
#import "Poi.h"

#define NEXT_METERS 30

@interface BaseGuidedVisitMapController : UIViewController <MKMapViewDelegate>{
    int currentIti;
    int currentPoi;
    CacheManager * cacheManager;
    
    UIView *mapContainerView;
    UIScrollView *scrollView;
    MKMapView * mapView;
    NSMutableArray * annotations;
    __unsafe_unretained NSMutableArray * itiList;
    
    UILabel *countLabel;
    UILabel *itiDescLabel;
    
    
}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIView *mapContainerView;
@property (nonatomic, retain) MKMapView * mapView;
@property (nonatomic, assign) NSMutableArray * itiList;
@property (nonatomic, assign) int currentPoi;
@property (nonatomic, assign) int currentIti;
@property (nonatomic, retain) IBOutlet UILabel *itiDescLabel;
@property (nonatomic, retain) NSMutableArray * annotations;
@property (nonatomic, retain) IBOutlet UILabel *countLabel;
@property (nonatomic, retain) CacheManager * cacheManager;

- (void) hideItineraryChoice:(BOOL)b;
- (void) cancelItinerary;
- (void) setItinerary;
- (void) nextPoi;
- (void) addPoiAnnotations;
- (void) refreshAnnotations;
@end

@interface GuidedVisitMapControllerGuidedTour : BaseGuidedVisitMapController

- (void) checkNearestPoi;
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;
@end

@interface GuidedVisitMapController : BaseGuidedVisitMapController {
    
    UIButton *previousButton;
    UIButton *goButton;
    
    DescViewController * descView;
    
    id strategy;
}

@property (nonatomic, retain) IBOutlet UIButton *previousButton;
@property (nonatomic, retain) IBOutlet UIButton *goButton;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;

@property (nonatomic, retain) DescViewController * descView;

@property (nonatomic, retain) id strategy;

- (void)recenterMap;
- (void) updateItineraries;
- (void) checkNearestPoi;

- (IBAction)previousAction:(id)sender;
- (IBAction)goAction:(id)sender;
- (IBAction)nextAction:(id)sender;

+ (void) setStrategy: (id) _strategy;
+ (id) getStrategy;

@end