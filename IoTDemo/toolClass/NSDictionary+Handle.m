//
//  NSDictionary+Handle.m
//  TimeClock
//
//  Created by lynx on 19/10/2020.
//  Copyright © 2020 Lynx. All rights reserved.
//

#import "NSDictionary+Handle.h"

@implementation NSDictionary (Handle)

- (NSDictionary *)MCustomize {
    NSDictionary *dic = @{@"payload":@{@"params":self}};
    return dic;
}

@end
