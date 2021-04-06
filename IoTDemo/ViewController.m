//
//  ViewController.m
//  IoTDemo
//
//  Created by lynx on 2/12/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import "ViewController.h"
#import <IoTVideo/IoTVideo.h>

#import <Masonry.h>
#import <SVProgressHUD.h>

#import "AnalyzeObject.h"
#import "DefaultPageSource.h"

#import "MIOTRegisterModel.h"
//#import "MIOTTmpAuthModel.h"
#import "MTDeviceListModel.h"
#import "MTAuthModel.h"

#define DEVICE_ID @"031400005f39f7d8f7e3b18ff0bfc7ca"

#define USER_ACCOUNT @"15880283640"
#define USER_PASSWORD @"Zk123456"

/** 屏幕高度 */
#define SCREEN_WIDTH [UIScreen mainScreen].bounds.size.width
/** 屏幕高度 */
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height

@interface ViewController ()<IVPlayerDelegate, IVMessageDelegate>

@property(nonatomic, strong)IVLivePlayer *intercomPlayer;

@property(nonatomic, strong)UIView *mediaView;

@property(nonatomic, copy)NSString *accessId;
@property(nonatomic, copy)NSString *accessToken;


@property(nonatomic, strong)UIButton *answerBtn;
@property(nonatomic, strong)UIButton *hangOnBtn;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self doLogin];
    
//    [self setupTempPlay];
    
    [self setupSwitchBtn];
    
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    [self.intercomPlayer stop];
}

///临时测试
- (void)setupTempPlay {
    [IVMessageMgr sharedInstance].delegate = self;
    
    NSString *accessId = @"-9222942432750993158";
    NSString *accessToken = @"01019B8675F52B30775B7D15B9860100C02309B6B538F087B0B5F1F056B7E32E8462847C45D9BC5D98FBCFA00DB7B546107C5A1F7B55AA036A04896BFBE52625";
    
    [[IoTVideo sharedInstance] registerWithAccessId:accessId accessToken:accessToken];
    //[IVNetConfig subscribeDeviceWithToken:accessToken deviceId:DEVICE_ID];
    
    [self setupIVPlayer];
}

- (void)setupIVPlayer {
    self.intercomPlayer = [[IVLivePlayer alloc] initWithDeviceId:DEVICE_ID];
    self.intercomPlayer.delegate = self;
    
    self.mediaView = self.intercomPlayer.videoView;
    self.mediaView.frame = self.view.bounds;
    [self.view insertSubview:self.mediaView atIndex:0];
    
    UIView *preview = [UIView new];
    CGFloat width = 140;
    CGFloat height = 140 * 4 / 3;
    preview.frame = CGRectMake(SCREEN_WIDTH - width, 64, width, height);
    [self.view addSubview:preview];
    [preview.layer addSublayer:self.intercomPlayer.previewLayer];
    self.intercomPlayer.previewLayer.frame = preview.bounds;
    
    [self.intercomPlayer play];
    [self.intercomPlayer startTalking];
    [self.intercomPlayer openCamera];
}

- (void)setupSwitchBtn {
    self.answerBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.answerBtn setTitle:@"接听" forState:(UIControlStateNormal)];
    self.answerBtn.backgroundColor = [UIColor blackColor];
    self.answerBtn.tag = 1;
    [self.view addSubview:self.answerBtn];
    [self.answerBtn addTarget:self action:@selector(doSwitch:) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.hangOnBtn = [UIButton buttonWithType:(UIButtonTypeCustom)];
    [self.hangOnBtn setTitle:@"挂断" forState:(UIControlStateNormal)];
    self.hangOnBtn.backgroundColor = [UIColor blackColor];
    self.hangOnBtn.tag = 0;
    [self.view addSubview:self.hangOnBtn];
    [self.hangOnBtn addTarget:self action:@selector(doSwitch:) forControlEvents:(UIControlEventTouchUpInside)];
    
    [self.answerBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.mas_equalTo(50);
        make.height.mas_equalTo(30);
        make.bottom.equalTo(self.view).offset(-50);
        make.left.equalTo(self.view).offset(50);
    }];
    
    [self.hangOnBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.bottom.equalTo(self.answerBtn);
        make.right.equalTo(self.view).offset(-50);
    }];
}

