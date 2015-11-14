//
//  DemoGuideAppDelegate.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "DemoGuideAppDelegate.h"

@implementation DemoGuideAppDelegate

@synthesize window = _window;
@synthesize tabBarController = _tabBarController;
@synthesize cacheManager, contextManager;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    // Add the tab bar controller's current view as a subview of the window
    [self copyDatabaseIfNeeded:FALSE];
    [[SCContextManager sharedContextManager] activateContextWithName:@"French"];
    
    self.cacheManager = [[CacheManager alloc] init];
    self.contextManager = [[ContextsManager alloc] init];
    
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

- (void)dealloc {
    [cacheManager release];
    [contextManager release];
    [_window release];
    [_tabBarController release];
    [super dealloc];
}

- (void)copyDatabaseIfNeeded:(BOOL)needUpdate {
	
	//Using NSFileManager we can perform many file system operations.
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSError *error;
    
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDir = [documentPaths objectAtIndex:0];
    NSString *dbPath = [documentsDir stringByAppendingPathComponent:@"miniDB.sqlite"];

    BOOL removeSuccess = [fileManager removeItemAtPath:dbPath error:&error];
    
	//NSString *dbPath = @"/Users/guillaumekaisin/Dropbox/Mémoire/donnees_app/miniDB.sqlite";
	BOOL success = [fileManager fileExistsAtPath:dbPath]; 
	
	if(!success) {
		
		NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"miniDB.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		NSLog(@"Database file copied from bundle to %@", dbPath);
		
    if (!success)
			NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
	} else {
		NSLog(@"Database file found at path %@", dbPath);
        NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"miniDB.sqlite"];
		success = [fileManager copyItemAtPath:defaultDBPath toPath:dbPath error:&error];
		
	}
}

@end