//
//  ScheduleDay.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 06/05/12.
//

#import "ScheduleDay.h"

@implementation ScheduleDay
@synthesize dayStop, dayStart;

- (id)initWithStart:(NSDate*)s end:(NSDate*)e {
    self = [super init];
    if (self) {
        // Initialization code here.
        self.dayStart = s;
        self.dayStop = e;
    }
    
    return self;
}

-(BOOL)isInDay:(NSDate*) date{
    NSComparisonResult checkStartAfterStop = [self.dayStart compare:self.dayStop];
    NSComparisonResult checkAfter = [self.dayStart compare:date];
    NSComparisonResult checkBefore = [self.dayStop compare:date];
    BOOL result = (checkAfter!=NSOrderedDescending && checkBefore!=NSOrderedAscending);
    
    return result;
}

@end