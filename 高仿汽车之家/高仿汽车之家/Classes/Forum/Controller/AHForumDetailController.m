//
//  AHDForumDetailController.m
//  高仿汽车之家
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHForumDetailController.h"
#import "AHForum.h"
#import "UIBarButtonItem+Extension.h"

@interface AHForumDetailController()

@property(nonatomic,strong)UIWebView *webView;
@end

@implementation AHForumDetailController

-(void)loadView
{
    _webView = [[UIWebView alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.view = _webView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏底部工具条，显示顶部导航条
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBarHidden = NO;
    
    //设置导航条按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImage:@"bar_btn_icon_returntext" higImage:@"bar_btn_icon_returntext" title:@"返回" titleColor:[UIColor blueColor] target:self action:@selector(backOnClick)];
    
    NSString *urlStr = [NSString stringWithFormat:@"http://forum.app.autohome.com.cn/autov4.6/forum/club/topiccontent-a2-pm1-v4.6.6-t%ld-o0-p1-s20-c1-nt0-fs0-sp1-al0-cw320.json",self.forum.topicid];
    
    NSURL *url = [NSURL URLWithString:urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:request];
}

///  pop到之前控制器
- (void)backOnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
//    [SVProgressHUD dismiss];
}

@end