- (void)doSwitch:(UIButton *)sender {
    NSString *action = sender.tag ? @"jieting": @"guaduan";
    
    [[IVMessageMgr sharedInstance] takeActionOfDevice:DEVICE_ID path:@"Action.handle_call" json:[@{@"stVal":action} jsonStringEncoded] completionHandler:^(NSString * _Nullable json, NSError * _Nullable error) {
        NSLog(@"json:%@, error:%@", json, error);
        if (sender.tag) {
            [SVProgressHUD showSuccessWithStatus:@"开始准备接听√"];
            
            [self setupIVPlayer];
        } else {
            self.answerBtn.backgroundColor = [UIColor blackColor];
            self.hangOnBtn.backgroundColor = [UIColor blackColor];
            
            [self resetPlayer];
            [self doIoTUserRegister];
        }
    }];
}

- (void)resetPlayer {
    [self.intercomPlayer stop];
    [self.intercomPlayer stopTalking];
    [self.intercomPlayer.videoView.superview removeAllSubviews];
    [self setupSwitchBtn];
}

#pragma mark - Request
//ZK账号登录
- (void)doLogin {
    NSString *pwd = [USER_PASSWORD md5String];
    [SVProgressHUD show];
    setBussinessUrl(@"http://192.168.218.43:7649");
    [[AnalyzeObject new] publicPostAnalyzeWithService:Klogin parameters:[@{@"payload":@{@"params":@{@"username":USER_ACCOUNT,@"password":pwd,@"type":@"openPwd"}}} jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
        [SVProgressHUD dismiss];
        
        if (obj.success) {
            [SVProgressHUD showSuccessWithStatus:@"Log In Successfully."];
            
            [[NSUserDefaults standardUserDefaults] setValue:obj.cmpId forKey:KUserDefaultCMP_ID];
            [[NSUserDefaults standardUserDefaults] setValue:obj.token forKey:KUserDefaultLog_Token];
            
            [[NSUserDefaults standardUserDefaults] setValue:obj.payload.results[@"userId"] forKey:KUserDefaultUSER_ID];
            NSString * zoneId = obj.payload.results[@"zoneId"];
            [[NSUserDefaults standardUserDefaults] setValue:zoneId forKey:KUserDefaultZoneID];
            [[NSUserDefaults standardUserDefaults] setValue:obj.payload.results[@"country"] forKey:KUserDefaultCuntryCode];
            
            [Stockpile sharedStockpile].password = pwd;
            [Stockpile saveData:obj.payload.results];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:kNotificationLogin object:nil];
            
            [self doIoTUserRegister];
        }else{
            [SVProgressHUD showErrorWithStatus:obj.message];
        }
    }];
}

//IoT用户注册
- (void)doIoTUserRegister {
    NSString *userId = [Stockpile sharedStockpile].userId ?: @"";
    NSDictionary *params = @{@"payload":@{@"params":@{@"userId":userId}}};
    
    [[AnalyzeObject new] publicPostAnalyzeWithService:kTCreateUser parameters:[params jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            MIOTRegisterVOModel *voModel = [MIOTRegisterVOModel modelWithJSON:obj.payload.results];
            MIOTRegisterModel *model = voModel.vo;
            NSLog(@"%@", model.accessId);
            [SVProgressHUD showSuccessWithStatus:@"用户注册成功"];
            
            [self doGetUserAuthorizationWithAccessId:model.accessId];
        } else {
            [SVProgressHUD showErrorWithStatus:obj.message];
        }
    }];
}

//获取用户授权，此处的token用于SDK配置
- (void)doGetUserAuthorizationWithAccessId:(NSString *)accessId {
    NSString *mac = [NSString getUUID];
    
    NSDictionary *params = @{@"payload":@{@"params":@{@"accessId":accessId, @"uniqueId": mac}}};
    [[AnalyzeObject new] publicPostAnalyzeWithService:kTCreateUsrToken parameters:[params jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            MTAuthVOModel *voModel = [MTAuthVOModel modelWithJSON:obj.payload.results];
            MTAuthModel *model = voModel.vo;
            NSLog(@"accesstoken:%@", model.accessToken);
            [SVProgressHUD showSuccessWithStatus:@"用户授权成功"];
            
            [IVMessageMgr sharedInstance].delegate = self;
            
            [[IoTVideo sharedInstance] registerWithAccessId:accessId accessToken:model.accessToken];
            //[IVNetConfig subscribeDeviceWithToken:model.accessToken deviceId:DEVICE_ID];
            
            [self doDealWithBindStatusWithAccessId:model.accessId];
        } else {
            [SVProgressHUD showErrorWithStatus:obj.message];
        }
    }];
}

