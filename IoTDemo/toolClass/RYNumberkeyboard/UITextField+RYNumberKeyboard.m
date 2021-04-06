//
//  UITextField+RYNumberKeyboard.m
//  RYNumberKeyboardDemo
//
//  Created by Resory on 16/2/21.
//  Copyright © 2016年 Resory. All rights reserved.
//

#import "UITextField+RYNumberKeyboard.h"
#import <objc/runtime.h>
#import "NSString+Helper.h"
#import "ReactiveCocoa.h"
//手机号长度
#define KPhoneNumLength 11
//身份证号最大长度
#define KIDLength 18
//银行卡号最大长度
#define KBankcardNumLength 28
//手机号334格式空格处光标所处位置长度分别为3，8
#define KPhoneNumFirstPoint 3
#define KPhoneNumSecondPoint 8
//身份证号684格式空格处光标所处位置分别为6，15
#define KIDNumFirstPoint 6
#define KIDNumSecondPoint 15
//银行卡证号684格式空格处光标所处位置分别为4，9，14，19，24
#define KBankcardNumFirstPoint 4
#define KBankcardNumSecondPoint 9
#define KBankcardNumThirdPoint 14
#define KBankcardNumFourthPoint 19
#define KBankcardNumFifthPoint 24
static const void *kmaxlen = "maxlen";
static const void *v_placeholderColor = "placeholderColor";
@interface UITextField()
@property(nonatomic,copy) NSString *maxlen;
@end

@implementation UITextField (RYNumberKeyboard)
-(void)setMaxlen:(NSString *)maxlen{
    objc_setAssociatedObject(self, kmaxlen, maxlen, OBJC_ASSOCIATION_COPY_NONATOMIC);
}
-(NSString *)maxlen{
    return objc_getAssociatedObject(self, kmaxlen);
}
#pragma mark -
#pragma mark -  Setter

- (void)setRy_inputType:(RYInputType)ry_inputType
{
    RYNumberKeyboard *inputView = [[RYNumberKeyboard alloc] initWithInputType:ry_inputType];
    self.inputView = inputView;
    objc_setAssociatedObject(self, _cmd, @(ry_inputType), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRy_interval:(NSInteger)ry_interval
{
    if([self.inputView isKindOfClass:[RYNumberKeyboard class]])
        [self.inputView performSelector:@selector(setInterval:) withObject:@(ry_interval)];
    objc_setAssociatedObject(self, _cmd, @(ry_interval), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (void)setRy_inputAccessoryText:(NSString *)ry_inputAccessoryText
{
    
    NSLog(@"********** %@",ry_inputAccessoryText);
    // inputAccessoryView
    UIView *tView = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 35)];
    // 顶部分割线
    UIView *tLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 0.5f)];
    tLine.backgroundColor = [UIColor colorWithRed:210/255.0 green:210/255.0 blue:210/255.0 alpha:1.0];
    // 字体label
    UILabel *tLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, SYS_DEVICE_WIDTH, 35)];
    tLabel.text = ry_inputAccessoryText;
    tLabel.textAlignment = NSTextAlignmentCenter;
    tLabel.font = [UIFont systemFontOfSize:14.0];
    tLabel.backgroundColor = [UIColor whiteColor];
    
    [tView addSubview:tLabel];
    [tView addSubview:tLine];
    self.inputAccessoryView = tView;
    objc_setAssociatedObject(self, _cmd, ry_inputAccessoryText, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

#pragma mark -
#pragma mark -  Getter

- (void)setPlaceholderColor:(UIColor *)placeholderColor {
     objc_setAssociatedObject(self, v_placeholderColor, placeholderColor, OBJC_ASSOCIATION_COPY_NONATOMIC);
    if (self.placeholder && placeholderColor) {
        NSMutableAttributedString *attrString = [[NSMutableAttributedString alloc]initWithString:self.placeholder attributes:@{NSForegroundColorAttributeName:placeholderColor}];
        self.attributedPlaceholder = attrString;
    }
}
-(UIColor *)placeholderColor{
   return objc_getAssociatedObject(self, v_placeholderColor);
}

- (RYInputType)ry_inputType
{
    return [objc_getAssociatedObject(self, @selector(setRy_inputType:)) integerValue];
}

- (NSInteger)ry_interval
{
    return [objc_getAssociatedObject(self, @selector(setRy_interval:)) integerValue];
}

- (NSString *)ry_inputAccessoryText
{
    return objc_getAssociatedObject(self, @selector(ry_inputAccessoryText));
}
#pragma mark -- 字数限制
-(void)setMaxLength:(NSInteger)maxlength{
    
    
    self.maxlen=[NSString stringWithFormat:@"%@",@(maxlength)];
    [self addTarget:self action:@selector(TextFieldChange:) forControlEvents:UIControlEventEditingChanged];
    
}

//过滤表情
+ (NSString *)filterEmoji:(NSString *)string {
    __block BOOL returnValue = NO;
    
    __block NSString *toString=@"";
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                                if (!returnValue && (stop)) {
                                    toString = [toString stringByAppendingString:substring];
                                }
                            
                            }];
    return toString;
}

