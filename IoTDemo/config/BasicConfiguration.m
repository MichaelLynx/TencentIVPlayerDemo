//
//  BasicConfiguration.m
//  TimeClock
//
//  Created by Apple on 2019/12/14.
//  Copyright © 2019 Apple. All rights reserved.
// 
//------made in china-------
/**   The code comes frome breakfly
 *
 * 　　　┏┓　　　┏┓
 * 　　┏┛┻━━━┛┻┓
 * 　　┃　　　━　　　┃
 * 　　┃ 　^      ^ 　┃
 * 　　┃　　　┻　　　┃
 * 　　┗━━━━━━━┛
 *
 * --------萌萌哒-------
 */
#import "BasicConfiguration.h"
#import "DefaultPageSource.h"
#import "NSDate+BRPickerView.h"
//#import "TZImagePickerConfig.h"
@interface BasicConfiguration ()

@end

@implementation BasicConfiguration
+ (BasicConfiguration*)sharedInstance
{
    static BasicConfiguration *_sharedInstance = nil;
    
    static dispatch_once_t oncePredicate;
    
    dispatch_once(&oncePredicate, ^{
        _sharedInstance = [[BasicConfiguration alloc] init];
        
    });
    return _sharedInstance;
}


-(void)setDateFormate:(NSString *)dateFormate{
    //保存设置的日期格式
    [[NSUserDefaults standardUserDefaults] setObject:dateFormate forKey:MDDateFormateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //发送日期格式修改通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeDateFormate object:nil];
}
-(NSString *)dateFormate{
    NSString *dateFormate = [[NSUserDefaults standardUserDefaults] objectForKey:MDDateFormateKey];
    if (!dateFormate || [dateFormate isEmptyString]) {
        dateFormate = @"yyyy/MM/dd";
    }
    return dateFormate;
}
-(void)setTimeFormate:(NSString *)timeFormate{
    //保存设置的时间格式
    [[NSUserDefaults standardUserDefaults] setObject:timeFormate forKey:MDTimeFormateKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    //发送时间格式修改通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationChangeTimeFormate object:nil];
}
-(NSString *)dateAndTimeFormate{
    return [NSString stringWithFormat:@"%@ %@",self.dateFormate,self.timeFormate];
}

-(NSString *)timeFormate{
    NSString *timeFormate = [[NSUserDefaults standardUserDefaults] objectForKey:MDTimeFormateKey];
    if (!timeFormate || [timeFormate isEmptyString]) {
        timeFormate = @"hh:mm a";
    }
    return timeFormate;
}

-(NSString *)timeDetailFormate {
    NSString *timeFormate;
    //时间格式 0：24小时制，1：12小时制(AM/PM)
    if ([BasicConfiguration sharedInstance].timeFormateType == 0) {
        timeFormate = @"HH:mm:ss";
    } else {
        timeFormate = @"hh:mm:ss a";
    }
    return timeFormate;
}

///dd-MM-yyyy hh:mm:ss a
-(NSString *)dateDetailFormate {
    NSString *timeFormate;
    //timeFormate = @"MM-dd-yyyy hh:mm:ss a";
    
    timeFormate = [NSString stringWithFormat:@"%@ %@", [BasicConfiguration sharedInstance].dateFormate, self.timeDetailFormate];
    
    return timeFormate;
}

-(NSString *)timeDetailUpFormate {
    NSString *timeFormate = [[NSUserDefaults standardUserDefaults] objectForKey:MDTimeFormateKey];
    if (!timeFormate || [timeFormate isEmptyString]) {
        timeFormate = @"hh:mm:ss";
    }
    return timeFormate;
}

-(NSString *)timeDetailDownFormate {
    NSString *timeFormate = [[NSUserDefaults standardUserDefaults] objectForKey:MDTimeFormateKey];
    if (!timeFormate || [timeFormate isEmptyString]) {
        timeFormate = @"a";
    }
    return timeFormate;
}

- (NSString *)timeUpFormate {
    NSString *timeFormate = [[NSUserDefaults standardUserDefaults] objectForKey:MDTimeFormateKey];
    timeFormate = @"hh:mm";
    return timeFormate;
}

- (NSString *)timeDownFormate {
    NSString *timeFormate = [[NSUserDefaults standardUserDefaults] objectForKey:MDTimeFormateKey];
    timeFormate = @"a";
    return timeFormate;
}

///日期格式 0：yyy-MM-dd，1：dd-MM-yyyy
- (NSInteger)dateFormateType {
    NSString *format = [BasicConfiguration sharedInstance].dateFormate;
    if ([format isEqualToString:@"yyyy/MM/dd"]) {
        return 0;
    } else {
        return 1;
    }
}

///时间格式 0：24小时制，1：12小时制(AM/PM).
- (NSInteger)timeFormateType {
    NSString *format = [BasicConfiguration sharedInstance].timeFormate;
    if ([format isEqualToString:@"hh:mm a"]) {
        return 1;
    } else {
        return 0;
    }
}

+(NSString *)getTimestamp:(NSString*)mStr formatter:(BasiceDateFormate )formattertype{
    
    
   // NSArray *arr = [NSLocale availableLocaleIdentifiers];
    
    
    
    NSTimeInterval interval  =[mStr doubleValue] / 1000.0;
    if (interval<10) {
        return @"";
    }
    
    NSDate *date              = [NSDate dateWithTimeIntervalSince1970:interval];
    
    return [BasicConfiguration getDate:date formatter:formattertype];
}
//格式化时间
+(NSString *)getDate:(NSDate*)date formatter:(BasiceDateFormate )formattertype{
       NSString *dateFormaterString = @"";
    switch (formattertype) {
        case BasiceDateYMDHMS:
             dateFormaterString =[BasicConfiguration getDateFormatterWithDate:date formatterString:[NSString stringWithFormat:@"%@ %@",[BasicConfiguration sharedInstance].dateFormate,[BasicConfiguration sharedInstance].timeFormate]];
            break;
        case BasiceDateYMD:
            dateFormaterString =[BasicConfiguration getDateFormatterWithDate:date formatterString:[NSString stringWithFormat:@"%@",[BasicConfiguration sharedInstance].dateFormate]];
            break;
        case BasiceDateHM:
            dateFormaterString =[BasicConfiguration getDateFormatterWithDate:date formatterString:[NSString stringWithFormat:@"%@",[BasicConfiguration sharedInstance].timeFormate]];
            break;
            
        case BasiceDateWeekHM:{
            dateFormaterString =[BasicConfiguration getDateFormatterWithDate:date formatterString:[NSString stringWithFormat:@"%@",[BasicConfiguration sharedInstance].timeFormate]];
            
            dateFormaterString = [NSString stringWithFormat:@"%@,%@",[date currentWeekForEnglish],dateFormaterString];
        }
            break;
            
        case BasiceDateWeekYMD:{
            dateFormaterString =[BasicConfiguration getDateFormatterWithDate:date formatterString:[NSString stringWithFormat:@"%@",[BasicConfiguration sharedInstance].dateFormate]];
            
            dateFormaterString = [NSString stringWithFormat:@"%@,%@",[date currentWeekForEnglish],dateFormaterString];
        }
            break;
            
        case BasiceDateWeekYMDHMS:{
            dateFormaterString =[BasicConfiguration getDateFormatterWithDate:date formatterString:[NSString stringWithFormat:@"%@ %@",[BasicConfiguration sharedInstance].dateFormate,[BasicConfiguration sharedInstance].timeFormate]];
            
            dateFormaterString = [NSString stringWithFormat:@"%@,%@",[date currentWeekForEnglish],dateFormaterString];
        }
            
            break;
            
        case BasiceDateMonthD:{
            NSString *dateFormater = [BasicConfiguration sharedInstance].dateFormate;
            if ([dateFormater isEqualToString:@"yyyy-MM-dd"]) {
                
                dateFormaterString = [NSString stringWithFormat:@"%@-%02ld",[date currentMonthForEnglish],(long)date.day];
            }else{
                dateFormaterString = [NSString stringWithFormat:@"%02ld-%@",(long)date.day,[date currentMonthForEnglish]];
            }
        }
            break;
            
        case BasiceDateHMS:
            dateFormaterString =[BasicConfiguration getDateFormatterWithDate:date formatterString:[NSString stringWithFormat:@"%@",[BasicConfiguration sharedInstance].timeDetailFormate]];
            break;
        default:
            break;
    }

    return dateFormaterString;
}

+(NSString *)getDateFormatterWithDate:(NSDate*)date formatterString:(NSString *)formatterString{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *localZone = [NSTimeZone systemTimeZone];
    [formatter setTimeZone:localZone];
    
    NSString *localeID = [Localisator isChinese] ? @"zh_CN" : @"en";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:localeID];
    
    [formatter setDateFormat:formatterString];
    NSString *dateString  = [formatter stringFromDate: date];
    
    return dateString;
}

+(NSString *)getTimestamp:(NSString*)mStr formatterStr:(NSString *)formatterStr{
    NSTimeInterval interval  =[mStr doubleValue] / 1000.0;
    if (interval<10) {
        return @"";
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    return [BasicConfiguration getDateFormatterWithDate:date formatterString:formatterStr];
}

//服务器时间未转换，需要主动去转换时区。
+(NSString *)getDateFormatterWithOriginDate:(NSDate*)date formatterString:(NSString *)formatterString {
    //更改成根据服务器的时间显示，不再依靠本地。
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    
    NSString *zoneID = [Stockpile sharedStockpile].zoneId;
    NSTimeZone *localZone = [NSTimeZone timeZoneWithName:zoneID];
    [formatter setTimeZone:localZone];
    
    NSString *localeID = [Localisator isChinese] ? @"zh_CN" : @"en";
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:localeID];
    
     [formatter setDateFormat:formatterString];
    NSString *dateString  = [formatter stringFromDate: date];
    
    return dateString;
}

///My Work签到时间显示服务器时间.
+(NSString *)getOriginTimestamp:(NSString*)mStr formatterStr:(NSString *)formatterStr {
    
    NSTimeInterval interval  =[mStr doubleValue] / 1000.0;
    if (interval<10) {
        return @"N/A";
    }
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:interval];
    
    return [BasicConfiguration getDateFormatterWithOriginDate:date formatterString:formatterStr];
}

@end
@implementation BasicClock
-(id)init{
    self=[super init];
    if (self) {
        self.timer= [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timeji) userInfo:nil repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:UITrackingRunLoopMode];
    }
    return self;
}
-(void)timeji{
    NSDate *date =[NSDate date];
    
    if (self.cureFormate && self.block) {
       NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
       
        NSTimeZone *localZone = [NSTimeZone systemTimeZone];
       [formatter setTimeZone:localZone];
         //[formatter setDateFormat:self.cureFormate];
        NSString *dateString = [BasicConfiguration getDate:date formatter:BasiceDateHMS]; //[formatter stringFromDate: date];
        
        self.block(date,dateString,formatter);
    }
}
-(void)getDataFormateWithFormate:(NSString *)formate block:(clockBlock)block{
    self.cureFormate = formate;
    self.block = block;
    [self timeji];
}
-(void)dealloc{
    [self.timer invalidate];
}
-(CGFloat)currentTimeIntervale{
    
 
    return 86400.0;
    
}


@end
