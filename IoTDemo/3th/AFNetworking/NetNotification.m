//
//  NetNotification.m
//  BaoJiaHuHang2
//
//  Created by apple on 2016/12/10.
//  Copyright © 2016年 apple. All rights reserved.
//

#import "NetNotification.h"
#import "AFNetworkReachabilityManager.h"
@interface NetNotification()
@property(nonatomic,strong)NetworkBlock block;
@end
@implementation NetNotification
//类方法
static BOOL canNet=YES;
+ (instancetype)shareNetNotification{                                                       
    static NetNotification *calculateFileSize =nil;
    @synchronized(self)  {
        if (!calculateFileSize) {
            calculateFileSize   =  [[self alloc]init];
         [calculateFileSize NetNotifivation];
        }
    }
    
    return calculateFileSize;
}
-(void)isCanConnectenToNetworkComplation:(NetworkBlock) block{
    _block=block;
    
}
//监听网络
-(void)NetNotifivation{
    AFNetworkReachabilityManager *manager1=[AFNetworkReachabilityManager sharedManager];
    [manager1 startMonitoring];
    
    [manager1 setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态发生改变的时候调用这个block
        NSInteger iscan=0;
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWiFi:// 局域网络,不花钱
                NSLog(@"WIFI");
                iscan++;
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN://2G,3G,4G 花钱
                iscan++;
                NSLog(@"自带网络");
                break;
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                iscan++;
                break;
            case AFNetworkReachabilityStatusNotReachable:// 无连接
                NSLog(@"没有网络");
                iscan++;
                break;
            default:
                break;
        }
        canNet=iscan;
        if (self.block) {
            self.block(iscan);
        }
    }];
}
-(BOOL)isCan{
    return canNet;
}
@end