//查询是否绑定设备，如果已绑定则执行绑定后的步骤，如果未绑定该设备则执行强制绑定操作
- (void)doDealWithBindStatusWithAccessId:(NSString *)accessId {
    //查询终端用户绑定的设备列表
    NSDictionary *params = @{@"payload":@{@"params":@{@"accessId":accessId}}};
    [[AnalyzeObject new] publicPostAnalyzeWithService:kTGetUserDeviceList parameters:[params jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            MTDeviceListVOModel *voModel = [MTDeviceListVOModel modelWithJSON:obj.payload.results];
            BOOL isBind = NO;
            for (MTDeviceListModel *model in voModel.vo.data) {
                if ([model.tid isEqualToString:DEVICE_ID]) {
                    isBind = YES;
                }
            }
            if (!isBind) {
                //还未绑定，先行绑定
                [self doBindDeviceWithAccessId:accessId];
            } else {
                [SVProgressHUD showSuccessWithStatus:@"可进行可视对讲服务√"];
            }
        } else {
            [self doDealWithBindStatusWithAccessId:accessId];
        }
    }];
}

//绑定设备
- (void)doBindDeviceWithAccessId:(NSString *)accessId {
    NSDictionary *params = @{@"payload":@{@"params":@{@"accessId":accessId, @"tid":DEVICE_ID, @"role":@"guest"}}};//owner/guest
    [[AnalyzeObject new] publicPostAnalyzeWithService:kTBind parameters:[params jsonStringEncoded] block:^(ResultObject *obj, NSError *error) {
        if (obj.success) {
            [SVProgressHUD showSuccessWithStatus:@"可进行可视对讲服务√"];
        } else {
            [SVProgressHUD showErrorWithStatus:obj.message];
        }
    }];
}

#pragma mark - IVPlayerDelegate

- (void)connection:(IVConnection *)connection didReceiveData:(NSData *)data {
    //该方法没走
    NSLog(@"didReceiveData:%@", data);
}

- (void)connection:(IVConnection *)connection didUpdateSpeed:(uint32_t)speed {
    NSLog(@"didUpdateSpeed:%.4f KB/s", speed / 1024.0);
}

- (void)connection:(IVConnection *)connection didReceiveError:(NSError *)error {
    NSLog(@"didReceiveError:%@", error);
}

-(void)connection:(IVConnection *)connection didUpdateStatus:(IVConnStatus)status {
    NSLog(@"didUpdateStatus:%ld", (long)status);
    if (status == IVConnStatusDisconnected) {
        NSLog(@"断开连接");
        //当断网时进行对应设置
        //[self.intercomPlayer disconnect];
        [self resetPlayer];
        [self doIoTUserRegister];
    }
}

#pragma mark - IVMessageDelegate

- (void)didReceiveEvent:(NSString *)event topic:(NSString *)topic {
    NSLog(@"事件通知\ntopic:%@\nevent:%@", topic, event);
    [SVProgressHUD showInfoWithStatus:event];
}

- (void)didUpdateProperty:(NSString *)json path:(NSString *)path deviceId:(NSString *)deviceId {
    NSLog(@"属性更新\ndeviceId:%@\npath:%@\njson:%@", deviceId, path, json);
    [SVProgressHUD showInfoWithStatus:json];
    
    NSData *data = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
    if (error) {
        NSString *reason = [NSString stringWithFormat:@"解析出错,error:%@", error];
        [SVProgressHUD showErrorWithStatus:reason];
    } else {
        NSString *value = dic[@"stVal"];
        if (value && [value isEqualToString:@"requesting"]) {
            self.answerBtn.backgroundColor = [UIColor greenColor];
            self.hangOnBtn.backgroundColor = [UIColor redColor];
        }
    }
}

@end
