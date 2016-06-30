//
//  Schedule.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 06/05/12.
//

#import <Foundation/Foundation.h>
#import "ScheduleDay.h"

@interface Schedule : NSObject{
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