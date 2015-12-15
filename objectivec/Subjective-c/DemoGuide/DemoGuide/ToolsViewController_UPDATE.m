//
//  ToolsViewController_UPDATE.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 23/04/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "ToolsViewController_UPDATE.h"

@implementation ToolsViewController (ToolsViewController_UPDATE)

/*
 There can be behavior adaptation according to the following contexts:
 - ConnectionWifi : fast update
 - ConntextionWan : warning slow update
 - No connection : warning no update possible
 - LowMemory : warning pour dire qu'il reste trop peu de mémoire
 - LowBattery : warning pour demander s'il faut lancer l'udpate ou pas
 
 LowMemory
 LowBattery
 ConnectedWifi
 Connected3G
 */

-(void) updateDataAction{
    [self.updateAlert showAlert];
}

@contexts !Connected3G !ConnectedWifi
- (void)updateDataAction{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:@"Database update" message:@"No connection available to update !" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
    [alert show];
}

@contexts ConnectedWifi
- (void)updateDataAction{
    self.updateAlert.message = @"Wifi connection available\n";
    @resend();
}

@contexts Connected3G
- (void)updateDataAction{
    self.updateAlert.message = @"3G connection available\n";
    @resend();
}

@contexts LowMemory
- (void)updateDataAction{
    self.updateAlert.message = [NSString stringWithFormat:@"%@------\n%@", self.updateAlert.message, @"Warning : the free memory on iphone device is limited.  The update is not recommended\n"]
    @resend();
}

@contexts LowBattery
- (void)updateDataAction{
    self.updateAlert.message = [NSString stringWithFormat:@"%@------\n%@", self.updateAlert.message,
                                @"Warning : the battery level of the iphone device is low.  The update is not recommended\n"];
    @resend();
}

@end    