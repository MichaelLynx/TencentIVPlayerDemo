# 简介

当终端用户完成注册、授权并注册SDK的accessId和accessToken，可通过App对设备进行可视对讲。

但是当设备点击对讲按钮发送对讲通知时，App端无法收到，此时需要注册消息通知(IVMessageMgr)的协议委托，以便接收对讲消息并执行对讲操作。当App端接收到设备的发送的对讲请求时，此时可以通过腾讯IoT的SDK的消息模块发送挂断或者接听消息给设备，设备则对应显示接听画面或关闭对讲请求页面。此时可由设备发起可视对讲，进行与设备的对讲。

腾讯可视对讲开发文档：[物联网智能视频服务](https://console.cloud.tencent.com/api/explorer?Product=iotvideo&Version=2019-11-26&Action=CreateAppUsr&SignVersion=)



# 可视对讲流程

## 一、接口请求

- 腾讯云后台的接口由后台经过一层封装后直接以接口的形式进行访问。
- 部分参数如SecretId、SecretKey在调用接口的时候不需要考虑，由后台配置，故在此不展示。
- 腾讯云后台接口：[腾讯云后台](https://console.cloud.tencent.com/api/explorer?Product=iotvideo&Version=2019-11-26&Action=CreateAppUsr&SignVersion=)



### 1.终端用户注册

用户需先完成注册，成为终端用户，才可进行可视对讲的下一步操作。

此接口需要传入用户的唯一标识进行注册，用户的唯一标识当前约定为登录成功后获取的用户id(userId)。

注册成功后获取该用户对应的AccessId。



### 2.终端用户接入授权

在用户完成注册后，就可开始接入授权的操作了。此时App已经可以实现可视对讲

此接口需要传入AccessId和UniqueId，其中AccessId由用户注册时获取，UniqueId用于区分同一个用户的多个终端，故使用App在iphone上的UUID。

授权成功后获取终端用户在该终端的AccessToken，该AccessToken和AccessId可用于注册腾讯IoT的SDK，并进行消息通知(IVMessageMgr)委托的设置。



### 3.终端用户绑定设备

用户完成授权之后可以进行设备的绑定，绑定设备之后可以接收到设备请求接听的消息。

此接口需要传入AccessId、Tid(即设备id)和Role，Role选择guest即可。

绑定成功后即可接收设备的消息通知，并对消息进行处理，如接听、挂断。



## 二、可视对讲

### 初始化可视对讲SDK

在AppDelegate文件的`didFinishLaunchingWithOptions`方法中执行：

~~~
[[IoTVideo sharedInstance] setupWithLaunchOptions:launchOptions];
[IoTVideo sharedInstance].delegate = self;
~~~



### 注册可视对讲SDK及通信

设置通信的代理并注册可视对讲SDK：

~~~
[IVMessageMgr sharedInstance].delegate = self;
[[IoTVideo sharedInstance] registerWithAccessId:accessId accessToken:accessToken];
~~~



### 创建播放器

~~~
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
~~~



### 执行播放操作

~~~
[self.intercomPlayer play];
[self.intercomPlayer startTalking];
[self.intercomPlayer openCamera];
~~~

