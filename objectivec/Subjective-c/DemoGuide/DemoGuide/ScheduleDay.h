//
//  ScheduleDay.h
//  DemoGuide
//
//  Created by Guillaume Kaisin on 06/05/12.
//

#import <Foundation/Foundation.h>

@interface ScheduleDay : NSObject{
    NSDate * dayStart;
    NSDate * dayStop;
}

@property(retain, nonatomic) NSDate * dayStart;
@property(retain, nonatomic) NSDate * dayStop;

-(BOOL) isInDay:(NSDate *) date;
- (id)initWithStart:(NSDate *)s end:(NSDate *)e;

@end