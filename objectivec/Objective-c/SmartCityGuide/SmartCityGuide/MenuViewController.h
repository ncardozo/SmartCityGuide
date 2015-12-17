//
//  MenuViewController.h
//  DemoGuide
//
//  Created by Nicolás Cardozo on 17/12/15.
//

#import <UIKit/UIKit.h>
#import "POIViewController.h"
#import "FreeVisitMapViewController.h"
#import "GuidedVisitMapController.h"
#import "DemoGuideAppDelegate.h"

@interface MenuViewController : UITableViewController{
    NSArray * menuTitles;
    NSArray * visitTitles;
    
    POIViewController * poiView;
    FreeVisitMapViewController * mapView;
    GuidedVisitMapController * guidedView;
    
    CacheManager * cacheManager;
}

@property(retain, nonatomic) NSArray * menuTitles;
@property(retain, nonatomic) NSArray * visitTitles;

@property(retain, nonatomic) POIViewController * poiView;
@property(retain, nonatomic) FreeVisitMapViewController * mapView;
@property(retain, nonatomic) GuidedVisitMapController * guidedView;
@property(retain, nonatomic) CacheManager * cacheManager;

-(void) loadGuidedTour;
-(void) loadFreeTour;
-(void) loadPoisList;

@end