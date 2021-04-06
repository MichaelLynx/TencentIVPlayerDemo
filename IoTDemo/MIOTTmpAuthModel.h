//
//  MIOTTmpAuthModel.h
//  IoTDemo
//
//  Created by lynx on 9/12/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import <Foundation/Foundation.h>
//获取临时授权，已不使用。当前使用MTAuthModel
NS_ASSUME_NONNULL_BEGIN

@interface MIOTTmpAuthModel : NSObject

///客户的终端用户在IoT Video上的唯一标识ID
@property(nonatomic, copy)NSString *accessId;
@property(nonatomic, copy)NSString *tid;
@property(nonatomic, copy)NSString *accessToken;
@property(nonatomic, copy)NSString *expireTime;

@end

@interface MIOTTmpAuthHolderModel : NSObject

@property(nonatomic, strong)NSArray *data;
@property(nonatomic, copy)NSString *requestId;

@end

@interface MIOTTmpAuthVOModel : NSObject

@property(nonatomic, strong)MIOTTmpAuthHolderModel *vo;

@end

NS_ASSUME_NONNULL_END
