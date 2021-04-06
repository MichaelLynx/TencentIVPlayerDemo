//
//  BasicConfiguration.h
//  TimeClock
//
//  Created by Apple on 2019/12/14.
//  Copyright © 2019 Apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DefaultBlock.h"

typedef NS_OPTIONS(NSUInteger, BasiceDateFormate) {
    BasiceDateYMDHMS=0,//年月日时分格式化
    BasiceDateYMD ,//年月日
    BasiceDateHM,//时分
    
    BasiceDateWeekHM,//周，时分
    BasiceDateWeekYMD,//周，年月日
    BasiceDateWeekYMDHMS,//周，年月日
    
    BasiceDateMonthD,//月，日
    
    BasiceDateHMS,//时分秒
};


NS_ASSUME_NONNULL_BEGIN

@interface BasicConfiguration : NSObject
+ (BasicConfiguration*)sharedInstance;
//日期格式  yyyy-MM-dd  dd-MM-yyyy
@property(nonatomic,strong) NSString * dateFormate;
//时间格式 24小时制 12小时制
@property(nonatomic,strong) NSString * timeFormate;

///时间格式 0：24小时制，1：12小时制(AM/PM).
@property(nonatomic, assign)NSInteger dateFormateType;
///日期格式 0：yyy-MM-dd，1：dd-MM-yyyy
@property(nonatomic, assign)NSInteger timeFormateType;

///新增-hh:mm:ss a
@property(nonatomic, strong)NSString *timeDetailFormate;
///新增 dd-MM-yyyy hh:mm:ss a
@property(nonatomic, strong)NSString *dateDetailFormate;

///新增-hh:mm:ss
@property(nonatomic, strong)NSString *timeDetailUpFormate;
///新增-AM/PM
@property(nonatomic, strong)NSString *timeDetailDownFormate;

///新增，12小时制的时间
@property(nonatomic, strong)NSString *timeUpFormate;
///新增，12小时制的上下午，AM,PM
@property(nonatomic, strong)NSString *timeDownFormate;

@property(nonatomic,strong)NSString *dateAndTimeFormate;

//格式化时间
+(NSString *)getTimestamp:(NSString*)mStr formatterStr:(NSString *)formatterStr;

//格式化时间
+(NSString *)getTimestamp:(NSString*)mStr formatter:(BasiceDateFormate )formattertype;

//格式化时间
+(NSString *)getDate:(NSDate*)date formatter:(BasiceDateFormate )formattertype;

+(NSString *)getDateFormatterWithDate:(NSDate*)date formatterString:(NSString *)formatterString;

//格式化时间-服务器时间未转换，需要主动去转换时区。
+(NSString *)getOriginTimestamp:(NSString*)mStr formatterStr:(NSString *)formatterStr;

////服务器时间未转换，需要主动去转换时区。
+(NSString *)getDateFormatterWithOriginDate:(NSDate*)date formatterString:(NSString *)formatterString;
@end

@interface BasicClock : NSObject
//时钟定时器
@property(nonatomic,strong) NSTimer * timer;

//当日的23:59:59时间戳
@property(nonatomic,assign)CGFloat currentTimeIntervale;
//日期时间格式
@property(nonatomic,strong)NSString *cureFormate;

@property(nonatomic,strong)clockBlock block;
//格式化时间
-(void)getDataFormateWithFormate:(NSString *)formate block:(clockBlock)block;
@end

NS_ASSUME_NONNULL_END
