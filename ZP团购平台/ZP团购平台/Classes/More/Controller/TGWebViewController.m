//
//  TGWebViewController.m
//  东莞团购平台
//
//  Created by apple on 15/4/22.
//  Copyright (c) 2015年 tuangou. All rights reserved.
//

#import "TGWebViewController.h"
#import "SVProgressHUD.h"

@interface TGWebViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)UIWebView *webView;
@end

@implementation TGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.webView.delegate = self;
    
    NSURL *url = [NSURL URLWithString:self.urlStr];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    //添加蒙板
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

#pragma mark - webView代理方法

-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [SVProgressHUD dismiss];
}

-(void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    
    [SVProgressHUD dismiss];
}

#pragma  mark - lazy
-(UIWebView *)webView
{
    
    if (!_webView) {
        UIWebView *webV = [[UIWebView alloc]initWithFrame:self.view.frame];
        _webView = webV;
        _webView.delegate = self;
        [self.view addSubview:_webView];
    }
    return _webView;
}
@end