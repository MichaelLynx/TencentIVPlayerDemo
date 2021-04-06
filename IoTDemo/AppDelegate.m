//
//  AppDelegate.m
//  IoTDemo
//
//  Created by lynx on 2/12/2020.
//  Copyright © 2020 lynx. All rights reserved.
//

#import "AppDelegate.h"

#import "DefaultPageSource.h"

#import <IoTVideo/IoTVideo.h>

@interface AppDelegate ()<IoTVideoDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    NSString * url = [[NSUserDefaults standardUserDefaults] objectForKey:KeyEnvRoute];
    if (!url) {
        [[NSUserDefaults standardUserDefaults] setObject:PreGlobalRouteURL forKey:KeyEnvRoute];
        GlobalRouteWebURL = (url == nil ? PreGlobalRouteURL : url);
    }
    
    [[IoTVideo sharedInstance] setupWithLaunchOptions:launchOptions];
    [IoTVideo sharedInstance].delegate = self;
    [IoTVideo sharedInstance].logLevel = IVLogLevel_DEBUG;
    
    
    return YES;
}


- (void)didUpdateLinkStatus:(IVLinkStatus)linkStatus {
    NSLog(@"sdkLinkStatus: %lu", (unsigned long)linkStatus);
}

- (void)didOutputLogMessage:(NSString *)message level:(IVLogLevel)level file:(NSString *)file func:(NSString *)func line:(int)line {
    //NSLog(@"message:%@\nlevel:%lu\nfile:%@\nfunc:%@\nline:%d", message, (unsigned long)level, file, func, line);
}

@end
