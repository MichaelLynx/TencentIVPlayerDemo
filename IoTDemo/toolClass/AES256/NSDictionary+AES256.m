//
//  NSDictionary+AES256.m
//  TimeClock
//
//  Created by lynx on 16/10/2020.
//  Copyright © 2020 Lynx. All rights reserved.
//

#import "NSDictionary+AES256.h"
#import "DefaultPageSource.h"
#import "NSData+AES256.h"

NSString *ENCRYPT_KEY = @"xmzkteco-department-biocloud";

@implementation NSDictionary (AES256)

///对字典进行加密处理返回加密后的字典。
- (NSDictionary *) hybridizeForAB {
    NSString *key = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] valueForKey:KUserDefaultLog_Token], ENCRYPT_KEY];
    
    NSData *cData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    NSData *aes256Data = [cData aes256_encrypt:key];
    NSString *base64St = [aes256Data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *dic = @{@"isEncrypt": @"1", @"data":base64St};
    return dic;
}

///对字典进行加密处理返回加密并套壳后的字典。
- (NSDictionary *) dHybridizeForAB {
    NSString *token = [[NSUserDefaults standardUserDefaults] valueForKey:KUserDefaultLog_Token] ?: @"";
    NSString *key = [NSString stringWithFormat:@"%@%@",token, ENCRYPT_KEY];
    
    NSData *cData = [NSJSONSerialization dataWithJSONObject:self options:0 error:nil];
    NSData *aes256Data = [cData aes256_encrypt:key];
    NSString *base64St = [aes256Data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    
    NSDictionary *dic = @{@"payload":@{@"params":@{@"isEncrypt": @"1", @"data":base64St}}};
    return dic;
}

@end
