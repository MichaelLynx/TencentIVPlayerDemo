//
//  NSDate+LTExtension.h
//  KamHinLogisticsShipper
//
//  Created by 冰凌天 on 2017/11/9.
//  Copyright © 2017年 冰凌天. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (LTExtension)

- (NSDateComponents *)components;

+ (NSDateComponents *)components;

+ (NSDate *)dateWithComponents:(NSDateComponents *)components;

+ (NSDate *)dateWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat;

+ (NSString *)dateStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat;

- (NSString *)dateStringByDateFormat:(NSString *)dateFormat;

#pragma mark - < 年 月 日 时 分 秒 - 对象方法 >

- (NSInteger)year;

- (NSInteger)month;

- (NSInteger)day;

- (NSInteger)hour;

- (NSInteger)minute;

- (NSInteger)second;

#pragma mark - < 年 月 日 时 分 秒 - 类方法 >

+ (NSInteger)year;

+ (NSInteger)month;

+ (NSInteger)day;

+ (NSInteger)hour;

+ (NSInteger)minute;

+ (NSInteger)second;

#pragma mark - < 上个月, 下个月 >

- (NSDate *)lastMonth;

- (NSDate *)nextMonth;

#pragma mark - < 时间比较 >

/**
 比较时间, 当前时间是否大于指定时间
 
 @param date 被比较的时间
 @return 比较结果
 */
- (BOOL)isGreaterThanOtherDate:(NSDate *)date;

#pragma mark - < 时间戳 >

- (NSInteger)timestamp;

#pragma mark - < 当前年月, 英文 >

- (NSString *)currentMonthForEnglish;
#pragma mark - < 当前周, 英文 >
-(NSString *)currentWeekForEnglish;
#pragma mark - < 当月天数 >

/**
 当月天数
 */
- (NSInteger)daysCountInCurrentMonth;

/**
 当月第一天
 */
- (NSDate *)firstDayInCurrentMonth;

/**
 当月最后一天
 */
- (NSDate *)lastDayInCurrentMonth;

/**
 星期几 1: 星期日, 2: 星期一, 3: 星期二, 4, 星期三, 5: 星期四, 6: 星期五, 7: 星期日
 */
- (NSInteger)weakDay;

/**
 是否是今天
 */
- (BOOL)isToday;

/**
 是否和指定日期为同一天
 */
- (BOOL)isOnSameDayWithDate:(NSDate *)date;

/**
 是否和指定日期为同一月
 */
- (BOOL)isOnSameMonthWithDate:(NSDate *)date;


#pragma mark - < 转换 >
+(NSDate *)dateWithTimestampString:(NSString *)timestampString;

+ (NSString *)dateStringWithTimestampString:(NSString *)timestampString;

+ (NSString *)dateStringWithTimestamp:(NSInteger)timestamp;;

- (NSString *)localDateFormat;

- (NSString *)localTimeFormat;

- (NSString *)stringByLocalTimeFormatAndLocalDateFormat;

+ (NSString *)stringByLocalTimeFormatAndLocalDateFormatWithTimestampString:(NSString *)timestampString;

#pragma mark - < 精简版格式化, 例如 MM/dd/yy hh:mma >

- (NSString *)localDateFormatForStreamline;

- (NSString *)localTimeFormatForStreamline;

- (NSString *)stringByLocalTimeFormatAndLocalDateFormatForStreamline;

+ (NSString *)stringByLocalTimeFormatAndLocalDateFormatForStreamlineWithTimestampString:(NSString *)timestampString;

@end














