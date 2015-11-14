//
//  GuidedVisitMapController_GUIDEDTOUR.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 26/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GuidedVisitMapController_GUIDEDTOUR.h"

@implementation GuidedVisitMapController (GuidedVisitMapController_GUIDEDTOUR)

@contexts GuidedTour
- (void)checkNearestPoi{
    
    CLLocation * currentLocation = mapView.userLocation.location;
    Poi * nearestPoi = nil;
    int nearestDist = 0;
    for(Poi * p in [[itiList objectAtIndex:currentIti] itineraryPois]){
        if(nearestPoi==nil){
            nearestPoi = p;
            nearestDist = [p distanceBetween:currentLocation.coordinate];
        }
        else{
            int curDist = [p distanceBetween:currentLocation.coordinate];
            if(curDist<nearestDist){
                nearestPoi=p;
                nearestDist=curDist;
            }
        }
    }
    int indexPoi = nearestPoi.poiId;
    if(indexPoi == self.currentPoi){
        [self nextPoi];
    }
}

@contexts GuidedTour
- (MKAnnotationView*)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {



    if([annotation isKindOfClass:[MKUserLocation class]]){
        return nil;
    }
    else{
        MKAnnotation * myAnnotation = (MKAnnotation*)annotation;
        static NSString * AnnotationIdentifier = @"AnnotationIdentifier";
        MKAnnotationView *pinView=[self.mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationIdentifier];
        //If one isn't available, create a new one
        if(!pinView){
            pinView=[[MKAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationIdentifier];
        }
        
        int indexPoi = myAnnotation.indexIti+1;
        
        //Basic properties
        //pinView.animatesDrop = YES;
        pinView.canShowCallout = YES;
        //pinView.pinColor = MKPinAnnotationColorGreen;
        NSString * imgUrl;
        if(indexPoi == self.currentPoi){
            imgUrl = [NSString stringWithFormat:@"number%d", indexPoi];
        }
        else imgUrl = [NSString stringWithFormat:@"number%d_grey", indexPoi];
        pinView.image = [[self.cacheManager imagesDico] objectForKey:imgUrl];
        
        UIButton * righButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
        righButton.tag = [[myAnnotation poi] poiId];
        [righButton setTitle:[myAnnotation.poi name] forState:UIControlStateNormal];
        pinView.rightCalloutAccessoryView = righButton;
        
        return pinView;
    }
}

@end
