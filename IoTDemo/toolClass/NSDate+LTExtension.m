//
//  NSDate+LTExtension.m
//  KamHinLogisticsShipper
//
//  Created by 冰凌天 on 2017/11/9.
//  Copyright © 2017年 冰凌天. All rights reserved.
//

#import "NSDate+LTExtension.h"
#import "BasicConfiguration.h"
@implementation NSDate (LTExtension)

- (NSDateComponents *)components
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSCalendarUnit unit = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday);
    return [calendar components:unit fromDate:self];
}

+ (NSDateComponents *)components
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit unit = (NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday);
    return [calendar components:unit fromDate:[NSDate date]];
}

+ (NSDate *)dateWithComponents:(NSDateComponents *)components
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar dateFromComponents:components];
}

+ (NSDate *)dateWithDateString:(NSString *)dateString dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)dateStringWithDate:(NSDate *)date dateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [dateFormatter stringFromDate:date];
}

- (NSString *)dateStringByDateFormat:(NSString *)dateFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = dateFormat;
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    return [dateFormatter stringFromDate:self];
}

#pragma mark - < 年 月 日 时 分 秒 - 对象方法 >

- (NSInteger)year
{
    return self.components.year;
}

- (NSInteger)month
{
    return self.components.month;
}

- (NSInteger)day
{
    return self.components.day;
}

- (NSInteger)hour
{
    return self.components.hour;
}

- (NSInteger)minute
{
    return self.components.minute;
}

- (NSInteger)second
{
    return self.components.second;
}

#pragma mark - < 年 月 日 时 分 秒 - 类方法 >

+ (NSInteger)year
{
    return  [NSDate date].year;
}

+ (NSInteger)month
{
    return [NSDate date].month;
}

+ (NSInteger)day
{
    return [NSDate date].day;
}

+ (NSInteger)hour
{
    return [NSDate date].hour;
}

+ (NSInteger)minute
{
    return [NSDate date].minute;
}

+ (NSInteger)second
{
    return [NSDate date].second;
}

#pragma mark - < 上个月, 下个月 >

- (NSDate *)lastMonth
{
    NSDateComponents *components = self.components;
    components.month -= 1;
    return [NSDate dateWithComponents:components];
}

- (NSDate *)nextMonth
{
    NSDateComponents *components = self.components;
    components.month += 1;
    return [NSDate dateWithComponents:components];
}

#pragma mark - < 时间比较 >

/**
 比较时间, 当前时间是否大于指定时间

 @param date 被比较的时间
 @return 比较结果
 */
- (BOOL)isGreaterThanOtherDate:(NSDate *)date
{
    return [self timeIntervalSince1970] > [date timeIntervalSince1970];
}

#pragma mark - < 时间戳 >

- (NSInteger)timestamp
{
    return (NSInteger)[self timeIntervalSince1970];
}

#pragma mark - < 当前年月, 英文 >

- (NSString *)currentMonthForEnglish
{
    
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
          dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[Localisator sharedInstance].currentLanguage];
    NSMutableArray *days = [[dateFormatter standaloneMonthSymbols] mutableCopy];
      NSInteger index = (self.month+11)%12;
       if (days.count && days.count>index) {
           return [days objectAtIndex:index];
       }
    switch (self.month) {
        case 1:
        {
            return @"January";
        }
            break;
        case 2:
        {
            return @"February";
        }
            break;
        case 3:
        {
            return @"March";
        }
            break;
        case 4:
        {
            return @"April";
        }
            break;
        case 5:
        {
            return @"May";
        }
            break;
        case 6:
        {
            return @"June";
        }
            break;
        case 7:
        {
            return @"July";
        }
            break;
        case 8:
        {
            return @"August";
        }
            break;
        case 9:
        {
            return @"September";
        }
            break;
        case 10:
        {
            return @"October";
        }
            break;
        case 11:
        {
            return @"November";
        }
            break;
        case 12:
        {
            return @"December";
        }
            break;
            
        default:
            break;
    }
    return @"";
}
#pragma mark - < 当前周, 英文 >
-(NSString *)currentWeekForEnglish{
    
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    
    dateFormatter.timeZone = [NSTimeZone systemTimeZone];
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:[Localisator sharedInstance].currentLanguage];
    
    NSMutableArray *days = [[dateFormatter shortStandaloneWeekdaySymbols] mutableCopy];
    
    NSInteger index = (self.weakDay+6)%7;
    
    if (days.count && days.count>index) {
        return [days objectAtIndex:index];
    }
    switch (self.weakDay) {
        case 1:
        {
            return @"Sunday";
        }
            break;
        case 2:
        {
            return @"Monday";
        }
            break;
        case 3:
        {
            return @"Tuesday";
        }
            break;
        case 4:
        {
            return @"Wednesday";
        }
            break;
        case 5:
        {
            return @"Thursday";
        }
            break;
        case 6:{
            return @"Friday";
        }
            break;
        case 7:
        {
            return @"Saturday";
        }
            break;
      
        default:
            break;
    }
    return @"";
}
#pragma mark - < 当月天数 >

