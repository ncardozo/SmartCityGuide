//
//  ToolsLangViewController.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 15/12/15.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"

@interface ToolsLangViewController : UITableViewController{
    DemoGuideAppDelegate * appDelegate;
    NSArray * langList;
    NSIndexPath * lastIndexPath;
}

@property (retain, nonatomic) NSArray * langList;
@property (retain, nonatomic) DemoGuideAppDelegate * appDelegate;
@property (retain, nonatomic) NSIndexPath * lastIndexPath;

@end