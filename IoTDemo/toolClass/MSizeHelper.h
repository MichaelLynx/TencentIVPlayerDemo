//
//  ICESSizeHelper.h
//  ICES-MergeBE
//
//  Created by Faven on 2017/2/15.
//  Copyright © 2017年 FoxWay. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface MSizeHelper : NSObject

+ (CGFloat)getWidthWithString:(NSString *)string
                     fontSize:(CGFloat)size
                    maxHeight:(CGFloat)height;

+ (CGFloat)getHeightWithString:(NSString *)string
                      fontSize:(CGFloat)size
                      maxWidth:(CGFloat)width;

+ (CGFloat)getSpaceLabelHeight:(NSString *)str
                          font:(UIFont *)font
                  lineSpaceing:(CGFloat)lineSpacing
                      maxWidth:(CGFloat)width;
@end