/**
 当月天数
 */
- (NSInteger)daysCountInCurrentMonth
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    return [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:self].length;
}

/**
 当月第一天
 */
- (NSDate *)firstDayInCurrentMonth
{
    NSDateComponents *components = [self components];
    components.day = 1;
    return [NSDate dateWithComponents:components];
}

/**
 当月最后一天
 */
- (NSDate *)lastDayInCurrentMonth
{
    NSDateComponents *components = [self components];
    components.day = [self daysCountInCurrentMonth];
    return [NSDate dateWithComponents:components];
}
/**
 星期几 1: 星期日, 2: 星期一, 3: 星期二, 4, 星期三, 5: 星期四, 6: 星期五, 7: 星期六
 */
- (NSInteger)weakDay
{
    NSDateComponents *components = [self components];
    return components.weekday;
}

/**
 是否是今天
 */
- (BOOL)isToday
{
    NSDate *date = [NSDate date];
    return self.year == date.year && self.month == date.month && self.day == date.day;
}

/**
 是否和指定日期为同一天
 */
- (BOOL)isOnSameDayWithDate:(NSDate *)date
{
    return self.year == date.year && self.month == date.month && self.day == date.day;
}

/**
 是否和指定日期为同一月
 */
- (BOOL)isOnSameMonthWithDate:(NSDate *)date
{
    return self.year == date.year && self.month == date.month;
}

#pragma mark - < 转换 >
+(NSDate *)dateWithTimestampString:(NSString *)timestampString{
    CGFloat timestamp = [timestampString doubleValue]/1000;
     NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return date;
}
+ (NSString *)dateStringWithTimestampString:(NSString *)timestampString
{
    return [self dateStringWithTimestamp:timestampString.integerValue];
}

+ (NSString *)dateStringWithTimestamp:(NSInteger)timestamp;
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestamp];
    return [date dateStringByDateFormat:@"HH:mm"];
}

- (NSString *)localDateFormat
{
    NSString *format =[BasicConfiguration sharedInstance].dateFormate ;
    format = [format stringByReplacingOccurrencesOfString:@"DD" withString:@"dd"];
    format = [format stringByReplacingOccurrencesOfString:@"YYYY" withString:@"yyyy"];
    return [self dateStringByDateFormat:format];
}

- (NSString *)localTimeFormat
{
    //NSInteger index =0;// [LTSaveLocalTool timeFormat];
    NSString *format = [BasicConfiguration sharedInstance].timeFormate ;
//    if (index == 0) {
//        format = @"hh:mm a";
//    }
    return [self dateStringByDateFormat:format];
}

- (NSString *)stringByLocalTimeFormatAndLocalDateFormat
{
    return [NSString stringWithFormat:@"%@ %@", self.localDateFormat, self.localTimeFormat];
}

+ (NSString *)stringByLocalTimeFormatAndLocalDateFormatWithTimestampString:(NSString *)timestampString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampString.integerValue];
    return [NSString stringWithFormat:@"%@ %@", date.localDateFormat, date.localTimeFormat];
}

#pragma mark - < 精简版格式化, 例如 MM/dd/yy hh:mma >

- (NSString *)localDateFormatForStreamline
{
    NSString *format = [BasicConfiguration sharedInstance].dateFormate;
    format = [format stringByReplacingOccurrencesOfString:@"DD" withString:@"dd"];
    format = [format stringByReplacingOccurrencesOfString:@"YYYY" withString:@"yy"];
    return [self dateStringByDateFormat:format];
}

- (NSString *)localTimeFormatForStreamline
{
//    NSInteger index = [LTSaveLocalTool timeFormat];
    NSString *format = [BasicConfiguration sharedInstance].timeFormate;
    //if (index == 0) {
      //  format = @"hh:mma";
 //   }
    return [self dateStringByDateFormat:format];
}

- (NSString *)stringByLocalTimeFormatAndLocalDateFormatForStreamline
{
    return [NSString stringWithFormat:@"%@ %@", self.localDateFormatForStreamline, self.localTimeFormatForStreamline];
}

+ (NSString *)stringByLocalTimeFormatAndLocalDateFormatForStreamlineWithTimestampString:(NSString *)timestampString
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timestampString.integerValue];
    return [NSString stringWithFormat:@"%@ %@", date.localDateFormatForStreamline, date.localTimeFormatForStreamline];
}
@end
