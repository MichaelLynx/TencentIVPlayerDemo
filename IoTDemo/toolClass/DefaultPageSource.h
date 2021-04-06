//
//  DefaultPageSource.h
//  AdultStore
//
//  Created by apple on 15/5/15.
//  Copyright (c) 2015年 apple. All rights reserved.
//


#import "UIImage+Helper.h"
#import "UIImageView+WebCache.h"

#import "UIImage+GIF.h"


//国际化语言包切换
#import "Localisator.h"

#import "NSString+Helper.h"
#import "NSObject+Helper.h"
#import "RACEXTScope.h"
#import "YYKit.h"
#import <Masonry/Masonry.h>

#import "NSDate+LTExtension.h"

//基础包
#import "BasicConfiguration.h"

#import "UIViewAdditions.h"
#import "UIButton+Helper.h"
#import "LSHControl.h"
//数字提醒
#import "UIView+DKSBadge.h"
#import "UITabBarItem+DKSBadge.h"
#import "UITabBar+DKSTabBar.h"
#import "UITextField+RYNumberKeyboard.h"



#ifndef DefaultPageSource

//日期格式 yyyy-MM-dd  dd-MM-yyyy
static NSString* const  MDDateFormateKey  = @"MDDateFormateKey";
//时间格式 12小时制 24小时制
static NSString*  const MDTimeFormateKey  = @"MDTimeFormateKey";

//ReshToken时间
static NSString *const KLaseReshTokenTime = @"KLaseReshTokenTime";

//定位时间
static NSString *const KLaseUploadLocationTime = @"KLaseUploadLocationTime";

//token
static NSString * const KUserDefaultLog_Token = @"KUserDefaultLog_Token";
static NSString * const KUserDefaultCMP_ID = @"KUserDefaultCMP_ID";

//author jolly.wu userId
static NSString * const KUserDefaultUSER_ID = @"KUserDefaultUSER_ID";
static NSString * const KUserDefaultZoneID = @"KUserDefaultZoneID";
static NSString * const KUserDefaultCuntryCode = @"KUserDefaultCuntryCode";

//--->
//当前角色
static NSString * const KUserDefaultRole = @"KUserDefaultRole";
static NSString * const KUserDefaultRoleMenu = @"KUserDefaultRoleMenu";

//通知
//用于关注刷新界面
static NSString * const kNotificationReshTokenAction = @"kNotificationReshTokenAction";
//用于关注刷新界面
static NSString * const kNotificationFocusAction = @"kNotificationFocusAction";
//用于收藏刷新界面状态
static NSString * const kNotificationCollectionAction = @"kNotificationCollectionAction";
//用于点赞刷新界面状态
static NSString * const kNotificationPraiseAction = @"kNotificationPraiseAction";
//用于秒杀刷新界面状态
static NSString * const kNotificationBuyAction = @"kNotificationBuyAction";

//登录
static NSString * const kNotificationLogin = @"kNotificationLogin";

static NSString * const kNotificationReshLogin = @"kNotificationReshLogin";

//退出
static NSString * const kNotificationLogout = @"kNotificationLogout";


//切换语言
static NSString * const kNotificationChangeLanguage = @"kNotificationChangeLanguage";

//切换角色
static NSString * const kNotificationChangeRole = @"kNotificationChangeRole";

//日期格式
static NSString * const kNotificationChangeDateFormate = @"kNotificationChangeDateFormate";
//时间格式
static NSString * const kNotificationChangeTimeFormate = @"kNotificationChangeTimeFormate";
//用于Requests 刷新列表
static NSString * const kNotificationPunchRequests = @"kNotificationPunchRequests";

//用于Approval 刷新列表
static NSString * const kNotificationApprovalRequests = @"kNotificationApprovalRequests";

//测试服务   _Dev

static void setBussinessUrl(NSString * url){
    [[NSUserDefaults standardUserDefaults] setObject:url forKey:@"kBussinessUrl"];
}

#define YuMing  [[NSUserDefaults standardUserDefaults] objectForKey:@"kBussinessUrl"]

//@"http://saas-app.zkbiocloud.com/"


//灰度包
//#define YuMing  @"https://pre.api.zkbiocloud.com/"

#define ImgDuanKou        [NSString stringWithFormat:@"%@",YuMing]




#pragma mark - 下线通知
#define orderLineKey  @"orderLine"
#define NoNet    @"NoNetKey"

//沙盒宏定义
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject]

//公共参数文件名字
#define kPublicSystemParamFileName  ([kDocumentPath stringByAppendingPathComponent:@"sysParam.key"])
#define kADImageParamFileName  ([kDocumentPath stringByAppendingPathComponent:@"ADImage.key"])
#define kCityFileName  ([kDocumentPath stringByAppendingPathComponent:@"city.key"])
#define kuserInfoFileName  ([kDocumentPath stringByAppendingPathComponent:@"Stockpile_userInfo.key"])
//APP版本号
#define kAppVersion ([[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"])