//3.通过判断用户输入的字符串时候含有表情来进行对应的操作

//是否含有表情
+ (BOOL)stringContainsEmoji:(NSString *)string
{
    __block BOOL returnValue = NO;
    
    [string enumerateSubstringsInRange:NSMakeRange(0, [string length])
                               options:NSStringEnumerationByComposedCharacterSequences
                            usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
                                const unichar hs = [substring characterAtIndex:0];
                                if (0xd800 <= hs && hs <= 0xdbff) {
                                    if (substring.length > 1) {
                                        const unichar ls = [substring characterAtIndex:1];
                                        const int uc = ((hs - 0xd800) * 0x400) + (ls - 0xdc00) + 0x10000;
                                        if (0x1d000 <= uc && uc <= 0x1f77f) {
                                            returnValue = YES;
                                        }
                                    }
                                } else if (substring.length > 1) {
                                    const unichar ls = [substring characterAtIndex:1];
                                    if (ls == 0x20e3) {
                                        returnValue = YES;
                                    }
                                } else {
                                    if (0x2100 <= hs && hs <= 0x27ff) {
                                        returnValue = YES;
                                    } else if (0x2B05 <= hs && hs <= 0x2b07) {
                                        returnValue = YES;
                                    } else if (0x2934 <= hs && hs <= 0x2935) {
                                        returnValue = YES;
                                    } else if (0x3297 <= hs && hs <= 0x3299) {
                                        returnValue = YES;
                                    } else if (hs == 0xa9 || hs == 0xae || hs == 0x303d || hs == 0x3030 || hs == 0x2b55 || hs == 0x2b1c || hs == 0x2b1b || hs == 0x2b50) {
                                        returnValue = YES;
                                    }
                                }
                            }];
    
    return returnValue;
}




