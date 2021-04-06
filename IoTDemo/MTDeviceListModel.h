//
//  MTDeviceListModel.h
//  IoTDemo
//
//  Created by lynx on 10/12/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface MTDeviceListModel : NSObject

@property(nonatomic, copy)NSString *tid;
@property(nonatomic, copy)NSString *deviceName;
@property(nonatomic, copy)NSString *deviceModel;
@property(nonatomic, copy)NSString *role;

@end

@interface MTDeviceListHolderModel : NSObject

@property(nonatomic, strong)NSArray *data;
@property(nonatomic, copy)NSString *requestId;

@end

@interface MTDeviceListVOModel : NSObject

@property(nonatomic, strong)MTDeviceListHolderModel *vo;

@end

NS_ASSUME_NONNULL_END
