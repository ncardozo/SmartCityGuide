//
//  ContextsManager.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "Reachability.h"

@interface ContextsManager : NSObject<CLLocationManagerDelegate>{
    NSArray * langContexts;
    
    NSCalendar *calendar;
    NSDate * currentDate;
    
    Reachability* internetReachable;
    Reachability* hostReachable;
    CLLocationManager * locationManager;
    CLLocation * currentLocation;
    
    BOOL wifiConnection;
    BOOL wwanConnection;
}

@property (retain, nonatomic) NSArray * langContexts;
@property (retain, nonatomic) NSDate * currentDate;
@property (retain, nonatomic) NSCalendar *calendar;

@property (assign, nonatomic) BOOL wifiConnection;
@property (assign, nonatomic) BOOL wwanConnection;
@property (assign, nonatomic) Reachability* internetReachable;
@property (retain, nonatomic) CLLocationManager * locationManager;
@property (retain, nonatomic) CLLocation * currentLocation;

-(void) updateDate;
-(void) updateConnectivityStatus;

@end
