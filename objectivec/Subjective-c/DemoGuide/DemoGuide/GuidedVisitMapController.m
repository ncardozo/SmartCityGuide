//
//  GuidedVisitMapController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 24/03/12.
//

#import "GuidedVisitMapController.h"

@implementation GuidedVisitMapController
@synthesize countLabel;
@synthesize mapContainerView, scrollView, previousButton, goButton, nextButton, itiDescLabel, mapView;
@synthesize descView, currentIti, cacheManager, annotations, itiList, currentPoi;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        DescViewController * viewController = [[DescViewController alloc] initWithNibName:@"DescViewController" bundle:nil];
        self.descView = viewController;
        [self.descView viewDidLoad];
        self.currentIti = 0;
        self.currentPoi = 0;
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.title = @"Choose itinerary";
    
    DemoGuideAppDelegate * delegate = ((DemoGuideAppDelegate *)[[UIApplication sharedApplication] delegate]);
    self.cacheManager = [delegate cacheManager];
    
    [self updateItineraries];
    self.annotations = [NSMutableArray array];
    //[self zoomToLocation:[self.annotations objectAtIndex:0]];
    
    [self.view bringSubviewToFront:goButton];
    [self.view bringSubviewToFront:nextButton];
    [self.view bringSubviewToFront:previousButton];
    
    UIBarButtonItem *comment = [[UIBarButtonItem alloc]
                                initWithBarButtonSystemItem:UIBarButtonSystemItemSearch
                                target:self
                                action:@selector(recenterMap)];
    
    self.navigationItem.rightBarButtonItem = comment;
    
    self.mapView = [[[MKMapView alloc] initWithFrame:self.mapContainerView.frame] autorelease];
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
    [self.mapContainerView addSubview:self.mapView];
    
    [self addPoiAnnotations];
    [self recenterMap];
    [self setItinerary];
    
    self.navigationController.toolbarHidden = YES; 
    
    UIBarButtonItem * nextBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"next" style:UIBarButtonSystemItemAction target:self action:@selector(nextPoi)];
    
    UIBarButtonItem * flexibleSpace = [[UIBarButtonItem alloc]   
                                       initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace   
                                       target:nil   
                                       action:nil]; 
    
    UIBarButtonItem * cancelItiButton = [[UIBarButtonItem alloc] initWithTitle:@"terminate" style:UIBarButtonSystemItemAction target:self action:@selector(cancelItinerary)];
    self.toolbarItems = [NSArray arrayWithObjects:nextBarButtonItem, flexibleSpace, cancelItiButton, nil];
    
    NSTimer * checkPositionTimer = [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(checkNearestPoi) userInfo:nil repeats:YES];
    
}

