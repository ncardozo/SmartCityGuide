//
//  DescViewController.m
//  DemoGuide
//
//  Created by Nicolas Cardozo on 17/11/15.
//

#import "DescViewController.h"

@implementation BaseDescViewController
- (void)setupView:(Poi*) curPoi {
    self.titleLabel.text = [curPoi name];
    self.subtitleLabel.text = [curPoi category];
    self.descText.text = [curPoi descriptionString];
    [self.descText sizeToFit];
    self.imagePoi.image = [curPoi image];
    self.addressPoi.text = [NSString stringWithFormat:@"%@\n%@",[curPoi address], @"1348 Louvain La Neuve"];
    self.addressPoi.backgroundColor = [UIColor grayColor];
    int textheight = self.descText.frame.size.height;
    [self.scrollView setContentSize:CGSizeMake(320, 290+textheight)];
    [self.scrollView setScrollEnabled:YES];
}
@end

@implementation DescViewControllerColor
- (void)setupView:(Poi*) curPoi {
    self.backgroundLabel.backgroundColor = [[curPoi categoryPoi] catColor];
    self.addressPoi.backgroundColor = [[curPoi categoryPoi] catColor];
    [super setupView: curPoi];
}
@end

@implementation DescViewController
@synthesize titleLabel, subtitleLabel, imagePoi, addressPoi, descText, scrollView, backgroundLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) setupView:(Poi*)curPoi {    
    self.backgroundLabel.backgroundColor = [UIColor grayColor];
    self.addressPoi.backgroundColor = [UIColor grayColor];
    [super setupView: curPoi];
}

#pragma mark - View lifecycle
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload {
    titleLabel = nil;
    subtitleLabel = nil;
    imagePoi = nil;
    addressPoi = nil;
    descText = nil;
    scrollView = nil;
    backgroundLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

+ (void) setStrategy:(id)_strategy {
    self.strategy = _strategy;
}
@end