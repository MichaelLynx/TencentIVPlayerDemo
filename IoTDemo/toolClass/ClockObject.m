//
//  ClockObject.m
//  Super
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "ClockObject.h"
#import "NSString+Helper.h"
#import <UIKit/UIKit.h>
#import "AnalyzeObject.h"
static ClockObject * _sharedInstance = nil;

@implementation ClockObject
+(ClockObject *)defaultClockObject{
    @synchronized ([ClockObject class]) {
        if (!_sharedInstance) {
            _sharedInstance=[[super alloc] init];
        }
        return _sharedInstance;
    }
        return nil;
}
-(void)setBeginTimeWithEndTimeIntercal:(NSTimeInterval)endTimeIntercal complete:(ClockBlock)block{
    _block=block;
    _endTimeIntercal=endTimeIntercal;
    [self startOneOffTimer];
}
-(void)setTimeIntercal:(NSTimeInterval)timeIntercal{
   
    _timeIntercal=timeIntercal;
    NSProcessInfo *info = [NSProcessInfo processInfo];
    _differtime = _timeIntercal-(NSInteger)info.systemUptime;
}
-(NSTimeInterval)timeIntercal{
       NSProcessInfo *info = [NSProcessInfo processInfo];
    NSTimeInterval system = _differtime+info.systemUptime;
    if (_differtime == 0) {
        system =[self getBeiJinTime];
    }
    return system;
}
-(NSTimeInterval)getBeiJinTime{
      //  NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        //----------格式,hh与HH的区别:分别表示12小时制,24小时制
      //  [formatter setDateFormat:@"yyyyMMddHHmmss"]; //yyyyMMddHHmmss  yyyymmddhhmmss
      //  formatter.timeZone = [NSTimeZone timeZoneWithName:@"Asia/Shanghai"];//东八区时间
       // NSDate *datenow = [NSDate date];
    return [[NSDate date] timeIntervalSince1970];
}


-(void)startOneOffTimer{
    nowDate=[NSDate dateWithTimeInterval:1 sinceDate:nowDate];
    _timeIntercal=[nowDate timeIntervalSince1970];

    NSDate *enddata=[NSDate dateWithTimeIntervalSince1970:_endTimeIntercal];
    NSInteger shijiancha= [enddata timeIntervalSinceDate:nowDate];
    NSString *result=  [NSString TimeformatFromSeconds:shijiancha];
    if (shijiancha<=0) {
        result=@"00:00:00";
    }
    if (_block) {
        _block(result);
    }
}
+(void)synchronousSystemTime{
//    [ [AnalyzeObject new] publicPostAnalyzeWithService:Kclassify_timestamp parameters:nil block:^(AnalyzeObject*obj,NSError*error) {
//        if ([obj.data objectForKey:@"timestamp"]) {
//            [[ClockObject defaultClockObject] setTimeIntercal:[[obj.data objectForKey:@"timestamp"] doubleValue]];
//        }
//    }];
    /*保存APP首次打开时间*/
    NSString *microtime =[[NSUserDefaults standardUserDefaults] objectForKey:@"KFristVisiteTime"];
    if (!microtime || [microtime isEmptyString])  {
        long long int  timeInterval=[ClockObject defaultClockObject].timeIntercal;
        NSString *microtime =[NSString stringWithFormat:@"%lld",timeInterval];
        [[NSUserDefaults standardUserDefaults] setObject:microtime forKey:@"KFristVisiteTime"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
   
}


+(void)saveLastVisiteTime{
    long long int  timeInterval=[ClockObject defaultClockObject].timeIntercal;
    NSString *microtime =[NSString stringWithFormat:@"%lld",timeInterval];
    [[NSUserDefaults standardUserDefaults] setObject:microtime forKey:@"KLastVisiteTime"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}
+(NSString *)getLastVisiteTime{
    NSString *microtime =[[NSUserDefaults standardUserDefaults] objectForKey:@"KLastVisiteTime"];
    if (!microtime || [microtime isEmptyString]) {
        microtime =[[NSUserDefaults standardUserDefaults] objectForKey:@"KFristVisiteTime"];
    }
    return microtime;
}
@end
