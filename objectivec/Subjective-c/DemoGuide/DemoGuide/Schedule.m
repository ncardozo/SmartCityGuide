//
//  Schedule.m
//  DemoGuide
//
//  Created by Guillaume Kaisin on 06/05/12.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Schedule.h"

@implementation Schedule
@synthesize timeDictionary, dateFormatter, today;

- (id) initWithWeek:(NSMutableArray*)weekSchedule{
    self = [super init];
    if (self) {
        NSArray * dayArray = [NSArray arrayWithObjects:@"lundi",@"mardi",@"mercredi", @"jeudi",@"vendredi",@"samedi",@"dimanche",nil];
        self.timeDictionary = [NSDictionary dictionaryWithObjects:weekSchedule forKeys:dayArray];
        
        self.dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"HH:mm"];
    }
    
    return self;
}

- (BOOL)isInSchedule:(NSDate*)now{
    NSString * hourString = [self.dateFormatter stringFromDate:now];
    [self.dateFormatter setDateFormat:@"EEEE"];
    NSString * dayString = [self.dateFormatter stringFromDate:now];
    [self.dateFormatter setDateFormat:@"HH:mm"];
    NSDate * nowDate = [self.dateFormatter dateFromString:hourString];
    ScheduleDay * scheduleDay = [self.timeDictionary objectForKey:dayString];
    
    return [scheduleDay isInDay:nowDate];
}

@end