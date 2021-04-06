//
//  NSObject+Helper.h
//  UUXueSheng
//
//  Created by apple on 2017/3/10.
//  Copyright © 2017年 apple. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSObject(Helper)
-(NSString *)toString;
+(UIViewController *)getCurrentViewController;
+(void)loginWithblock:(void(^)(id obj))block;
+(void)jumpToLoginWithBlock:(void(^)(id obj))block;
@end
