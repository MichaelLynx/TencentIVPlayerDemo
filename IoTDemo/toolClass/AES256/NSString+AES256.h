//
//  NSString+AES256.h
//  EncryptDemo
//
//  Created by lynx on 28/9/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

#import "NSData+AES256.h"

NS_ASSUME_NONNULL_BEGIN

@interface NSString (AES256)

-(NSString *) aes256_encrypt:(NSString *)key;
-(NSString *) aes256_decrypt:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
