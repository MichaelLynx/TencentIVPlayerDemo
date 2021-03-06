//
//  SELUpdateAlert.h
//  SelUpdateAlert
//
//  Created by zhuku on 2018/2/7.
//  Copyright © 2018年 selwyn. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SELUpdateAlert : UIView

/**
 添加版本更新提示
 
 @param version 版本号
 @param descriptions 版本更新内容（数组）
  默认强制更新
 descriptions 格式如 @[@"1.xxxxxx",@"2.xxxxxx"]
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Descriptions:(NSArray *)descriptions;

/**
 添加版本更新提示
 
 @param version 版本号
 @param description 版本更新内容（字符串）
 默认强制更新
 
 description 格式如 @"1.xxxxxx\n2.xxxxxx"
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description;
/**
 添加版本更新提示
 
 @param version 版本号
 @param description 版本更新内容（字符串）
  @param force 是否强制f更新  1 是  2 否
 description 格式如 @"1.xxxxxx\n2.xxxxxx"
 */
+ (void)showUpdateAlertWithVersion:(NSString *)version Description:(NSString *)description Force:(NSInteger)force;
@end
