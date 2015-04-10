//
//  TGDealWebController.m
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//图文详情

#import "TGDealWebController.h"
#import "TGDeal.h"

@interface TGDealWebController ()<UIWebViewDelegate>
{

    UIWebView *_webView;
    UIView *_cover;
}
@end

@implementation TGDealWebController

- (void)loadView
{
    _webView = [[UIWebView alloc] initWithFrame:[UIScreen mainScreen].applicationFrame];
    _webView.backgroundColor = kGlobalBg;
    _webView.scrollView.backgroundColor = kGlobalBg;
    _webView.delegate = self;
    self.view = _webView;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addCover];
    
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/deal/moreinfo/%@", ID];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
  

}

#pragma mark 拦截webView的所有请求
-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    if([request.URL.absoluteString hasPrefix:@"http://m.dianping.com/tuan/deal/moreinfo"])
    return YES;
    else
        return NO;
}

//-(void)webViewDidFinishLoad:(UIWebView *)webView
//{
//
////    NSString *str = [webView stringByEvaluatingJavaScriptFromString:@"(document.getElementsByTagName('html')[0]).innerHTML"];
////    MyLog(@"\n%@",str);
//    // 3.移除遮盖
//    [_cover removeFromSuperview];
//    _cover = nil;
//}


- (void)addCover
{
    _cover = [[UIView alloc] init];
    _cover.frame = _webView.bounds;
    _cover.backgroundColor = kGlobalBg;
    [_webView addSubview:_cover];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    CGFloat x = _cover.frame.size.width * 0.5;
    CGFloat y = _cover.frame.size.height * 0.5;
    indicator.center = CGPointMake(x, y);
    [_cover addSubview:indicator];
    [indicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    
    // 0.删除scrollView顶部和底部灰色的view
    for (UIView *view in webView.scrollView.subviews) {
        if ([view isKindOfClass:[UIImageView class]]) {
            [view removeFromSuperview];
        }
    }
    
    CGFloat height = 50;
    webView.scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    webView.scrollView.contentOffset = CGPointMake(0, -height);
    
    // 1.拼接脚本
    NSMutableString *script = [NSMutableString string];

    // 1.1.取出body
    [script appendString:@"var body = document.body;"];
    
    // 1.2.取出div
    [script appendString:@"var div1 = document.getElementsByClassName('detail-info group-detail')[1];"];
    [script appendString:@"var div1 = document.getElementsByClassName('detail-info group-detail')[2];"];
    
    // 1.3.清空body
    [script appendString:@"body.innerHTML = '';"];
    
    // 1.4.添加div到body
    [script appendString:@"body.appendChild(div1);"];
    [script appendString:@"body.appendChild(div2);"];
    
    // 2.执行脚本
    [webView stringByEvaluatingJavaScriptFromString:script];
    
    
    // 3.移除遮盖
    [_cover removeFromSuperview];
    _cover = nil;
    
}


//<script type="text/javascript">
////1.取出body
//var body = document.body;
////2.取出div
//var div1 = document.getElementsByClassName('detail-info group-detail')[1];
//var div2 = document.getElementsByClassName('detail-info group-detail')[2];
////3.清空body
//body.innerHTML = '';
////4.添加div到body中
//body.appendChild(div1);
//body.appendChild(div2);
//</script>
@end
