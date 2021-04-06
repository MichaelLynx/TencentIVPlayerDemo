//
//  MIOTRegisterModel.h
//  IoTDemo
//
//  Created by lynx on 8/12/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MIOTRegisterModel : NSObject

@property(nonatomic, copy)NSString *cunionId;
@property(nonatomic, copy)NSString *accessId;
@property(nonatomic, copy)NSString *requestId;
@property(nonatomic, assign)BOOL newRegist;

@end

@interface MIOTRegisterVOModel : NSObject

@property(nonatomic, strong)MIOTRegisterModel *vo;

@end

NS_ASSUME_NONNULL_END
