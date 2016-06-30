//
//  ContextsManager.m
//  DemoGuide
//
//  Created by Nicolas Cardozo on 17/12/15.
//

#import "ContextsManager.h"
#import "GuidedVisitMapController.h"
#import "POIViewController.h"
#import "ToolsViewController.h"

@implementation ContextsManager
@synthesize langContexts, currentDate, calendar;
@synthesize internetReachable, wifiConnection, wwanConnection, locationManager, currentLocation;

- (id)init {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.langContexts = [NSArray arrayWithObjects:@"French", @"English", @"Dutch", nil];
       
        self.calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSTimer *clockTimerTime = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateDate) userInfo:nil repeats:YES];
        NSTimer *clockTimerConnection = [NSTimer scheduledTimerWithTimeInterval:60 target:self selector:@selector(updateConnectivityStatus) userInfo:nil repeats:YES];
        [self updateDate];
        [self updateConnectivityStatus];
        
        //Setup location variables
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [locationManager startUpdatingLocation];
        self.currentLocation = [locationManager location];
        [self locationManager:nil didChangeAuthorizationStatus:[CLLocationManager authorizationStatus]];
        
        [[NSNotificationCenter defaultCenter] addObserver:self
                                                 selector:@selector(guidedVisitActivated:) 
                                                name:SCContextDidActivate
                                                   object:[ContextsManager class]];
    }
    
    return self;
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    self.currentLocation = newLocation;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status==kCLAuthorizationStatusDenied || status==kCLAuthorizationStatusRestricted){
        [GuidedVisitMapController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"BaseGuidedVisitMapController"])alloc] init]];
        [POIViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"BasePOIViewController"])alloc] init]];
    }
    else {
        [GuidedVisitMapController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"GuidedVisitMapController%@", @"GuidedTour"])alloc] init]];
        [POIViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"POIViewController%@", @"GuidedTour"])alloc] init]];
    }
}

-(void) updateDate{
    [POIViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"%@POIViewController", @"Base"])alloc] init]];
    [Poi setStrategy:[[NSClassFromString([NSString stringWithFormat:@"BasePoi"])alloc] init]];
    
    self.currentDate = [NSDate date];
    NSDateComponents * curHour = [self.calendar components:NSCalendarUnitHour fromDate:self.currentDate];
    long hour = [curHour hour];
    if(hour<12) {
        [Poi setStrategy:[[NSClassFromString([NSString stringWithFormat:@"Poi%@", @"Morning"])alloc] init]];

 
    } else if(hour<18) {
        [Poi setStrategy:[[NSClassFromString([NSString stringWithFormat:@"Poi%@", @"Afretnoon"])alloc] init]];

    } else {
        [Poi setStrategy:[[NSClassFromString([NSString stringWithFormat:@"Poi%@", @"Evening"])alloc] init]];

    }     
}

-(void) updateConnectivityStatus{
    self.internetReachable = [Reachability reachabilityForInternetConnection];
    [self.internetReachable startNotifier];
    NetworkStatus internetStatus = [internetReachable currentReachabilityStatus];
    self.wifiConnection = NO;
    self.wwanConnection = NO;
    
    if(internetStatus == ReachableViaWiFi){
        self.wifiConnection = YES;
        [ToolsViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"ToolsViewController%@", @"Wifi"])alloc] init]];
    }
    if(internetStatus == ReachableViaWWAN){
        self.wwanConnection = YES;
        [ToolsViewController setStrategy:[[NSClassFromString([NSString stringWithFormat:@"ToolsViewController%@", @"3G"])alloc] init]];
    }

}

- (void)guidedVisitActivated:(NSNotification *)notification {
}

@end