//
//  UIColor+Gradient.h
//  TimeClock
//
//  Created by lynx on 2020/5/14.
//  Copyright © 2020 Lynx. All rights reserved.
//

//设置渐变
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (Gradient)

///绘制渐变色颜色的方法
+ (CAGradientLayer *)setGradualChangingColor:(UIView *)view fromColor:(NSString *)fromHexColorStr toColor:(NSString *)toHexColorStr;
///获取16进制颜色的方法
+ (UIColor *)colorWithHex:(NSString *)hexColor;

@end

NS_ASSUME_NONNULL_END
