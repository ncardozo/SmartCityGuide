//
//  DetailViewController.h
//  SmartCityGuide
//
//  Created by NicolasCardozo on 14/11/2015.
//  Copyright (c) 2015 NicolasCardozo. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@end

