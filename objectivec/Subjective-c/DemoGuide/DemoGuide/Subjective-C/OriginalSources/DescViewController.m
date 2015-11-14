//
//  DescViewController.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DescViewController.h"

@implementation DescViewController
@synthesize titleLabel, subtitleLabel, imagePoi, addressPoi, descText, scrollView, backgroundLabel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void) setupView:(Poi*)curPoi{    
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

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [titleLabel release];
    titleLabel = nil;
    [subtitleLabel release];
    subtitleLabel = nil;
    [imagePoi release];
    imagePoi = nil;
    [addressPoi release];
    addressPoi = nil;
    [descText release];
    descText = nil;
    [scrollView release];
    scrollView = nil;
    [backgroundLabel release];
    backgroundLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [titleLabel release];
    [subtitleLabel release];
    [imagePoi release];
    [addressPoi release];
    [descText release];
    [scrollView release];
    [backgroundLabel release];
    [super dealloc];
}
@end
