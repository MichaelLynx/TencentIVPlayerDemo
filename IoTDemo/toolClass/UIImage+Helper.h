//
//  UIImage+Helper.h
//  TuLing
//
//  Created by apple on 15-2-3.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage(Helper)
/*
 *颜色这转为图片
 */
+(UIImage *)ImageForColor:(UIColor *)color;
/*
 *模糊图片
 */
+(UIImage *)blurryImage:(UIImage *)image
           withBlurLevel:(CGFloat)blur;
/* blur the current image with a box blur algoritm */
- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur;

/* blur the current image with a box blur algoritm and tint with a color */
- (UIImage*)drn_boxblurImageWithBlur:(CGFloat)blur withTintColor:(UIColor*)tintColor;

+(UIImage *)setImgNameBianShen:(NSString *)Img;

/* 图片大小 */
- (UIImage *)imageByScalingToSize:(CGSize)targetSize;
/*
 *获取图片某个点的RGBA值
 */
+(NSMutableArray *)getImagePixel:(UIImage *)image point:(CGPoint)apoint;
/**
 *j截屏方法
 */
+(UIImage *)imageFromView: (UIView *) theView;

/**
 *j截屏方法
 */
+(UIImage *)imageFromView: (UIView *) theView withTopSex:(CGFloat)setY;
/**
 *生成二维码
 */
+(UIImage *)creatQRImageWithContent:(NSString *)content withSize:(CGFloat)size;


+ (UIImage *)createShareImage:(UIImage *)tImage ContextImage:(UIImage *)image2;

/**
 *生成二维码
 */
+(UIImage *)creatQRImageWithContent:(NSString *)content logo:(UIImage *)logo withSize:(CGFloat)size;
/**
 *获得视频第一帧图片
 */
+ (UIImage*) getVideoPreViewImageWithPathUrl:(NSURL *)videoPath;
/**
 * 图片透明度
 */
+ (UIImage *)imageByApplyingAlpha:(CGFloat)alpha  image:(UIImage*)image;
-(UIColor*)mostColor;

//图片翻转
+ (UIImage *)image:(UIImage *)image rotation:(UIImageOrientation)orientation;
// Creates a version of this image that, when assigned to a UIImageView’s image property, draws its underlying image contents horizontally mirrored when running under a right-to-left language. Affects the flipsForRightToLeftLayoutDirection property; does not affect the imageOrientation property.
- (UIImage *)hts_imageFlippedForRightToLeftLayoutDirection;
@end
//@interface UIImage(SVGManager)
//+ (UIImage *)svgImageNamed:(NSString *)name;
////svg图片
//+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size;
////svg图片及颜色
//+ (UIImage *)svgImageNamed:(NSString *)name size:(CGSize)size tintColor:(UIColor *)tintColor;
//
//@end
