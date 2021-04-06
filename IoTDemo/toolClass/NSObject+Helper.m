//
//  NSObject+Helper.m
//  UUXueSheng
//
//  Created by apple on 2017/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSObject+Helper.h"
#import "NSString+Helper.h"
#import "YYKit.h"
//#import "LoginViewController.h"
@implementation NSObject(Helper)
-(NSString *)toString{
    
    if ([self isKindOfClass:[NSNumber class]] || [self isKindOfClass:[NSNull class]] || [self isKindOfClass:[NSString class]]) {
         return [[NSString stringWithFormat:@"%@",self] EmptyStringByWhitespace];
    }
    return @"";
}
+(UIViewController *)getCurrentViewController{
    return [self topViewController];
}
+(UIViewController *)topViewController {
    UIViewController *resultVC;
    resultVC = [self _topViewController:[[UIApplication sharedApplication].keyWindow rootViewController]];
    while (resultVC.presentedViewController ) {
        UIViewController *VC = [self _topViewController:resultVC.presentedViewController];
        if (VC.navigationController) {
            resultVC =VC;
        }else{
            break;
        }
    }
    return resultVC;
}

+ (UIViewController *)_topViewController:(UIViewController *)vc {
    if ([vc isKindOfClass:[UINavigationController class]]) {
        return [self _topViewController:[(UINavigationController *)vc topViewController]];
    } else if ([vc isKindOfClass:[UITabBarController class]]) {
        return [self _topViewController:[(UITabBarController *)vc selectedViewController]];
    } else {
        return vc;
    }
    return nil;
}
+(void)loginWithblock:(void(^)(id obj))block{
    @weakify(self);
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"温馨提示" message:@"您还没有登录，是否立即去登录？" preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction=[UIAlertAction actionWithTitle:@"去登陆" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        @strongify(self);
            [self jumpToLoginWithBlock:block];
    }];
    
    UIAlertAction *cancelAction=[UIAlertAction actionWithTitle:@"再看看" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:okAction];
    [alert addAction:cancelAction];
    [[NSObject getCurrentViewController] presentViewController:alert animated:YES completion:nil];
}
+(void)jumpToLoginWithBlock:(void(^)(id obj))block{
  //  LoginViewController *loginVC=[[LoginViewController alloc]initWithBlock:block];
 //   UINavigationController *naC=[[UINavigationController alloc]initWithRootViewController:loginVC];
  //  [[NSObject getCurrentViewController] presentViewController:naC animated:YES completion:nil];
}
@end
