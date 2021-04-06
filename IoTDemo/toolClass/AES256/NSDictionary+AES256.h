//
//  NSDictionary+AES256.h
//  TimeClock
//
//  Created by lynx on 16/10/2020.
//  Copyright © 2020 Lynx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (AES256)

///对字典进行加密处理返回加密后的字典。
- (NSDictionary *) hybridizeForAB;

///对字典进行加密处理返回加密并套壳后的字典。
- (NSDictionary *) dHybridizeForAB;

@end

NS_ASSUME_NONNULL_END
