//
//  NSData+AES256.h
//  EncryptDemo
//
//  Created by lynx on 28/9/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>
#import <CommonCrypto/CommonCryptor.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSData (AES256)

-(NSData *) aes256_encrypt:(NSString *)key;
-(NSData *) aes256_decrypt:(NSString *)key;

+ (NSString *) hybridizeForABWith:(NSDictionary *)params;

@end

NS_ASSUME_NONNULL_END
