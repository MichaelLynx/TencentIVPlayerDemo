//
//  UIImage+ChangeColor.h
//  TabDemo
//
//  Created by lynx on 13/10/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIImage (ChangeColor)

///Replace image color with new color.
-(UIImage*)imageWithColor:(UIColor*)color;
///Replace image color with new color and return a Original RenderingMode image.
- (UIImage *)originalImageWithColor:(UIColor *)color;
///Replace image color with new color and return a Original RenderingMode image.
+ (UIImage *)imageNamed:(NSString *)imageName newColor:(UIColor *)color;

///Reset image color with main color.
+ (UIImage *)MImageNamed:(NSString *)imageName;

@end

NS_ASSUME_NONNULL_END