//判断是否是 RTL布局
#define isRTL ([UIView appearance].semanticContentAttribute == UISemanticContentAttributeForceRightToLeft)


//图片资源包
#define BUNDLE_NAME @ "RYNumbeKeyboard.bundle"
#define BUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: BUNDLE_NAME]
#define BUNDLE [NSBundle bundleWithPath: BUNDLE_PATH]
// 图片路径
#define ImgSourceName(file) [BUNDLE_PATH stringByAppendingPathComponent:file]
//获取图片
#define UIImageName(name)  [UIImage imageNamed:ImgSourceName(name)];


#define oblongPlaceholderImage ([UIImage imageNamed:@"icon"])
#define squarePlaceholderImage ([UIImage imageNamed:@"icon"])


#define UIColorFromHex(s)  [UIColor colorWithRed:(((s & 0xFF0000) >> 16))/255.0 green:(((s &0xFF00) >>8))/255.0 blue:((s &0xFF))/255.0 alpha:1.0]

#ifdef DEBUG
#define RM_Log(...) NSLog(__VA_ARGS__)
#else
#define RM_Log(...)
#endif

//界面布局配置

/**界面间距*/
#define RM_Padding 10

/**状态栏高度*/
#define RM_StateHeight (iPhoneX?44:20)

/**底部菜单高度*/
#define RM_TabBarHeigth 49
/**默认高度高度*/
#define RM_CellHeigth 44
#define RM_Lenth8    8
#define RM_Lenth6    6
/**数据分页*/
#define RM_FenYe  10

#pragma mark - 界面宏定义
#define iPhone6 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(750, 1334), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone6Plus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242, 2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define iPhoneX ([[UIApplication sharedApplication] statusBarFrame].size.height>20?YES:NO)

#define iPhone4S ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(320, 480), [[UIScreen mainScreen] bounds].size) : NO)

#define RM_Scale (([[UIScreen mainScreen] bounds].size.width == 320)?0.85:([[UIScreen mainScreen] bounds].size.width >= 414)?1.10:1.0)

/**导航栏高度*/
#define RM_NavHeigth  (iPhoneX?88:64)

#define RM_StatusHeigth  ([[UIApplication sharedApplication] statusBarFrame].size.height)


#define HEIGHT_BOTTOM_MARGIN   (iPhoneX?34:0)

#define WinWidth ([[UIScreen mainScreen] bounds].size.width)
#define WinHeight ([[UIScreen mainScreen] bounds].size.height)

#define AutoSize(__size) (__size*RM_Scale)

/*
 * 界面颜色设置，基本不用修改
 */


/**黑色线颜色*/
//#define blackLineColore UIColorFromHex(0xA8ADB7)
#define blackLineColore UIColorFromHex(0xE3E5E8)
//#define blackLineColore  [UIColorFromHex(0xA8ADB7) colorWithAlphaComponent:0.15]

#define videoTagColor   UIColorFromHex(0xC9AE68)

//UIColorFromHex(0xE6EAF2)
/**白色*/
#define whiteLineColore [UIColor whiteColor]
/**界面背景颜色*/
#define superBackgroundColor UIColorFromHex(0xf8f8f8)
//UIColorFromHex(0xF5F7FA)
/**底部TabBar背景颜色*/
#define tabBarBackgroundColor UIColorFromHex(0xffffff)
/**灰色字体颜色*/
#define lightGrayTextColor UIColorFromHex(0x999999)
/**灰色字体颜色*/
#define heightgrayTextColor UIColorFromHex(0x333333)
#define grayTextColor UIColorFromHex(0x666666)
#define grayTextColor44 UIColorFromHex(0x444444)

#define grayViewColor UIColorFromHex(0xBFC2C7)

/**黑色字体颜色*/
#define blackTextColor UIColorFromHex(0x000000)
/**透明色*/
#define emptyColor ([UIColor clearColor])

/**
 * 渐变色
 */
#define firstColor UIColorFromHex(0xFA0000)
#define lastColor UIColorFromHex(0xFF6936)

/*项目颜色
 *这些颜色需根据不同的项目要求进行调整
 *没有用到的颜色配置可以忽略不动
 */

#define grayBtnBgColor UIColorFromHex(0xb1b5bb)
#define  lightGrayBtnBgColor [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:1]
#define heightGrayBtnBgColor [UIColor colorWithRed:92/255.0 green:92/255.0 blue:92/255.0 alpha:1]


/**项目主题颜色*/
#define mainColor UIColorFromHex(0x7AC143)//[UIColor colorWithRed:255/255.0 green:0/255.0 blue:48/255.0 alpha:1]

