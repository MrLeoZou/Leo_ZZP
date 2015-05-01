//
//  AppDelegate.m
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AppDelegate.h"
#import "AHMainController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    [self setDDLog];
    
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.rootViewController = [[AHMainController alloc]init];
    [self.window makeKeyAndVisible];
    
    return YES;
}

- (void)setDDLog
{
    // 1.初始化自定义LOG
    // Standard lumberjack initialization
    [DDLog addLogger:[DDTTYLogger sharedInstance]];
    
    // And we also enable colors
    [[DDTTYLogger sharedInstance] setColorsEnabled:YES];
    
    //自定义log颜色
    [[DDTTYLogger sharedInstance] setForegroundColor:[UIColor greenColor] backgroundColor:[UIColor grayColor] forFlag:DDLogFlagInfo];
//        DDLogInfo(@"ABCD");
//        DDLogError(@"qqqq");
//        DDLogWarn(@"warn");
}
@end
