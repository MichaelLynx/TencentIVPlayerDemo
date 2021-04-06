//
//  GKNavigationBar.h
//  GKNavigationBarViewController
//
//  Created by QuintGao on 2017/9/20.
//  Copyright © 2017年 高坤. All rights reserved.
//  自定义的导航条

#import <UIKit/UIKit.h>

@interface GKNavigationBar : UINavigationBar

// 当前控制器
@property (nonatomic, assign) BOOL      gk_statusBarHidden;

/** 导航栏背景色透明度，默认是1.0 */
@property (nonatomic, assign) CGFloat   gk_navBarBackgroundAlpha;

@property (nonatomic, assign) BOOL      gk_navLineHidden;

// 左边item间距
@property (nonatomic, assign) CGFloat   gk_navItemLeftSpace;
// 右边item间距
@property (nonatomic, assign) CGFloat   gk_navItemRightSpace;

- (void)gk_navLineHideOrShow;
/** 导航栏背景透明 导航底部按钮事件是否开启  默认NO */
@property (nonatomic, assign) BOOL      gk_navBarBackAction;
@end
