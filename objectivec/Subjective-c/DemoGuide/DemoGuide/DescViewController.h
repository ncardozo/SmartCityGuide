//
//  DescViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Poi.h"
#import "Description.h"

@interface DescViewController : UIViewController{
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *subtitleLabel;
    IBOutlet UIImageView *imagePoi;
    IBOutlet UILabel *addressPoi;
    IBOutlet UILabel *descText;
    IBOutlet UILabel *backgroundLabel;
}

@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imagePoi;
@property (retain, nonatomic) IBOutlet UILabel *addressPoi;
@property (retain, nonatomic) IBOutlet UILabel *descText;
@property (retain, nonatomic) IBOutlet UILabel *backgroundLabel;

-(void) setupView:(Poi*)curPoi;

@end