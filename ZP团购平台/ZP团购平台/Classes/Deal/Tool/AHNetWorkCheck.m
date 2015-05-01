//
//  AHNetWorkCheck.m
//  高仿汽车之家
//
//  Created by apple on 15/4/24.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHNetWorkCheck.h"
#import "Reachability.h"
#import "SVProgressHUD.h"

@implementation AHNetWorkCheck

static AHNetWorkCheck *_check;
+ (instancetype)shareCheck
{

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        _check = [[AHNetWorkCheck alloc]init];
    });
    return _check;
}

- (void)checkNetConnect
{
    
    //    NSLog(@"开启 www.apple.com 的网络检测");
    Reachability* reach = [Reachability reachabilityWithHostname:@"www.apple.com"];
    //    NSLog(@"-- current status: %@", reach.currentReachabilityString);
    
    // start the notifier which will cause the reachability object to retain itself!
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reachabilityChanged:)
                                                 name:kReachabilityChangedNotification
                                               object:nil];
    
    
    [reach startNotifier];
}


- (void)reachabilityChanged:(NSNotification*)note {
    Reachability * reach = [note object];
    
    if(![reach isReachable])
    {
        [SVProgressHUD showInfoWithStatus:@"当前网络不可用"];
        self.isConnected = NO;
        return;
        
    }
    
    self.isConnected = YES;

//    [SVProgressHUD showWithStatus:@"当前网络可用"];
//    
//    if (reach.isReachableViaWiFi) {
//        [SVProgressHUD showWithStatus:@"当前通过wifi连接"];
//    } else {
//        [SVProgressHUD showWithStatus:@"wifi未开启，不能用"];
//    }
//    
//    if (reach.isReachableViaWWAN) {
//        [SVProgressHUD showWithStatus:@"当前通过2g or 3g连接"];
//    } else {
//        [SVProgressHUD showWithStatus:@"2g or 3g网络未使用"];
//    }
}


@end
