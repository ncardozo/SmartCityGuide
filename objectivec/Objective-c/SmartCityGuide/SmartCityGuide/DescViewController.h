//
//  DescViewController.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 15/12/15.
//

#import <UIKit/UIKit.h>
#import "Poi.h"
#import "Description.h"

@interface BaseDescViewController : UIViewController {
    
}
@property (retain, nonatomic) IBOutlet UIScrollView *scrollView;
@property (retain, nonatomic) IBOutlet UILabel *titleLabel;
@property (retain, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (retain, nonatomic) IBOutlet UIImageView *imagePoi;
@property (retain, nonatomic) IBOutlet UILabel *addressPoi;
@property (retain, nonatomic) IBOutlet UILabel *descText;
@property (retain, nonatomic) IBOutlet UILabel *backgroundLabel;

-(void) setupView:(Poi*) curPoi;

@end

@interface DescViewControllerColor : BaseDescViewController
- (void) setupView:(Poi*) curPoi;
@end

@interface DescViewController : BaseDescViewController {
    IBOutlet UIScrollView *scrollView;
    IBOutlet UILabel *titleLabel;
    IBOutlet UILabel *subtitleLabel;
    IBOutlet UIImageView *imagePoi;
    IBOutlet UILabel *addressPoi;
    IBOutlet UILabel *descText;
    IBOutlet UILabel *backgroundLabel;
    
    id strategy;
}

-(void) setupView:(Poi*) curPoi;
+(void) setStrategy: (id) _strategy;

@end