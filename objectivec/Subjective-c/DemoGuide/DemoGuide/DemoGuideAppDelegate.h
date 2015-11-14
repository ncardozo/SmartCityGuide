//
//  DemoGuideAppDelegate.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CacheManager.h"
#import "ContextsManager.h"

@interface DemoGuideAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    CacheManager * cacheManager;
    ContextsManager * contextManager;
    
}

- (void)copyDatabaseIfNeeded:(BOOL)needUpdate;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) CacheManager * cacheManager;
@property (nonatomic, retain) ContextsManager * contextManager;

@end