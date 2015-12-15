//
//  ToolsCategoriesViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 04/03/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"

@interface ToolsCategoriesViewController : UITableViewController{
    DemoGuideAppDelegate * appDelegate;
    NSMutableArray * selectedCategories;
}

@property (retain, nonatomic) DemoGuideAppDelegate * appDelegate;
@property (retain, nonatomic) NSMutableArray * selectedCategories;

@end