-(void)TextFieldChange:(UITextField *)obj{
    UITextField *NameText=(UITextField *)obj;
    NSInteger _maxlength=[self.maxlen integerValue];
    
    NSString *toBeString = NameText.text;
    NSString *toString=@"";
    if (self.ry_interval>0) {
        toString=toBeString;
        toBeString = [toBeString trimString];
        
    }
   

    
    
    
    
//    if ([[[UITextInputMode currentInputMode ]primaryLanguage] isEqualToString:@"emoji"]) {
//        return NO;
//    }
//
    
    
    
    NSString *lang = [[UIApplication sharedApplication]textInputMode].primaryLanguage; // 键盘输入模式
    

   
    if (lang== nil || [UITextField stringContainsEmoji:toBeString] || [lang isEqualToString:@"emoji"] ) {
        
        NameText.text = [UITextField filterEmoji:toBeString];
        
        return;
    }else{
        
    }
    
    
    
    if ([lang isEqualToString:@"zh-Hans"]) { // 简体中文输入，包括简体拼音，健体五笔，简体手写
        UITextRange *selectedRange = [NameText markedTextRange];
        //获取高亮部分
        UITextPosition *position = [NameText positionFromPosition:selectedRange.start offset:0];
        // 没有高亮选择的字，则对已输入的文字进行字数统计和限制
        if (!position) {
            if (toBeString.length > _maxlength) {
                NameText.text = [toBeString substringToIndex:_maxlength];
            }
        }
        else{
            
        }
    }
    else{
        if (toBeString.length > _maxlength) {
            
            if (self.ry_interval > 0) {
                NSInteger i = _maxlength/self.ry_interval; //记录空格的数量
                if (_maxlength%self.ry_interval == 0) {
                    i--;
                }
                NameText.text = [toString substringToIndex:(_maxlength + i)];
            }
            else
            {
                NameText.text = [toBeString substringToIndex:_maxlength];
            }

        }
    }
}
+(BOOL) textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string controllDecimalLenth:(NSInteger)lenth pointBehindLenth:(NSInteger)poinLenth{
    BOOL _isHasPoint = NO;
    if ([textField.text rangeOfString:@"."].location != NSNotFound) {
        _isHasPoint = YES;
    }
    if ([string length] > 0) {
        
        unichar single = [string characterAtIndex:0];//当前输入的字符
        if (poinLenth<1) {
            if (single == '.') {
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
                return NO;
            }
        }
        
        
        if ((single >= '0' && single <= '9') || single == '.') {//数据格式正确
            
            //首字母不能为0和小数点
            if([textField.text length] == 0){
                if(single == '.') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    textField.text=@"0";
                    return YES;
                }
                if (single == '0') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return YES;
                }
            }else if ([textField.text length]==1 && [textField.text integerValue]==0){
                if (single=='0') {
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }else if (single != '.'){
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    textField.text=@"";
                    return YES;
                }
            }
            //输入的字符是否是小数点
            if (single == '.') {
                if(!_isHasPoint)//text中还没有小数点
                {
                    _isHasPoint = YES;
                    return YES;
                }else{
                    [textField.text stringByReplacingCharactersInRange:range withString:@""];
                    return NO;
                }
            }else{
                if (_isHasPoint) {//存在小数点
                    NSRange ran = [textField.text rangeOfString:@"."];
                    //判断小数点的位数
                    //NSRange ran = [textField.text rangeOfString:@"."];
                    if ((range.location - ran.location <= poinLenth) && ran.location<lenth) {
                        
                        return YES;
                    }else{
                        if(range.location - ran.location <= poinLenth){
                            return YES;
                        }
                        return NO;
                    }
                }else{
                    if (range.location<lenth) {
                        return YES;
                    }
                    return NO;
                }
            }
        }else{//输入的数据格式不正确
            [textField.text stringByReplacingCharactersInRange:range withString:@""];
            return NO;
        }
    }
    else
    {
        return YES;
    }
    
}
-(NSString *)emptyAlertString{
    if (self.keyboardType == UIKeyboardTypePhonePad) {
        if ([[self.text trimString] isEmptyString]) {
                return self.placeholder;
        }
        if (![[self.text trimString] isValidateMobile]) {
            return @"手机号格式不正确，请输入正确的手机号";
        }
    }
    if (self.secureTextEntry) {
        if ([[self.text trimString] isEmptyString]) {
            return self.placeholder;
        }
        if (![[self.text trimString] isValidatePassword]) {
            return @"请输入6~20位，数字，字母或数字字母组合";
        }
    }
    if ([[self.text trimString] isEmptyString]) {
        return self.placeholder;
    }
    return nil;
}

-(BOOL)shouldChangeTextInRange:(UITextRange *)range replacementText:(NSString *)text{
    
    return NO;
}
/**
 *  输入号码格式化
 *  参数 textField UITextField控件
 *  参数 range 文本范围
 *  参数 string 字符串
 *  参数 type 文本框输入号码类型（身份证，手机号，银行卡）
 */
+ (BOOL)numberFormatTextField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string textFieldType:(kTextFieldType)type
{
    NSLog(@"%@",NSStringFromRange(range));
    if (textField) {
        NSString *text = textField.text;
        //删除
        if([string isEqualToString:@""]){
            
            //删除一位
            if(range.length == 1){
                //最后一位,遇到空格则多删除一次
                if (range.location == text.length-1 ) {
                    //                    if ([text characterAtIndex:text.length-1] == ' ') {
                    //                        [textField deleteBackward];
                    //                    }
                    
                    return YES;
                }
                //从中间删除
                else{
                    NSInteger offset = range.location;
                    
                    if (range.location < text.length && [text characterAtIndex:range.location] == ' ' && [textField.selectedTextRange isEmpty]) {
                        [textField deleteBackward];
                        
                        offset --;
                    }
                    
                    [textField deleteBackward];
                    
                    textField.text = [self insertString:textField.text withTextFieldType:type];
                  //  UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                    
                   // textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                    return NO;
                }
            }
            else if (range.length > 1) {
                BOOL isLast = NO;
                //如果是从最后一位开始删除
                if(range.location + range.length == textField.text.length ){
                    isLast = YES;
                }
                [textField deleteBackward];
                textField.text = [self insertString:textField.text withTextFieldType:type];
                
                NSInteger offset = range.location;
                
                [self shouldChangeCharactersInRange:range textFieldType:type locationOffset:offset];
                
                if (isLast) {
                    //光标直接在最后一位了
                }else{
                   // UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
                   // textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
                }
                
                return NO;
            }
            
            else{
                return YES;
            }
        }else if(string.length >0){
            
            
            if (type == kIDCardNoTextFieldType) {
                //限制输入字符个数
                
                
                
                if (([self whiteSpaseString:textField.text].length + string.length - range.length > KIDLength) ) {
                    return NO;
                }
                
            }else if (type == kPhoneNumberTextFieldType){
                
                //限制输入字符个数
                if (([self whiteSpaseString:textField.text].length + string.length - range.length > KPhoneNumLength) ) {
                    return NO;
                }
                
            }else{
                
                //限制输入字符个数
                if (([self whiteSpaseString:textField.text].length + string.length - range.length > KBankcardNumLength) ) {
                    return NO;
                }
                
            }
            
            [textField insertText:string];
            textField.text = [self insertString:textField.text withTextFieldType:type];
            //设置光标偏移量
            NSInteger offset = range.location + string.length;
            [self shouldChangeCharactersInRange:range textFieldType:type locationOffset:offset];
            
            if (type == kIDCardNoTextFieldType) {
                if (range.location == KIDNumFirstPoint || range.location  == KIDNumSecondPoint) {
                    offset ++;
                }
            }else if (type == kPhoneNumberTextFieldType){
                if (range.location == KPhoneNumFirstPoint || range.location  == KPhoneNumSecondPoint) {
                    offset ++;
                }
                
            }else{
                
                if (range.location == KBankcardNumFirstPoint || range.location  == KBankcardNumSecondPoint || range.location == KBankcardNumThirdPoint || range.location  == KBankcardNumFourthPoint || range.location == KBankcardNumFifthPoint) {
                    offset ++;
                }
                
            }
            //UITextPosition *newPos = [textField positionFromPosition:textField.beginningOfDocument offset:offset];
           // textField.selectedTextRange = [textField textRangeFromPosition:newPos toPosition:newPos];
            return NO;
        }else{
            return YES;
        }
        
    }
    
    return YES;
    
}

