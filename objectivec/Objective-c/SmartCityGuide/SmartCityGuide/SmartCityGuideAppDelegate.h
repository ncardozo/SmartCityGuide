//
//  SmartCityGuideAppDelegate.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 17/12/15.
//

#import <UIKit/UIKit.h>
#import "CacheManager.h"
#import "ContextsManager.h"

@interface SmartCityGuideAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate>{
    CacheManager * cacheManager;
    ContextsManager * contextManager;
    
}

- (void)copyDatabaseIfNeeded:(BOOL)needUpdate;

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet UITabBarController *tabBarController;

@property (nonatomic, retain) CacheManager * cacheManager;
@property (nonatomic, retain) ContextsManager * contextManager;

@end