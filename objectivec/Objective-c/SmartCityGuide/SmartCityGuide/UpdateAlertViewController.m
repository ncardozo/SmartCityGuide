//
//  UpdateAlertViewController.m
//  DemoGuide
//
//  Created by Nicolas Cardozo on 15/12/15.
//

#import "UpdateAlertViewController.h"

@implementation UpdateAlertViewController
@synthesize message, titleAlert, alertView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.message = @"msg";
        self.titleAlert = @"Database update";
        self.alertView = [[UIAlertView alloc] initWithTitle:self.title message:self.message delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Update", nil];
    }
    return self;
}

-(void) showAlert{
    self.alertView.message = self.message;
    self.alertView.title = self.title;
    [self.alertView show];
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==0){//CANCEL
        
    } else{//OK
        NSLog(@"update complete");  
    }
}

@end