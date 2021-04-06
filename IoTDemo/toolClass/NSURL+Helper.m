//
//  NSURL+Helper.m
//  UUJiaoShi
//
//  Created by apple on 2017/3/29.
//  Copyright © 2017年 apple. All rights reserved.
//

#import "NSURL+Helper.h"
#import <objc/runtime.h>
#import "NSString+Helper.h"
@implementation NSURL (Helper)
+(void)load{
    //交换方法
    //获得系统的方法
  Method systemMeth = class_getClassMethod(self, @selector(URLWithString:));
    //获得自定义的方法
 Method selfMeth = class_getClassMethod(self, @selector(rm_URLWithString:));
    //交换方法
  method_exchangeImplementations(systemMeth, selfMeth);
    
  //  [NSURLRequest requestWithURL:<#(nonnull NSURL *)#>]
}
/**
 *URL 方法交换
 */
+(instancetype)rm_URLWithString:(NSString *)string{
    /**
     *处理string 判断是否包含http:
     *假如包含不做任何处理，不包含添加
     */
   NSString* exestr = [[string pathExtension] lowercaseString];
    if(exestr!=nil && ([exestr isEqualToString:@"png"] || [exestr isEqualToString:@"jpg"] || [exestr isEqualToString:@"jpeg"])){
        //本项目中把HTTPS图片强行转成http
      // NSLog(@"===============  %@",string);
     //string=[string stringByReplacingOccurrencesOfString:@"https://" withString:@"http://"];
       string = [string urlAutoAddHttp];
    }
   // NSLog(@"******************  %@",string);
    NSURL *url = [NSURL rm_URLWithString:string ];
    return url;
}
@end
