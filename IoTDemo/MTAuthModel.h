//
//  MTAuthModel.h
//  IoTDemo
//
//  Created by lynx on 10/12/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTAuthModel : NSObject

@property(nonatomic, copy)NSString *accessToken;
@property(nonatomic, copy)NSString *accessId;
@property(nonatomic, copy)NSString *terminalId;
@property(nonatomic, copy)NSString *expireTime;
@property(nonatomic, copy)NSString *requestId;

@end

@interface MTAuthVOModel : NSObject

@property(nonatomic, strong)MTAuthModel *vo;

@end

NS_ASSUME_NONNULL_END
