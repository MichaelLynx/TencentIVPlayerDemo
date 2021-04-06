//
//  NSData+AES256.m
//  EncryptDemo
//
//  Created by lynx on 28/9/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import "NSData+AES256.h"
#import "DefaultPageSource.h"

@implementation NSData (AES256)

- (NSData *)aes256_encrypt:(NSString *)key   //加密
{
    //char keyPtr[kCCKeySizeAES256+1];
    //bzero(keyPtr, sizeof(keyPtr));
    //[key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    
    NSData *keyData = [key dataUsingEncoding:NSUTF8StringEncoding];
    Byte *keyBytes = (Byte *)[keyData bytes];
    
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesEncrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCEncrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyBytes, kCCKeySizeAES256,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesEncrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesEncrypted];
    }
    free(buffer);
    return nil;
}
 
 
- (NSData *)aes256_decrypt:(NSString *)key   //解密
{
    char keyPtr[kCCKeySizeAES256+1];
    bzero(keyPtr, sizeof(keyPtr));
    [key getCString:keyPtr maxLength:sizeof(keyPtr) encoding:NSUTF8StringEncoding];
    NSUInteger dataLength = [self length];
    size_t bufferSize = dataLength + kCCBlockSizeAES128;
    void *buffer = malloc(bufferSize);
    size_t numBytesDecrypted = 0;
    CCCryptorStatus cryptStatus = CCCrypt(kCCDecrypt, kCCAlgorithmAES128,
                                          kCCOptionPKCS7Padding | kCCOptionECBMode,
                                          keyPtr, kCCBlockSizeAES128,
                                          NULL,
                                          [self bytes], dataLength,
                                          buffer, bufferSize,
                                          &numBytesDecrypted);
    if (cryptStatus == kCCSuccess) {
        return [NSData dataWithBytesNoCopy:buffer length:numBytesDecrypted];
 
    }
    free(buffer);
    return nil;
}

+ (NSString *) hybridizeForABWith:(NSDictionary *)params {
    NSString *key = [NSString stringWithFormat:@"%@%@",[[NSUserDefaults standardUserDefaults] valueForKey:KUserDefaultLog_Token], @"0592xmzkteco"];
    
    NSData *cData = [NSJSONSerialization dataWithJSONObject:params options:0 error:nil];
    NSData *aes256Data = [cData aes256_encrypt:key];
    NSString *base64St = [aes256Data base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return base64St;
}

@end
