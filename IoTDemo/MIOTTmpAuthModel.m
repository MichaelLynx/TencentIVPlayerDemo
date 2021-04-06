//
//  MIOTTmpAuthModel.m
//  IoTDemo
//
//  Created by lynx on 9/12/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import "MIOTTmpAuthModel.h"

@implementation MIOTTmpAuthModel

@end

@implementation MIOTTmpAuthHolderModel

+ (NSDictionary *)modelContainerPropertyGenericClass{
    return @{
             @"data" : [MIOTTmpAuthModel class]
             };
}

@end

@implementation MIOTTmpAuthVOModel

@end
