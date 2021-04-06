//
//  MBProgressHUD+Add.m
//
//  Created by mj on 13-4-18.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MBProgressHUD+Add.h"

@implementation MBProgressHUD (Add)

+ (void)show:(NSString *)text icon:(NSString *)icon view:(UIView *)view
{
    if (view == nil) view = [UIApplication sharedApplication].delegate.window;
   
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = text;
    hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"%@", icon]]];
    hud.mode = MBProgressHUDModeCustomView;
    
    hud.removeFromSuperViewOnHide = YES;
    
    [hud hide:YES afterDelay:0.7];
}

+ (void)showError:(NSString *)error toView:(UIView *)view{
    [self show:error icon:@"shibai" view:view];
}

+ (void)showSuccess:(NSString *)success toView:(UIView *)view
{
    [self show:success icon:@"ico_hd_120" view:view];
}

+ (MBProgressHUD *)showMessag:(NSString *)message toView:(UIView *)view {
    if (view == nil) view = [UIApplication sharedApplication].delegate.window;
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    hud.labelText = message;
   // hud.mode = MBProgressHUDModeText;
    hud.removeFromSuperViewOnHide = YES;
   hud.dimBackground = YES;
   // [hud hide:YES afterDelay:0.7];
    return hud;
}
+(void)showMessage:(NSString *)message{
    /*
    if (message == nil || message.length<1) {
        return;
    }
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.mode = MBProgressHUDModeText;
    hud.tintColor=[UIColor whiteColor];
    hud.detailsLabelText = message;
    hud.removeFromSuperViewOnHide = NO;
    [hud hide:NO afterDelay:1.3];
    */
    //替换为iOS安卓统一样式
    if (!message || message.length == 0) {
        message = @" ";
    }
    
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    NSArray * array = [[UIApplication sharedApplication] windows];
    if (array.count >= 2) {
        window = [array lastObject];
    }
    
    UIView *hudBoard = [UIView new];
    hudBoard.layer.cornerRadius = 4.5;
    hudBoard.layer.shadowOffset = CGSizeMake(0, 0);
    hudBoard.layer.shadowOpacity = 1;
    hudBoard.layer.shadowColor = [RGB(0, 0, 0) colorWithAlphaComponent:0.18].CGColor;
    
    hudBoard.backgroundColor = [UIColor whiteColor];
    [window addSubview:hudBoard];
    
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"tips_yellow"]];
    [hudBoard addSubview:icon];
    
    UILabel *hudLb = [UILabel new];
    hudLb.font = [UIFont systemFontOfSize:13];
    hudLb.textColor = DEFAULTSECTIONTITLECOLOR;
    hudLb.numberOfLines = 0;
    [hudLb sizeToFit];
    hudLb.text = message;
    [hudBoard addSubview:hudLb];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hudBoard removeFromSuperview];
    });
    
    double width = WIDTH_SCREEN - (29 * 2 + 36.5 + 12.5) - 5;
    double height = [MSizeHelper getHeightWithString:message fontSize:13 maxWidth:width] + 1;
    double curWidth = [MSizeHelper getWidthWithString:message fontSize:13 maxHeight:height] + 1;
    if (curWidth > width) {
        curWidth = width;
    }
    
    [hudBoard mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(window).offset(-66);
        //make.left.equalTo(window).offset(29);
        //make.right.equalTo(window).offset(-29);
        make.centerX.equalTo(window);
    }];
    
    [icon mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(15);
        make.left.equalTo(hudBoard).offset(10.5);
        make.top.equalTo(hudBoard).offset(10.5);
    }];
    
    [hudLb mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(icon.mas_right).offset(10.5);
        make.top.equalTo(hudBoard).offset(11);
        make.right.equalTo(hudBoard).offset(-12);
        make.height.mas_equalTo(height);
        make.width.mas_equalTo(curWidth);
        make.bottom.equalTo(hudBoard).offset(-10);
    }];
}
+(MBProgressHUD *)startAnimate{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:[UIApplication sharedApplication].delegate.window animated:YES];
    hud.mode = MBProgressHUDModeIndeterminate;
    hud.tintColor=[UIColor whiteColor];
    hud.labelText= @"加载中...";
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}
-(void)stopAnimate{
    [self hide:YES];
}
@end
