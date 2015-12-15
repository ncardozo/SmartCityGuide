//
//  ToolsCategoriesViewController.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 15/12/15.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"

@interface BaseToolsCategoriesViewController : UITableViewController{
    }
@property (retain, nonatomic) DemoGuideAppDelegate * appDelegate;
@property (retain, nonatomic) NSMutableArray * selectedCategories;

@end

@interface ToolsCategoriesViewControllerColor : BaseToolsCategoriesViewController {}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface ToolsCategoriesViewController : BaseToolsCategoriesViewController {
    DemoGuideAppDelegate * appDelegate;
    NSMutableArray * selectedCategories;
    id strategy;
}

+ (void) setStrategy: (id) _strategy;

@end