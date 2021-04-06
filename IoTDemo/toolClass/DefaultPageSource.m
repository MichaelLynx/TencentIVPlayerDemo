//
//  DefaultPageSource.cpp
//  TimeClock
//
//  Created by jolly on 3/18/20.
//  Copyright © 2020 Apple. All rights reserved.
//

#import "DefaultPageSource.h"
#if ON_DEV
    NSString * GlobalRouteWebURL = PreGlobalRouteURL;
#else
    NSString * GlobalRouteWebURL = PublishGloablRouteURL;
#endif
