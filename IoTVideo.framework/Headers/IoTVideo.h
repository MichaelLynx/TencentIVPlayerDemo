//
//  IoTVideo.h
//  IoTVideo
//
//  Created by JonorZhang on 2019/11/13.
//  Copyright © 2019 Tencentcs. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IVConstant.h"
#import "IVMacros.h"
#import "IVLog.h"
#import "IVError.h"
#import "IVUtils.h"

#import "IVLivePlayer.h"
#import "IVMonitorPlayer.h"
#import "IVPlaybackPlayer.h"
#import "IVTransmission.h"

#import "IVMessageMgr.h"
#import "IVDeviceMgr.h"

#import "IVQRCodeHelper.h"
#import "IVLanNetConfig.h"
#import "IVQRCodeNetConfig.h"
#import "IVNetConfig.h"

#import "IVReachability.h"
#import "IVNetworkHelper.h"
#import "IVNetworkSign.h"
#import "IVNetwork_p2p.h"


/* ⚠️Automatically generated by script, do not manually edit! */
#define kIoTVideoVersion "1.3(1ab6) Release"
#define kIoTVideoCompileDate "2020-11-05 14:26:40"


NS_ASSUME_NONNULL_BEGIN

@protocol IoTVideoDelegate <NSObject>

/// SDK与服务器的连接状态变更
/// @param linkStatus SDK与服务器的连接状态
- (void)didUpdateLinkStatus:(IVLinkStatus)linkStatus;

/// 日志输出回调
/// @param message  日志信息
/// @param level  日志级别, 详见IVLogLevel
/// @param file  文件名
/// @param func  函数名
/// @param line  行号
- (void)didOutputLogMessage:(NSString *)message level:(IVLogLevel)level file:(NSString *)file func:(NSString *)func line:(int)line;

@end


@interface IoTVideo : NSObject

/// 单例
+ (instancetype)sharedInstance;
/// 单例
@property (class, nonatomic, strong, readonly) IoTVideo *sharedInstance;

/// 事件代理
@property (nonatomic, weak, nullable) id<IoTVideoDelegate> delegate;
/// 访问Token
@property (nonatomic, strong, nullable, readonly) NSString *accessToken;
/// 用户ID（外部访问IotVideo云平台的唯一性身份标识）
@property (nonatomic, strong, nullable, readonly) NSString *accessId;
/// 终端ID
@property (nonatomic, strong, nullable, readonly) NSString *terminalId;
/// SDK与服务器的连接状态
@property (nonatomic, assign, readonly) IVLinkStatus linkStatus;
/// 日志级别，默认DEBUG
/// @note 日志内容通过代理回调 @c `-[IoTVideoDelegate didOutputLogMessage:level:file:func:line:]`
@property (nonatomic, assign) IVLogLevel logLevel;
/// 可选配置选项
@property (nonatomic, strong) NSDictionary<IVOptionKey, id> *options;
/// SDK版本
@property (class, nonatomic, strong, readonly) NSString *SDKVersion;

/// SDK初始化配置一些参数, 需要在`application:didFinishLaunchingWithOptions:`中调用
/// @param launchOptions 传入application:didFinishLaunchingWithOptions: 得到的launchOptions
- (void)setupWithLaunchOptions:(nullable NSDictionary *)launchOptions;

/// 注册登陆信息，建议在登录成功(获取到accessId、accessToken)后调用
/// @param accessId 注册成功后返回的用户ID，是外部访问IotVideo云平台的唯一性身份标识
/// @param accessToken 登录成功服务器返回的`accessToken`
- (void)registerWithAccessId:(NSString *)accessId accessToken:(NSString *)accessToken;

/// 刷新accessToken
/// @param accessToken 登录成功服务器返回的`accessToken`
- (void)updateToken:(NSString *)accessToken;

/// SDK反注册，退出登录时调用
- (void)unregister;

@end


@interface IoTVideo (Test)

/// 内部测试代码，开发者请勿调用
+ (void)test:(int)a b:(id)b c:(id)c d:(int)d e:(id)e f:(int)f;

@end

NS_ASSUME_NONNULL_END
