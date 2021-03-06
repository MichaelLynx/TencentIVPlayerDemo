//
//  ClockObject.h
//  Super
//
//  Created by apple on 16/5/12.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^ClockBlock)(id object);
@interface ClockObject : NSObject
{
    NSTimer * _timer ;
    NSTimeInterval  _timeIntercal ;
    NSTimeInterval  _endTimeIntercal ;
    NSTimeInterval _Timecha;
    NSDate *nowDate;
    ClockBlock  _block ;
    NSTimeInterval  _differtime ;
    
}
+(ClockObject *)defaultClockObject;
@property(nonatomic,assign)NSTimeInterval  timeIntercal;
-(void)setBeginTimeWithEndTimeIntercal:(NSTimeInterval)endTimeIntercal complete:(ClockBlock)block;
+(void)synchronousSystemTime;
+(void)saveLastVisiteTime;
+(NSString *)getLastVisiteTime;
@end
