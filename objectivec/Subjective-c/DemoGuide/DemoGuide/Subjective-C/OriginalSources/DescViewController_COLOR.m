//
//  DescViewController_COLOR.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 12/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "DescViewController_COLOR.h"

@implementation DescViewController (DescViewController_COLOR)

@contexts ColoredCategories
- (void)setupView:(Poi*)curPoi {

    self.backgroundLabel.backgroundColor = [[curPoi categoryPoi] catColor];
    self.addressPoi.backgroundColor = [[curPoi categoryPoi] catColor];
    ^{
[self  resendSelector:__SCOriginalSelector
  withContextSelector:__SCContextSelector
          returnValue:NULL, curPoi];

}();
}

@contexts !ColoredCategories
- (void)setupView:(Poi*)curPoi {
    
    self.backgroundLabel.backgroundColor = [UIColor grayColor];
    self.addressPoi.backgroundColor = [UIColor grayColor];
    ^{
        [self  resendSelector:__SCOriginalSelector
          withContextSelector:__SCContextSelector
                  returnValue:NULL, curPoi];
        
    }();
}

@end