#define darkMainColor UIColorFromHex(0x50462A)

#define codeBtnBGColor UIColorFromHex(0x574c2d)
/**项目配色颜色*/
#define firstMatchColor  UIColorFromHex(0xFF6969)
/**项目配色颜色*/
#define secondMatchColor [UIColor colorWithRed:254/255.0 green:206/255.0 blue:0/255.0 alpha:1]

/**粉色字体颜色*/
#define pinkTextColor [UIColor colorWithRed:229/255.0 green:0/255.0 blue:45/255.0 alpha:1]
/**红色字体颜色*/
#define redTextColor [UIColor redColor]
/**绿色字体颜色*/
#define greenTextColor [UIColor colorWithRed:38/255.0 green:180/255.0 blue:63/255.0 alpha:1]
/**橘色字体颜色*/
#define orangeTextColor [UIColor colorWithRed:255/255.0 green:90/255.0 blue:36/255.0 alpha:1]
/**蓝色字体颜色*/
#define blueTextColor  [UIColor colorWithRed:63/255.0 green:147/255.0 blue:223/255.0 alpha:1]
//UIColorFromHex(0x1A87F6)


CG_INLINE UIFont*
__AutoSize(CGFloat size,BOOL isBold){
    if (iPhone6 || iPhoneX) {
        if (isBold) {
             return [UIFont fontWithName:@"Helvetica-Bold" size:size];
        }
        if (size<12) {
            return [UIFont fontWithName:@"STHeitiTC-Light" size:size];
        }
        return [UIFont systemFontOfSize:size];
    }
    if (iPhone6Plus) {
        if (isBold) {
            return [UIFont fontWithName:@"Helvetica-Bold" size:size+1.0];
        }
        if (size<12) {
            return [UIFont fontWithName:@"STHeitiTC-Light" size:size+1.0];
        }
        return [UIFont systemFontOfSize:size+1.0];
    }
    if (isBold) {
        return [UIFont fontWithName:@"Helvetica-Bold" size:size-0.5];
    }
    if (size<12) {
        return [UIFont fontWithName:@"STHeitiTC-Light" size:size-0.5];
    }
    return [UIFont systemFontOfSize:size-0.5];
}
#define AutoFontSize __AutoSize

CG_INLINE UIFont*
__SolidFontSize(CGFloat size,BOOL isBold){

    if (isBold) {
        return [UIFont fontWithName:@"Helvetica-Bold" size:size];
    }
    if (size<12) {
        return [UIFont fontWithName:@"STHeitiTC-Light" size:size];
    }
    return [UIFont systemFontOfSize:size];
}
#define SolidFontSize __SolidFontSize





CG_INLINE UIFont*
__AutoStyeSize(CGFloat size,NSInteger style){
//    if (iPhone6 || iPhoneX) {
//        if (style==1) {
//            return [UIFont fontWithName:@"Helvetica-Bold" size:size];
//        }
//        if (style==-1) {
//            return [UIFont fontWithName:@"STHeitiTC-Light" size:size];
//        }
//        return [UIFont systemFontOfSize:size*RM_Scale];
//    }
//    if (iPhone6Plus) {
//        if (style==1) {
//            return [UIFont fontWithName:@"Helvetica-Bold" size:size+1.0];
//        }
//        if (style==-1) {
//            return [UIFont fontWithName:@"STHeitiTC-Light" size:size+1.0];
//        }
//        return [UIFont systemFontOfSize:size*RM_Scale];
//    }
    CGFloat s = RM_Scale;
//    if (s<1) {
//        s = 0.875;
//    }else if (s>1){
//        s = 1.08;
//    }
//
    if (style==1) {
        return [UIFont fontWithName:@"Helvetica-Bold" size:size*s];
    }else
    if (style==-1) {
        return [UIFont fontWithName:@"STHeitiTC-Light" size:size*s];
    }else if (style == 2){
        //italic
        return [UIFont fontWithName:@"Arial-ItalicMT" size:size*s];
    }
    return [UIFont systemFontOfSize:size*s];
}
#define AutoFontSize __AutoSize

CG_INLINE UIFont*
__SolidStyeFontSize(CGFloat size,NSInteger style){
    
    if (style==1) {
        return [UIFont fontWithName:@"Helvetica-Bold" size:size];
    }
    if (style==-1) {
        return [UIFont fontWithName:@"STHeitiTC-Light" size:size];
    }
    return [UIFont systemFontOfSize:size];
}

#define SolidFontSize __SolidFontSize

//项目字体配置
#define AutoBoldFontSize(__size)  (__AutoStyeSize(__size,1))
#define SolidBoldFontSize(__size)  (__SolidStyeFontSize(__size,1))

#define AutoNormalFontSize(__size)  (__AutoStyeSize(__size,0))
#define AutoItalicFontSize(__size)  (__AutoStyeSize(__size,2))
#define SolidNormalFontSize(__size)  (__SolidStyeFontSize(__size,0))

