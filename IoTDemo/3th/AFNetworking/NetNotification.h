//
//  NetNotification.h
//  BaoJiaHuHang2
//
//  Created by apple on 2016/12/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void(^NetworkBlock)(NSInteger isCan);
@interface NetNotification : NSObject
//类方法
+ (instancetype)shareNetNotification;
@property(nonatomic,readonly,assign)BOOL isCan;
-(void)isCanConnectenToNetworkComplation:(NetworkBlock) block;
@end
