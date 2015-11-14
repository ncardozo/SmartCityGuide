//
//  UpdateAlertViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 06/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UpdateAlertViewController : UIViewController <UIAlertViewDelegate>{
    NSString * message;
    NSString * title;
    UIAlertView * alertView;
}

@property(retain, nonatomic) NSString * message;
@property(retain, nonatomic) NSString * titleAlert;
@property(retain, nonatomic) UIAlertView * alertView;

-(void) showAlert;

@end