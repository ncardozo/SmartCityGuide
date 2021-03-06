//
//  ContextsViewController.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 13/11/11.
//

#import <UIKit/UIKit.h>
#import "DemoGuideAppDelegate.h"

@interface ContextsViewController : UITableViewController{
    NSArray * contextNames;
    NSArray * sectionNames;
    CacheManager * cacheManager;
}

@property (retain, nonatomic) NSArray * contextNames;
@property (retain, nonatomic) NSArray * sectionNames;
@property (retain, nonatomic) CacheManager * cacheManager;


@end