//
//  GuidedVisitMapController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 24/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"
#import <CoreLocation/CoreLocation.h>
#import "MKAnnotation.h"
#import "DescViewController.h"
#import "Poi.h"

#define NEXT_METERS 30

@interface GuidedVisitMapController : UIViewController <MKMapViewDelegate>{
    
    UIView *mapContainerView;
    UIScrollView *scrollView;
    UIButton *previousButton;
    UIButton *goButton;
    UILabel *countLabel;
    UILabel *itiDescLabel;
    MKMapView * mapView;
    
    DescViewController * descView;
    int currentIti;
    int currentPoi;
    CacheManager * cacheManager;
    NSMutableArray * annotations;
    NSMutableArray * itiList;
}
@property (nonatomic, retain) IBOutlet UIView *mapContainerView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIButton *previousButton;
@property (nonatomic, retain) IBOutlet UIButton *goButton;
@property (nonatomic, retain) IBOutlet UILabel *countLabel;
@property (nonatomic, retain) IBOutlet UIButton *nextButton;
@property (nonatomic, retain) IBOutlet UILabel *itiDescLabel;
@property (nonatomic, retain) MKMapView * mapView;

@property (nonatomic, retain) CacheManager * cacheManager;
@property (nonatomic, retain) NSMutableArray * annotations;
@property (nonatomic, retain) DescViewController * descView;
@property (nonatomic, assign) int currentIti;
@property (nonatomic, assign) int currentPoi;
@property (nonatomic, assign) NSMutableArray * itiList;

- (void)recenterMap;
- (void) updateItineraries;
- (void) addPoiAnnotations;
- (void) setItinerary;
- (void) checkNearestPoi;
- (void) refreshAnnotations;

- (IBAction)previousAction:(id)sender;
- (IBAction)goAction:(id)sender;
- (IBAction)nextAction:(id)sender;

- (void) hideItineraryChoice:(BOOL)b;

- (void) nextPoi;
- (void) cancelItinerary;

@end