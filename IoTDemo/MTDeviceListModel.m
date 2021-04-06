//
//  MTDeviceListModel.m
//  IoTDemo
//
//  Created by lynx on 10/12/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import "MTDeviceListModel.h"

@implementation MTDeviceListModel

@end

@implementation MTDeviceListHolderModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"data" : [MTDeviceListModel class]
             };
}

@end

@implementation MTDeviceListVOModel

@end
