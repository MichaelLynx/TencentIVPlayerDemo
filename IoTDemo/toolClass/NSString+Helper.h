//
//  NSString+Helper.h
//  02.用户登录&注册
//
//  Created by 刘凡 on 13-11-28.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface NSString (Helper)
/**
 *将对象转成json
 */
+(NSString *)JsonStringForObject:(id)object;
/**
 *  秒转时间
 *
 *  @param seconds seconds description 秒
 *
 *  @return   返回格式  xx天xx:xx:xx  /   xx:xx:xx
 */
+(NSString*)TimeformatFromSeconds:(NSInteger)seconds;
#pragma mark - Get请求转换
/**
 *  将 nil 的字符串转 @""
 *
 *  @return 将 nil 的字符串转 @""
 */
-(NSString *)EmptyStringByWhitespace;
/**
 *  字符串转UTF-8
 *
 *  @return 字符串转UTF-8
 */
-(NSString *)getRequestString;
/**
 *  清空字符串中的空白字符
 *
 *  @return 清空空白字符串之后的字符串
 */
- (NSString *)trimString;

- (NSString *)trimParagraphString;
/**
 *
 *段前空两格
 */
-(NSString *)emptyBeforeParagraph;
/**
 *  是否空字符串
 *
 *  @return 如果字符串为nil或者长度为0返回YES
 */
- (BOOL)isEmptyString;

/**
 *  返回沙盒中的文件路径
 *
 *  @return 返回当前字符串对应在沙盒中的完整文件路径
 */
- (NSString *)documentsPath;

/**
 *  写入系统偏好
 *
 *  @param key 写入键值
 */
- (void)saveToNSDefaultsWithKey:(NSString *)key;
/**
 *    读出系统偏好
 *
 *  @param key 读出键值
 */
+ (NSString *)readToNSDefaultsWithKey:(NSString *)key;
/**
 *
 *判断是否是邮箱
 */
-(BOOL)isValidateEmail;
/**
 *
 *判断是否是手机号
 */
-(BOOL) isValidateMobile;
/**
 *
 *判断是否是手机号或固话
 */
-(BOOL) isValidateMobileAndTel;
- (BOOL)isValidUrl;
/**
 *
 *判断是否是手机号或固话或400
 */
-(BOOL) isValidateMobileAndTelAnd400;
/**
 *
 *银行账号判断
 */
-(BOOL)isValidateBank;
/**
 *
 *身份证号
 */
-(BOOL) isValidateIdentityCard;
/**
 *
 *判断是否是车牌号
 */
-(BOOL) isValidateCarNo;
/**
 *
 *车型号
 */
- (BOOL) isValidateCarType;
/**
 *
 *昵称
 */
- (BOOL) isValidateNickname;
/**
 *
 *密码（6~20位，数字，字母）
 */
-(BOOL) isValidatePassword;
#pragma mark - 支付密码
/**
 *
 *支付密码(6位，数字）
 */
-(BOOL)isPayPassword;
/**
 *
 *用户名
 */
- (BOOL) isValidateUserName;
/*
 *判断汉字
 *
 */
-(BOOL)isChinese;
/**
 *正整数
 */
-(BOOL)isNSInteger;

-(BOOL)isNumber;;
/**
 *正小数
 */
-(BOOL)isDouble;
/*
 *字符串转日期
 *
 */
- (NSDate *)dateFromString;
/*
 *日期转字符串
 *
 */
+ (NSString *)stringFromDate:(NSDate *)date;

+ (NSString *)getMonthBeginAndEndWith:(NSDate *)date;
+(NSString *)getLashMonthFromNow:(NSDate *)date;
+(NSString *)getNextMonthFromNow:(NSDate *)date;
-(NSString *)getNextWeekFromNow;

-(NSString *)getNextYearFromNow;
/**
 *  根据日期判断星期
 *
 */
+(NSString*)weekdayStringFromDate:(NSDate*)inputDate;

/**
 *手机号加密
 */
-(NSString *)EncodeTel;
/**
 *银行卡号加密
 *
 */
-(NSString *)EncodeBank;
/**
 * 身份证加密
 */
-(NSString *)EncodeIDCard;
/**
 * 名字
 */
-(NSString *)EncodeName;
/**
 *code 转 msg
 */
+(NSString *)GetMsgByCode:(NSString *)code;
/**
 *  处理json格式的字符串中的换行符、回车符
 */
- (NSString *)deleteSpecialCode;
/**
 *  拼接请求的网络地址
 */
-(NSString *)urlDictToStringWithDict:(NSDictionary *)parameters;
/**
 *  分离URL
 */
-(NSDictionary *)dictionaryWithUrl;

//-(NSString *)toString;
/**
 *格式化时间 从秒获得分秒
 */
+(NSString *)FormartScondTime:(NSNumber *)scond;
/**
 *通过原文件图片路径获得缩略图文件路径
 */
-(NSString *)getThumbImagePathFromImagePath;
/**
 *通过原文件缩略图路径获得原图文件路径
 */
-(NSString *)getImagePathFromThumbPath;
/**
 *URL判断URL链接是否包含http:
 */
-(NSString *)urlAutoAddHttp;
/**
 *小数数据的整数部分部分
 */
-(NSString *)getPointFont;
/**
 *小数数据的整数部分部分
 */
-(NSString *)getPointBack;
/**
 * 图文
 */
+(NSMutableAttributedString *)setImages:(NSArray *)arr withString:(NSString *)string font:(UIFont *)font;
+(NSMutableAttributedString *)setRightImages:(NSArray *)arr withString:(NSString *)string font:(UIFont *)font;
//返回16位大小写字母和数字
+(NSString *)return16LetterAndNumber;

/***
 *比较两个版本号的大小
 *@param oldVersion 第一个版本号
 *@param newVersion 第二个版本号
 *@return 版本号相等,返回0;
 *@return oldVersion小于newVersion,返回1;
 *@return 否则返回-1.
 */

+(NSInteger)compareVersion:(NSString *)oldVersion to:(NSString *)newVersion;

/**
 *  获取文本的显示高度,
 */
+(CGSize)heightForString:(NSString *)str Size:(CGSize)size Font:(UIFont *)font;

/**
 * 获取设备唯一标识
 */
+(NSString *)getUUID;
@end
