//
//  YQDateTool.m
//  OA
//
//  Created by winstrong on 16/9/8.
//  Copyright © 2016年 yiqiang. All rights reserved.
//

#import "ZFDateTool.h"

@implementation ZFDateTool

#pragma mark ---日期处理--
// 总天数
- (NSInteger)totaldaysInMonth:(NSDate *)date
{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}
// 上一个月
- (NSDate *)lastMonth:(NSDate *)date intervalMonth:(NSInteger)interval
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = - interval;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
// 下一个月
- (NSDate *)nextMonth:(NSDate *)date intervalMonth:(NSInteger)interval
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = + interval;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
// 间隔N个月
- (NSDate *)intervalMonth:(NSDate *)date intervalNum:(NSInteger)interval
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = interval;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}
// 天
- (NSInteger)day:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components day];
}
// 月份
- (NSInteger)month:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components month];
}
// 年份
- (NSInteger)year:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    return [components year];
}
// 首日是星期几
- (NSInteger)firstWeekdayInMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}
/**
 *  Date转String
 */
- (NSString *)dateChangeString:(NSDate *)date
{
    NSString *dateStr = @"";
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM"];
    dateStr = [formatter stringFromDate:date];
    
    return dateStr;
}
/**
 *  String转Date
 */
- (NSDate *)stringChangeDate:(NSString *)dateStr
{
    NSDate *newDate;
    NSDateFormatter *formatter1 = [[NSDateFormatter alloc] init];
    
    if (dateStr.length==16) {
        [formatter1 setDateFormat:@"yyyy-MM-dd HH:mm"];
    }else {
        [formatter1 setDateFormat:@"yyyy-MM-dd"];
    }
    
    newDate = [formatter1 dateFromString:dateStr];
    
    return newDate;
}

@end
