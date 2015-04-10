//
//  TGAppDelegate.m
//  东莞团购平台
//
//  Created by mac on 14-11-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGAppDelegate.h"
#import "TGMainController.h"
#import "TGImageTool.h"

@implementation TGAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.rootViewController = [[TGMainController alloc]init];
    [self.window makeKeyAndVisible];
 
    return YES;
}

#pragma mark 内存警告，清理内存
-(void)applicationDidReceiveMemoryWarning:(UIApplication *)application
{

    //1.调用工具类方法，清除图片缓存
    [TGImageTool clear];
}
@end