//输入相应位数后面增加空格
+(NSString*)insertString:(NSString*)string withTextFieldType:(kTextFieldType)type
{
    if (!string) {
        return nil;
    }
    NSMutableString* tStr = [NSMutableString stringWithString:[string stringByReplacingOccurrencesOfString:@" " withString:@""]];
    if (type == kIDCardNoTextFieldType) {
        //身份证号
        if (tStr.length >KIDNumFirstPoint) {
            [tStr insertString:@" " atIndex:KIDNumFirstPoint];
        }if (tStr.length > KIDNumSecondPoint) {
            [tStr insertString:@" " atIndex:KIDNumSecondPoint];
            
        }
    }else if (type == kPhoneNumberTextFieldType){
        
        //手机号
        if (tStr.length >KPhoneNumFirstPoint) {
            [tStr insertString:@" " atIndex:KPhoneNumFirstPoint];
        }if (tStr.length > KPhoneNumSecondPoint) {
            [tStr insertString:@" " atIndex:KPhoneNumSecondPoint];
            
        }
        
    }else{
        
        //银行卡号
        if (tStr.length >KBankcardNumFirstPoint) {
            [tStr insertString:@" " atIndex:KBankcardNumFirstPoint];
        }if (tStr.length > KBankcardNumSecondPoint) {
            [tStr insertString:@" " atIndex:KBankcardNumSecondPoint];
            
        } if (tStr.length >KBankcardNumThirdPoint) {
            [tStr insertString:@" " atIndex:KBankcardNumThirdPoint];
        }if (tStr.length > KBankcardNumFourthPoint) {
            [tStr insertString:@" " atIndex:KBankcardNumFourthPoint];
            
        }if (tStr.length >KBankcardNumFifthPoint) {
            [tStr insertString:@" " atIndex:KBankcardNumFifthPoint];
        }
        
    }
    
    return  tStr;
}

//设置光标位置
+(void)shouldChangeCharactersInRange:(NSRange)range  textFieldType:(kTextFieldType)type locationOffset:(NSInteger)offset{
    
    if (type == kIDCardNoTextFieldType) {
        if (range.location == KIDNumFirstPoint || range.location  == KIDNumSecondPoint) {
            offset ++;
        }
    }else if (type == kPhoneNumberTextFieldType){
        if (range.location == KPhoneNumFirstPoint || range.location  == KPhoneNumSecondPoint) {
            offset ++;
        }
        
    }else{
        
        if (range.location == KBankcardNumFirstPoint || range.location  == KBankcardNumSecondPoint || range.location == KBankcardNumThirdPoint || range.location  == KBankcardNumFourthPoint || range.location  == KBankcardNumFifthPoint) {
            offset ++;
        }
        
    }
}
//去除空格
+(NSString*)whiteSpaseString:(NSString*)string
{
    return [string stringByReplacingOccurrencesOfString:@" " withString:@""];
}


@end
