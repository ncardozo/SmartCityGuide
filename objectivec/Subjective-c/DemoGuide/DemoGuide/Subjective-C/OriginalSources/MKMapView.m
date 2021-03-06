/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

/*
This file was autogenerated with SubjectiveParser 2.0.
Base file: /Users/guillaumekaisin/Dropbox/Mémoire/code/DemoGuide/DemoGuide/MKMapView.m.
*/

//
//  MKMapView.m
//  DemoGuide
//
//  Created by Kim Mens on 21/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "MKMapView.h"

@implementation MKMapView (zoomToFit)


#pragma mark -
#pragma mark Zoom to Fit

- (void)zoomToFitOverlays {
    [self zoomToFitOverlaysAnimated:YES];
}

- (void)zoomToFitOverlay:(id<MKOverlay>)anOverlay {
    [self zoomToFitOverlay:[NSArray arrayWithObject:anOverlay] animated:YES];
}

- (void)zoomToFitOverlays:(NSArray *)someOverlays {
    [self zoomToFitOverlays:someOverlays animated:YES];
}

- (void)zoomToFitOverlaysAnimated:(BOOL)animated {
    [self zoomToFitOverlays:self.overlays animated:animated];
}

- (void)zoomToFitOverlay:(id<MKOverlay>)anOverlay animated:(BOOL)animated {
    [self zoomToFitOverlays:[NSArray arrayWithObject:anOverlay] animated:YES];  
}

- (void)zoomToFitOverlays:(NSArray *)someOverlays animated:(BOOL)animated {
    [self zoomToFitOverlays:someOverlays animated:animated insetProportion:.1];
}

- (void)zoomToFitOverlays:(NSArray *)someOverlays animated:(BOOL)animated insetProportion:(CGFloat)insetProportion {
    //Check
    if ( !someOverlays || !someOverlays.count ) {
        return;
    }
    
    //Union
    MKMapRect mapRect = MKMapRectNull;
    if ( someOverlays.count == 1 ) {
        mapRect = ((id<MKOverlay>)someOverlays.lastObject).boundingMapRect;
    } else {
        for ( id<MKOverlay> anOverlay in someOverlays ) {
            mapRect = MKMapRectUnion(mapRect, anOverlay.boundingMapRect);
        }
    }
    
    //Inset
    CGFloat inset = (CGFloat)(mapRect.size.width*insetProportion);
    mapRect = [self mapRectThatFits:MKMapRectInset(mapRect, inset, inset)];
    
    //Set
    MKCoordinateRegion region = MKCoordinateRegionForMapRect(mapRect);
    [self setRegion:region animated:animated];
}

@end

