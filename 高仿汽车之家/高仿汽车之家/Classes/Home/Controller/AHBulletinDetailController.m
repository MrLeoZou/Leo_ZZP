//
//  AHBulletinDetailController.m
//  高仿汽车之家
//
//  Created by apple on 15/4/17.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHBulletinDetailController.h"

@interface AHBulletinDetailController ()
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation AHBulletinDetailController

-(void)loadView
{
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
#warning 这个请求返回是json数据,不是网页！
    NSString *urlStr = @"http://cont.app.autohome.com.cn/autov4.6/content/News/fastnewscontent-n54-lastid0.json";

    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
