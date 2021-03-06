//
//  ToolsLangViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
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