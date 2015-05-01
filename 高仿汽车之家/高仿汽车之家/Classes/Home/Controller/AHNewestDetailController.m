//
//  AHNewestDetailController.m
//  高仿汽车之家
//
//  Created by apple on 15/4/18.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHNewestDetailController.h"
#import "AHNews.h"
#import <AFNetworking.h>
#import "UIBarButtonItem+Extension.h"
#import <SVProgressHUD.h>
#import "AHNetWorkTool.h"

@interface AHNewestDetailController ()<UIWebViewDelegate>

///  webView
@property(nonatomic,weak)UIWebView *webView;

///  模型id
@property(nonatomic,copy)NSString *idStr;
@end

@implementation AHNewestDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏底部工具条，显示顶部导航条
    self.navigationController.toolbarHidden = YES;
    self.navigationController.navigationBarHidden = NO;
    
    //发送GET请求,获取网络数据
    [self loadDetailData];
    
    //设置导航条按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithNorImage:@"bar_btn_icon_returntext" higImage:@"bar_btn_icon_returntext" title:@"返回" titleColor:[UIColor blueColor] target:self action:@selector(backOnClick)];
   
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithNorImage:nil higImage:nil title:@"更多" titleColor:[UIColor blueColor] target:self action:@selector(moreOnClick)];
    
}

///  pop到之前控制器
- (void)backOnClick
{
    [self.navigationController popToRootViewControllerAnimated:YES];
    [SVProgressHUD dismiss];
}

///  点击更多方法
- (void)moreOnClick
{

    NSLog(@"加载更多");
}

///  加载详情数据，webView
- (void)loadDetailData
{
    NSString *idStr = self.news.id;
    self.idStr = idStr;

    //首页的最新界面跟其他界面分开处理，因为最新界面情况比较复杂
    
    if (self.isNewest) {
        //处理最新界面cell点击
        [self loadNewestDetailView];
        
    }else{
    
        //处理其他界面cell的点击，新闻，评测，导购，用车，技术，文化
        //点击这几个界面跳转的url都相同，只是id不同
        [self loadOtherDetailView];
    }
    
}

///处理其他界面cell的点击，新闻，评测，导购，用车，技术，文化
- (void)loadOtherDetailView
{
    NSString *urlStr = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.6/content/news/newsinfo-a2-pm1-v4.6.6-i%@.html",_idStr];
    
    [[AHNetWorkTool shareNetWorkTool] loadHomeDetailViewWithUrlStr:urlStr success:^(id responseObject) {
        
        //加载网页
        [self loadWebViewWithURLStr:responseObject[@"result"][@"url"]];
        
    } failed:^(NSError *error) {
        
        DDLogError(@"%@",error);
    }];
}

///  处理最新界面cell点击
- (void)loadNewestDetailView
{
    if (self.isTop) { //点击头条
        
        //加载网页
        [self loadWebViewWithURLStr:self.news.jumpurl];
        
    }else if (2 == self.news.mediatype){ //点击说客
        
        NSString *urlStr = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.6/news/shuokeinfo-a2-pm1-v4.6.6-n%@.html",_idStr];
        
        [[AHNetWorkTool shareNetWorkTool] loadHomeDetailViewWithUrlStr:urlStr success:^(id responseObject) {
            
            [self loadWebViewWithURLStr:responseObject[@"result"][@"weburl"]];
        } failed:^(NSError *error) {
            
            DDLogError(@"%@",error);
        }];
        
    }else if (6 == self.news.mediatype){ //点击多图

        
    }else if (3 == self.news.mediatype){ //点击播放cell
        
        NSString *urlStr = [NSString stringWithFormat:@"http://app.api.autohome.com.cn/autov4.6/news/videoinfo-a2-pm1-v4.6.6-i%@.html",_idStr];
        
        [[AHNetWorkTool shareNetWorkTool] loadHomeDetailViewWithUrlStr:urlStr success:^(id responseObject) {
            
            [self loadWebViewWithURLStr:responseObject[@"result"][@"weburl"]];
            
        } failed:^(NSError *error) {
            
            DDLogError(@"%@",error);
        }];
        
    }else if (5 == self.news.mediatype){ //点击回帖cell
    
        NSString *urlStr = [NSString stringWithFormat:@"http://forum.app.autohome.com.cn/autov4.6/forum/club/topiccontent-a2-pm1-v4.6.6-t%@-o0-p1-s20-c1-nt0-fs0-sp1-al0-cw320.json",_idStr];
        
        [self loadWebViewWithURLStr:urlStr];
        
    }else if (self.isImageView){ //点击图片轮播器
    
        [self loadWebViewWithURLStr:self.imgVUrlStr];
        
    }else{ //点击的不是头条
        
        NSString *urlStr = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.6/content/news/newsinfo-a2-pm1-v4.6.6-i%@.html",_idStr];
        
        [[AHNetWorkTool shareNetWorkTool] loadHomeDetailViewWithUrlStr:urlStr success:^(id responseObject) {
            
        [self loadWebViewWithURLStr:responseObject[@"result"][@"url"]];
            
        } failed:^(NSError *error) {
            
            DDLogError(@"%@",error);
        }];
    }

}


-(void)viewWillAppear:(BOOL)animated
{

    [super viewWillAppear:animated];
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
}

///加载网页
- (void)loadWebViewWithURLStr:(NSString *)urlString
{
    //加载网页
//    NSLog(@"%@ -- %@",self.view.subviews,self.webView);
    NSURL *newUrl = [NSURL URLWithString:urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:newUrl];
    [self.webView loadRequest:request];
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
