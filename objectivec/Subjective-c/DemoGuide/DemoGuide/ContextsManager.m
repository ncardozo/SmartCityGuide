//
//  ContextsManager.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ContextsManager.h"

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
                                                   object:[[SCContextManager sharedContextManager] contextWithName:@"GuidedTour"]];
    }
    
    return self;
}

-(void)dealloc {
    [calendar release];
    [locationManager release];
    [super dealloc];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    self.currentLocation = newLocation;
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    if(status==kCLAuthorizationStatusDenied || status==kCLAuthorizationStatusRestricted){
            [[SCContextManager sharedContextManager] deactivateContextWithName:@"GPS"];
    }
    else [[SCContextManager sharedContextManager] activateContextWithName:@"GPS"];
}

-(void) updateDate{
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"Morning"];
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"Afternoon"];
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"Evening"];
    self.currentDate = [NSDate date];
    NSDateComponents * curHour = [self.calendar components:NSHourCalendarUnit fromDate:self.currentDate]; 
    int hour = [curHour hour];
    if(hour<12) {
        [[SCContextManager sharedContextManager] activateContextWithName:@"Morning"];
 
    } else if(hour<18) {
        [[SCContextManager sharedContextManager] activateContextWithName:@"Afternoon"];

    } else {
        [[SCContextManager sharedContextManager] activateContextWithName:@"Evening"];
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
        [[SCContextManager sharedContextManager] activateContextWithName:@"ConnectedWifi"];
    }
    if(internetStatus == ReachableViaWWAN){
        self.wwanConnection = YES;
        [[SCContextManager sharedContextManager] activateContextWithName:@"Connected3G"];
    }

}

- (void)guidedVisitActivated:(NSNotification *)notification {
}

@end