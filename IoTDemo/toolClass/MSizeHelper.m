//
//  ICESSizeHelper.m
//  ICES-MergeBE
//
//  Created by Faven on 2017/2/15.
//  Copyright © 2017年 FoxWay. All rights reserved.
//

#import "MSizeHelper.h"
#define IOS_VERSION ([[UIDevice currentDevice].systemVersion floatValue])

@implementation MSizeHelper

+ (CGFloat)getWidthWithString:(NSString *)string
                     fontSize:(CGFloat)size
                    maxHeight:(CGFloat)height {
    UIFont * font = [UIFont systemFontOfSize:size];
    CGSize tempSize = [string boundingRectWithSize:CGSizeMake(MAXFLOAT, height)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{
                                                     NSFontAttributeName : font
                                                     }
                                           context:nil].size;
    //        size.width += 5;
    return tempSize.width;
}

+ (CGFloat)getHeightWithString:(NSString *)string
                      fontSize:(CGFloat)size
                      maxWidth:(CGFloat)width {
    UIFont * font = [UIFont systemFontOfSize:size];
    CGSize tempSize = [string boundingRectWithSize:CGSizeMake(width, MAXFLOAT)
                                           options:NSStringDrawingUsesLineFragmentOrigin
                                        attributes:@{
                                                     NSFontAttributeName : font
                                                     }
                                           context:nil].size;
    return tempSize.height;
}

//计算带有行间距的文字高度
+ (CGFloat)getSpaceLabelHeight:(NSString *)str font:(UIFont *)font lineSpaceing:(CGFloat)lineSpacing maxWidth:(CGFloat)width {
    NSMutableParagraphStyle *paraStyle = [[NSMutableParagraphStyle alloc] init];
    paraStyle.lineBreakMode = NSLineBreakByCharWrapping;
    paraStyle.alignment = NSTextAlignmentLeft;
    paraStyle.lineSpacing = lineSpacing;
    paraStyle.hyphenationFactor = 1.0;
    paraStyle.firstLineHeadIndent = 0.0;
    paraStyle.paragraphSpacingBefore = 0.0;
    paraStyle.headIndent = 0;
    paraStyle.tailIndent = 0;
    NSDictionary *dic = @{NSFontAttributeName:font,
                          NSParagraphStyleAttributeName:paraStyle,
                          NSKernAttributeName:@1.5f};
    
    CGSize size = [str boundingRectWithSize:CGSizeMake(width, HEIGHT_SCREEN)
                                    options:NSStringDrawingUsesLineFragmentOrigin
                                 attributes:dic
                                    context:nil].size;
    return size.height;
}

@end
