//
//  Schedule.h
//  DemoGuide
//
//  Created by Nicolas Cardozo on 19/11/15.
//

#import <Foundation/Foundation.h>
#import "ScheduleDay.h"


@interface Schedule : NSObject {
    NSDictionary * timeDictionary;
    NSDateFormatter * dateFormatter;
    NSDate * today;
}

@property (retain, nonatomic) NSDictionary * timeDictionary;
@property (retain, nonatomic) NSDateFormatter * dateFormatter;
@property (retain, nonatomic) NSDate * today;

- (BOOL)isInSchedule:(NSDate*)now;
- (id) initWithWeek:(NSMutableArray*)weekSchedule;


@end