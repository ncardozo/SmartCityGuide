//
//  main.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/11/11.
//

#import <UIKit/UIKit.h>
#import "ContextsInitializer.h"

int main(int argc, char *argv[]) {
    ContextsInitializer *ci = [[ContextsInitializer alloc] init];
    [ci initializeContexts];
    [ci release];
    
    int retVal = UIApplicationMain(argc, argv, nil, nil);
    return retVal;
}