#define AutoLightFontSize(__size)  (__AutoStyeSize(__size,-1))
#define SolidLightFontSize(__size)  (__SolidStyeFontSize(__size,-1))

//项目的字体配置
//导航字体为17号加粗
#define Big17BoldFont(__scale) (__scale>1? __AutoSize(17,YES):__SolidFontSize(17,YES))
//导航字体为16号加粗
#define Big16BoldFont(__scale) (__scale>1? __AutoSize(16,YES):__SolidFontSize(16,YES));
//默认字体颜色为13号
#define DefaultFont(__scale) (__scale>1? __AutoSize(13,NO):__SolidFontSize(13,NO));
//默认次级字体为12号
#define SmallFont(__scale) (__scale>1? __AutoSize(12,NO):__SolidFontSize(12,NO));
//默认大按钮按钮的字体为15号
#define Big15Font(__scale) __scale>1? __AutoSize(15,NO):__SolidFontSize(15,NO);
//默认滑动按钮的字体为14号
#define Big14Font(__scale) __scale>1? __AutoSize(14,NO):__SolidFontSize(14,NO);
//默认灰色小字11号
#define Small11Font(__scale) __scale>1? __AutoSize(11,NO):__SolidFontSize(11,NO);
#define Small10Font(__scale) __scale>1? __AutoSize(10,NO):__SolidFontSize(10,NO);

#define Small8Font(__scale) __scale>1? __AutoSize(8,NO):__SolidFontSize(8,NO);

#define BoldSmallFont(__scale) __scale>1? __AutoSize(12,YES):__SolidFontSize(12,YES);
#define BoldSmall11Font(__scale) __scale>1? __AutoSize(11,YES):__SolidFontSize(11,YES);
#define Bold14Font(__scale) __scale>1? __AutoSize(14,YES):__SolidFontSize(14,YES);
#define Big16Font(__scale) __scale>1? __AutoSize(16,NO):__SolidFontSize(16,NO);
#define Big17Font(__scale) __scale>1? __AutoSize(17,NO):__SolidFontSize(17,NO);
#define SBigFont(__scale) __scale>1? __AutoSize(18,NO):__SolidFontSize(18,NO);

#pragma mark -  旋转角度
//#define DegreesToRadians(x) ((x) * M_PI / -180.0)

//项目中文字长度限制

/** 姓名长度*/
#define RM_NameLength 15
/** 身份证号长度*/
#define RM_IDCardLength 18
/** 银行卡号长度*/
#define RM_BankLength 24
/** 手机号码长度*/
#define RM_TelLength 11
/** 密码长度*/
#define RM_PwdLength 16
/** 验证码长度*/
#define RM_CodeLength 6
/** 支付密码长度*/
#define RM_PayPwdLength 6
/** 邮编长度*/
#define RM_PostCodeLength 6
/** 标题长度*/
#define RM_TitleLength 20
/** 留言、意见反馈长度*/
#define RM_LeaveMessageLength 255
/** 评论长度*/
#define RM_CommentLength 140
/** 地址长度*/
#define RM_AddressLength 40
/** 圈圈长度*/
#define RM_QuanQuanLength 1000
/**
 *  买家留言
 */
#define RM_MarkLength 50

#pragma mark - DES加密

CG_INLINE NSString*
__GetSystemDateStr(){
    NSDate *date=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyyMMdd"];
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;

}
//#define AutoFontSize __AutoSize

#define DESKey   __GetSystemDateStr()
#define DESIV      @"SJYSCAPP"


#define jitashuo_siteKey  @""
#define jitashuo_appsecret  @""
#define FM_salt  @"hEi9qBDaMHtxOgY7"

#define SafeWindowHeight (iPhoneX ? [[UIScreen mainScreen] bounds].size.height-34 : [[UIScreen mainScreen] bounds].size.height)
#endif

//环境列表
#define KeyEnvRoute @"EnvRoute"

#define DevGlobalRouteURL @"http://dev.global.api.zkbiocloud.com" //开发环境
#define TestGlobalRouteURL @"http://192.168.218.44:8843"//@"http://test.global.api.zkbiocloud.com"//测试环境
#define PreGlobalRouteURL @"https://global.api.zkbiocloud.com"//

//全局路由，正式地址
#define PublishGloablRouteURL @"https://global.api.zkbiocloud.com"

//默认是开发环境的
extern NSString * GlobalRouteWebURL;

//ON_DEV 开启为1，表示开发环境，此时在登录页面长按 logo会弹框出来，这样用户就可以选择 环境
#define ON_DEV  1
//ENABLE_LOG 开启为1, 则app的所有日志会自动导出到biocloud.log文件里面
#define ENABLE_LOG  1

