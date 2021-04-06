//
//  UITextField+RYNumberKeyboard.h
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RYNumberKeyboard.h"
typedef enum {
    
    kIDCardNoTextFieldType, //身份证号
    kPhoneNumberTextFieldType, //手机号
    kBankCardNumberTextFieldType //银行卡号
    
}kTextFieldType;

@interface UITextField (RYNumberKeyboard)

@property (nonatomic, assign) RYInputType ry_inputType;     // 键盘类型
@property (nonatomic, assign) NSInteger ry_interval;
// 每隔多少个数字空一格
@property (nonatomic, strong) UIColor *placeholderColor;
@property (nonatomic, copy) NSString *ry_inputAccessoryText;  // inputAccessoryView显示的文字
-(void)setMaxLength:(NSInteger)maxlength;

+(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string controllDecimalLenth:(NSInteger)lenth pointBehindLenth:(NSInteger)poinLenth;
/**
 *  输入号码格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 *  参数 type 文本框输入号码类型（身份证，手机号，银行卡）
 */

+ (BOOL)numberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string textFieldType:(kTextFieldType)type;
-(NSString *)emptyAlertString;
@end


