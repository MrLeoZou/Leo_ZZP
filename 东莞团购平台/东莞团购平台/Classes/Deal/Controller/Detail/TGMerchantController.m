//
//  TGMerchantController.m
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//商家详情

#import "TGMerchantController.h"
#import "TGDeal.h"

@interface TGMerchantController ()<UIWebViewDelegate>
{

    UIWebView *_webView;
    UIView *_cover;
}
@end

@implementation TGMerchantController

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
    //1.添加遮盖
    [self addCover];
    
    //2.发送请求，加载网页
    NSString *ID = [_deal.deal_id substringFromIndex:[_deal.deal_id rangeOfString:@"-"].location + 1];
    NSString *url = [NSString stringWithFormat:@"http://m.dianping.com/tuan/shoplist/%@", ID];
    [_webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:url]]];
    
}

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

#pragma mark webView的代理方法
//-(BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
//{
////    MyLog(@"更详细的URL---%@",request.URL);
////    return YES;
////    if (([request.URL.absoluteString hasPrefix:@"http://m.dianping.com/tuan/shoplist/"]) ||  ([request.URL.absoluteString hasPrefix:@"http://m.dianping.com/shop/"]))
////        
////        return YES;
////    else
////        return NO;
//}


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

    //1.0 创建link元素并取得href值
    [script appendString:@"var link = document.createElement('link');"];
    [script appendString:@"link.rel = 'stylesheet';"];
    [script appendString:@"link.type = 'text/css';"];
    [script appendString:@"link.href = document.styleSheets[0].href;"];
     
    // 1.1.取出body
    [script appendString:@"var body = document.body;"];
    
    // 1.2.取出section
    [script appendString:@"var div1 = document.getElementsByClassName('shop-group-list')[0];"];

    // 1.3.清空body
    [script appendString:@"body.innerHTML = '';"];
     
    // 1.4.添加linkhediv到body
    [script appendString:@"body.appendChild(link);"];
    [script appendString:@"body.appendChild(div1);"];

    // 2.执行脚本
    [webView stringByEvaluatingJavaScriptFromString:script];


    // 3.移除遮盖
    [_cover removeFromSuperview];
    _cover = nil;

}


//<script type="text/javascript">
//
////创建link元素并取得href值
//var link = document.createElement("link");
//link.rel = "stylesheet";
//link.type = "text/css";
//link.href = document.styleSheets[0].href;
//
////1.取出body
//var body = document.body;
////2.取出div
//
//var div1 = document.getElementsByClassName('shop-group-list')[0];
////3.清空body
//body.innerHTML = '';
////4.添加div到body中
//
//body.appendChild(link);
//body.appendChild(div1);
//</script>

@end
