//
//  ToolsViewController.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 15/12/15.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"
#import "ToolsLangViewController.h"
#import "ToolsCategoriesViewController.h"
#import "UpdateAlertViewController.h"


@interface BaseToolsViewController : UITableViewController {
}

@property (retain, nonatomic) NSArray * toolsOption;
@property (retain, nonatomic) DemoGuideAppDelegate * appDelegate;
@property (retain, nonatomic) ToolsLangViewController * langView;
@property (retain, nonatomic) ToolsCategoriesViewController * catView;

@property (retain, nonatomic) NSString * updateMessage;
@property (retain, nonatomic) UpdateAlertViewController * updateAlert;

@end

@interface ToolsViewControllerLowMemory : BaseToolsViewController 
- (void)updateDataAction;
@end

@interface ToolsViewControllerLowBattery : BaseToolsViewController
- (void) updateDataAction;
@end

@interface ToolsViewController3G : BaseToolsViewController
- (void) updateDataAction;
@end

@interface ToolsViewControllerWifi : BaseToolsViewController
- (void) updateDataAction;
@end

@interface ToolsViewControllerDisconnected : BaseToolsViewController
- (void) updateDataAction;
@end

@interface ToolsViewController : BaseToolsViewController {
    DemoGuideAppDelegate * appDelegate;
    NSArray * toolsOption;
    ToolsLangViewController * langView;
    ToolsCategoriesViewController * catView;
    NSString * updateMessage;
    UpdateAlertViewController * updateAlert;
    
    id strategy;
}

-(void) timeAdaptationToggled;
-(void) updateDataAction;
+(void) setStrategy: (id) _strategy;
@end