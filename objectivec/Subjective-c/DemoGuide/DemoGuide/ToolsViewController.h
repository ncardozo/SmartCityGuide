//
//  ToolsViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"
#import "ToolsLangViewController.h"
#import "ToolsCategoriesViewController.h"
#import "UpdateAlertViewController.h"

@interface ToolsViewController : UITableViewController{
    DemoGuideAppDelegate * appDelegate;
    NSArray * toolsOption;
    ToolsLangViewController * langView;
    ToolsCategoriesViewController * catView;
    NSString * updateMessage;
    UpdateAlertViewController * updateAlert;
}

@property (retain, nonatomic) NSArray * toolsOption;
@property (retain, nonatomic) DemoGuideAppDelegate * appDelegate;
@property (retain, nonatomic) ToolsLangViewController * langView;
@property (retain, nonatomic) ToolsCategoriesViewController * catView;

@property (retain, nonatomic) NSString * updateMessage;
@property (retain, nonatomic) UpdateAlertViewController * updateAlert;

-(void) timeAdaptationToggled;
-(void) updateDataAction;
@end