//
//  NSDictionary+Handle.h
//  TimeClock
//
//  Created by lynx on 19/10/2020.
//  Copyright © 2020 Lynx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDictionary (Handle)

///给网络请求的Params套外层样式。
- (NSDictionary *)MCustomize;

@end

NS_ASSUME_NONNULL_END
