//
//  YQDateTool.h
//  OA
//
//  Created by winstrong on 16/9/8.
//  Copyright © 2016年 yiqiang. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZFDateTool : UIViewController

// 总天数
- (NSInteger)totaldaysInMonth:(NSDate *)date;
// 上一个月
- (NSDate *)lastMonth:(NSDate *)date intervalMonth:(NSInteger)interval;
// 下一个月
- (NSDate *)nextMonth:(NSDate *)date intervalMonth:(NSInteger)interval;
// 间隔N个月
- (NSDate *)intervalMonth:(NSDate *)date intervalNum:(NSInteger)interval;
// 天
- (NSInteger)day:(NSDate *)date;
// 月份
- (NSInteger)month:(NSDate *)date;
// 年份
- (NSInteger)year:(NSDate *)date;
// 首日是星期几
- (NSInteger)firstWeekdayInMonth:(NSDate *)date;
/**
 *  Date转String
 */
- (NSString *)dateChangeString:(NSDate *)date;
/**
 *  String转Date
 */
- (NSDate *)stringChangeDate:(NSString *)dateStr;

@end
