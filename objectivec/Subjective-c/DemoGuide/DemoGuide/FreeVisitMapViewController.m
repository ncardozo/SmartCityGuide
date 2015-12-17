//
//  FreeVisitMapViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 23/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "FreeVisitMapViewController.h"
#import <MapKit/MapKit.h>

@implementation FreeVisitMapViewController
@synthesize mapView, annotations, mapPoiList, cacheManager;
@synthesize currentLatitude, currentLongitude, locationManager; 
@synthesize descView, currentLocation;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        DescViewController * viewController = [[DescViewController alloc] initWithNibName:@"DescViewController" bundle:nil];
        self.descView = viewController;
        [self.descView viewDidLoad];
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    NSLog(@"WARNING MEMORY");
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Map";
    
    DemoGuideAppDelegate * delegate = ((DemoGuideAppDelegate *)[[UIApplication sharedApplication] delegate]);
    self.cacheManager = [delegate cacheManager];
    
    self.annotations = [[NSMutableArray alloc] init];
    [self addPOILocations:[self.cacheManager poisList]];
    //[self zoomToLocation:[self.annotations objectAtIndex:0]];
    
    UIBarButtonItem *comment = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                target:self
                                action:@selector(zoomToCurrentLocation)];
    
    self.navigationItem.rightBarButtonItem = comment;
    
    [self zoomToCurrentLocation];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(needRefresh:) 
                                                 name:SCContextDidActivate
                                               object:[[SCContextManager sharedContextManager] contextWithName:@"RefreshPoiMap"]];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(needRefresh:) 
                                                 name:SCContextDidDeactivate
                                               object:[[SCContextManager sharedContextManager] contextWithName:@"ColoredCategories"]];
}

-(void) updateAnnotations{
    [self.mapView removeAnnotations:annotations];
    [self addPOILocations:[self.cacheManager poisList]];
}

- (void)zoomToCurrentLocation{
    //[self zoomToLocation:self.currentLocation];
    [self recenterMap];
}

- (void)recenterMap {
    NSArray *coordinates = [self.mapView valueForKeyPath:@"annotations.coordinate"];
    
    CLLocationCoordinate2D maxCoord = {-90.0f, -180.0f};
    CLLocationCoordinate2D minCoord = {90.0f, 180.0f};
    
    for(NSValue *value in coordinates) {
        CLLocationCoordinate2D coord = {0.0f, 0.0f};
        [value getValue:&coord];
        if(coord.longitude > maxCoord.longitude) {
            maxCoord.longitude = coord.longitude;
        }
        if(coord.latitude > maxCoord.latitude) {
            maxCoord.latitude = coord.latitude;
        }
        if(coord.longitude < minCoord.longitude) {
            minCoord.longitude = coord.longitude;
        }
        if(coord.latitude < minCoord.latitude) {
            minCoord.latitude = coord.latitude;
        }
    }
    MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
    region.center.longitude = (minCoord.longitude + maxCoord.longitude) / 2.0;
    region.center.latitude = (minCoord.latitude + maxCoord.latitude) / 2.0;
    region.span.longitudeDelta = maxCoord.longitude - minCoord.longitude;
    region.span.latitudeDelta = maxCoord.latitude - minCoord.latitude;
    [self.mapView setRegion:region animated:YES];  
}


- (void)zoomToLocation:(MKAnnotation*)annotation{
    MKCoordinateRegion region;
    region.center =annotation.coordinate;
    MKCoordinateSpan span; 
    span.latitudeDelta  = 0.01; // Change these values to change the zoom
    span.longitudeDelta = 0.01; 
    region.span = span;
    
    [self.mapView setRegion:region animated:YES];
}

- (void)viewDidUnload {
    mapView = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)mapViewDidFinishLoadingMap:(MKMapView*)mapView{
    
}

- (void)mapViewDidFailLoadingMap:(MKMapView*)mapView withError:(NSError*) error{
    NSLog(@"Error: %@", [error description]);
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    //if its the user location
    if([annotation isKindOfClass:[MKUserLocation class]]){
        self.currentLocation = annotation;
        return nil;
    } else {
        MKAnnotation * myAnnotation = (MKAnnotation*)annotation;        
        static NSString * AnnotationIdentifier = @"AnnotationIdentifier";
        MKPinAnnotationView * pinView = [[[MKPinAnnotationView alloc] 
                                          initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier] autorelease];
        
        //Basic properties
        pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        [pinView addSubview:[self getPinLook:[myAnnotation poi]]];
        //pinView.pinColor = MKPinAnnotationColorGreen;
        
        //Change the pin appearance
        //pinView.image = [UIImage imageNamed:@"chat-icon.png"];
        
        //Right button properties
        UIButton * righButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        righButton.tag = [[myAnnotation poi] poiId];
        [righButton setTitle:myAnnotation.title forState:UIControlStateNormal];
        pinView.rightCalloutAccessoryView = righButton;
        
        /*UIImageView * profileIconView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"morning_esplanade.jpg"]];
         pinView.leftCalloutAccessoryView = profileIconView;
         [profileIconView release];*/
        
        return pinView;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSString * poiId = [NSString stringWithFormat:@"%ld",(long)control.tag];
    Poi * p = [[self.cacheManager poiById] objectForKey:poiId];
    
    [self.navigationController pushViewController:self.descView animated:YES];       
    //Set view attributes
    [self.descView setupView:p];
}

- (void)addPOILocations:(NSMutableArray *) poisList{
    [self.annotations removeAllObjects];
    for(Poi * curP in poisList){        
        MKAnnotation *annotationPoint = [[MKAnnotation alloc] initWithPoi:curP];
        [self.mapView addAnnotation:annotationPoint];
        [self.annotations addObject:annotationPoint];
    }
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error {
    NSLog(@"Error: %@", [error description]);
}

-(void) locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
   CLLocationCoordinate2D annotationCoord;
    double latitude = newLocation.coordinate.latitude;
    double decimal = fabs(newLocation.coordinate.latitude - latitude);
    int minutes = decimal * 60;
    double seconds = decimal * 3600 - minutes * 60;
    NSString *lat = [NSString stringWithFormat:@"%f° %d' %1.4f\"",
                     latitude, minutes, seconds];
    self.currentLatitude = lat;
    double longitude = newLocation.coordinate.longitude;
    decimal = fabs(newLocation.coordinate.longitude - longitude);
    minutes = decimal * 60;
    seconds = decimal * 3600 - minutes * 60;
    NSString *longt = [NSString stringWithFormat:@"%f° %d' %1.4f\"",
                       longitude, minutes, seconds];    
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)needRefresh:(NSNotification *)notification{
    [self updateAnnotations];
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"RefreshPoiMap"];
}


-(UIImageView*) getPinLook:(Poi*) p{
    UIImage * image = [[self.cacheManager imagesDico] objectForKey:@"green_pin"];
    UIImageView *imageView = [[[UIImageView alloc] initWithImage:image] autorelease];
    return imageView;
}

@end