- (void)viewDidUnload {
    [self setMapContainerView:nil];
    [self setScrollView:nil];
    [self setPreviousButton:nil];
    [self setGoButton:nil];
    [self setNextButton:nil];
    [self setItiDescLabel:nil];
    //[self countLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

-(MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation{
    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    } else {
        MKAnnotation * myAnnotation = (MKAnnotation*)annotation;
        static NSString * AnnotationIdentifier = @"AnnotationIdentifier";
        MKAnnotationView *pinView=[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        //If one isn't available, create a new one
        if(!pinView){
            pinView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        }
        
        //Basic properties
        //pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        //pinView.pinColor = MKPinAnnotationColorGreen;
        NSString * imgUrl = [NSString stringWithFormat:@"number%d", myAnnotation.indexIti+1];
        pinView.image = [self.cacheManager.imagesDico objectForKey:imgUrl];
        
        UIButton * righButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        righButton.tag = [[myAnnotation poi] poiId];
        [righButton setTitle:[myAnnotation.poi name] forState:UIControlStateNormal];
        pinView.rightCalloutAccessoryView = righButton;
        
        return pinView;
    }
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control{
    NSString * poiId = [NSString stringWithFormat:@"%d",control.tag];
    Poi * p = [[self.cacheManager poiById] objectForKey:poiId];
    
    [self.navigationController pushViewController:self.descView animated:YES];       
    //Set view attributes
    [self.descView setupView:p];
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

- (IBAction)goAction:(id)sender {
    SCContext * gpsContext = [[SCContextManager sharedContextManager]
                           contextWithName:@"GPS"];
    if(!gpsContext.isActive){
        UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Guided Tour" message:@"GPS is disabled on this device.  The Guided tour will not take into account your localization.  Click on \"next\" button to progress into the itinerary" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
    
    self.title = @"Guided Tour";
    [[SCContextManager sharedContextManager] activateContextWithName:@"GuidedTour"];
    self.navigationController.toolbarHidden=NO;
    [self hideItineraryChoice:YES];
    self.currentPoi = 1;
    [self setItinerary];
    
    Itinerary * curIti = [self.itiList objectAtIndex:self.currentIti];
    
    self.cacheManager.activeItinerary = curIti;  
}

- (IBAction)previousAction:(id)sender {
    [self.nextButton setEnabled:YES];
    self.currentIti = self.currentIti - 1;
    if(self.currentIti == 0){
        [self.previousButton setEnabled:NO];
    }
    [self setItinerary];
}

- (IBAction)nextAction:(id)sender {
    [self.previousButton setEnabled:YES];
    self.currentIti = self.currentIti + 1;
    if(self.currentIti == [[self.cacheManager itineraryList] count]-1){
        [self.nextButton setEnabled:NO];
    }
    [self setItinerary];
}

- (void) updateItineraries{
    self.itiList = [self.cacheManager itineraryList];
}

- (void) addPoiAnnotations{
    Itinerary * curIti = [self.itiList objectAtIndex:self.currentIti];
    NSArray * poisList = [curIti itineraryPois];
    self.annotations = [[NSMutableArray alloc] init];
    int i=0;
    while(i<[poisList count]){
        Poi * curP = [poisList objectAtIndex:i];      
        MKAnnotation *annotationPoint = [[MKAnnotation alloc] initWithPoi:curP index:i];
        [self.mapView addAnnotation:annotationPoint];
        [self.annotations addObject:annotationPoint];
        i++;
    }
}

-(void)viewWillAppear:(BOOL)animated{
    [self setItinerary];
    [super viewWillAppear:animated];
}

- (void) setItinerary{
    Itinerary * curIti = [[self.cacheManager itineraryList] objectAtIndex:currentIti];
    //Set the itinerary text
    self.itiDescLabel.text = [curIti description];
    [self.itiDescLabel sizeToFit];
    int textheight = self.itiDescLabel.frame.size.height;
    [self.scrollView setContentSize:CGSizeMake(160, 26+textheight)];
    [self.scrollView setScrollEnabled:YES];
    //Set the annotations
    [self.mapView removeAnnotations:self.annotations];
    [self addPoiAnnotations];
    //Set count button
    self.countLabel.text=[NSString stringWithFormat:@"%d/%lul", self.currentIti+1, [[self.cacheManager itineraryList] count]];
}

- (void) hideItineraryChoice:(BOOL)hide{
    int modify;
    if(hide) modify=120;
    else modify=-120;
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:1.0];
    [self.view bringSubviewToFront:self.mapContainerView];
    self.mapView.frame =  CGRectMake(self.mapView.frame.origin.x,
                                     self.mapView.frame.origin.y,
                                     self.mapView.frame.size.width,
                                     self.mapView.frame.size.height+modify);
    self.mapContainerView.frame = CGRectMake(self.mapContainerView.frame.origin.x,
                                             self.mapContainerView.frame.origin.y,
                                             self.mapContainerView.frame.size.width,
                                             self.mapContainerView.frame.size.height+modify);
    [UIView commitAnimations];
}

-(void)refreshAnnotations{
    [self.mapView removeAnnotations:self.annotations];
    [self addPoiAnnotations];
}

- (void)nextPoi{
    Itinerary * curIti = [itiList objectAtIndex:currentIti]; 
    NSArray * itiPois = [curIti itineraryPois];
    
    if(currentPoi == [itiPois count]){
        [self cancelItinerary];
    } else {
        currentPoi += 1;
        self.cacheManager.activeItinerary.curPoiNb += 1;
        [self refreshAnnotations];
    }
}

- (void) cancelItinerary{
    self.navigationController.toolbarHidden=YES;
    [self hideItineraryChoice:NO];
    [[SCContextManager sharedContextManager] deactivateContextWithName:@"GuidedTour"];
    self.currentPoi = 0;
    self.cacheManager.activeItinerary.curPoiNb = 0;
    [self setItinerary];
    self.title=@"Choose itinerary";
}

- (void) checkNearestPoi{
    
}

@end