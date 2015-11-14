//
//  main.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ContextsInitializer.h"

int main(int argc, char *argv[]) {
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    ContextsInitializer *ci = [[ContextsInitializer alloc] init];
    [ci initializeContexts];
    [ci release];
    
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    [pool release];
    return retVal;
}