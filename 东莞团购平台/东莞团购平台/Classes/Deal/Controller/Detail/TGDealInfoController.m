//
//  TGDealInfoControllerViewController.m
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDealInfoController.h"
#import "TGInfoHeadView.h"
#import "TGDeal.h"
#import "TGDealTool.h"
#import "TGInfoTextView.h"
#import "TGRestriction.h"

#define kVMargin 15

@interface TGDealInfoController ()
{

    UIScrollView *_scrollView; //
    TGInfoHeadView *_header;
    CGFloat _lastY; //用来记录最后添加的textView的Y值
}
@end

@implementation TGDealInfoController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //1.添加scrollView
    [self addScrollView];
    
    //2.往scrollView添加头部xib
    [self addHeaderXib];
    
    //3.添加更详细的团购数据
    [self addMoreDetailDeal];
}

#pragma mark 加载更详细的团购数据
-(void)addMoreDetailDeal
{

    // 1.添加圈圈
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
    CGFloat x = _scrollView.frame.size.width * 0.5;
    CGFloat y = CGRectGetMaxY(_header.frame) + kVMargin;
    indicator.center = CGPointMake(x, y);
    [_scrollView addSubview:indicator];
    [indicator startAnimating];
    
    // 2.发送请求
    [[TGDealTool sharedTGDealTool] dealWithID:_deal.deal_id success:^(TGDeal *deal) {
        _deal = deal;
        
        //设置团购简介数据
        _header.deal = deal;
       
        //加载完团购简介后，添加详情数据（团购详情、购买须知、重要通知）
        [self addDetailViews];
        
        // 移除圈圈
        [indicator removeFromSuperview];
        
    } error:nil];
}

#pragma mark 添加详情数据（团购详情、购买须知、重要通知）
-(void)addDetailViews
{

    //0.初始化成员变量
    _lastY = CGRectGetMaxY(_header.frame) + kVMargin;
    
    //1.团购详情
    [self addOneInfoTextViewWithTile:@"团购详情" icon:@"ic_content.png" content:_deal.details];
 
    //2.购买须知
    [self addOneInfoTextViewWithTile:@"购买须知" icon:@"ic_tip.png" content:_deal.restrictions.special_tips];
    
    //3.重要通知
    [self addOneInfoTextViewWithTile:@"重要通知" icon:@"ic_tip.png" content:_deal.notice];
}

#pragma mark 创建一个InfoTextView的方法
-(void)addOneInfoTextViewWithTile:(NSString *)title icon:(NSString *)icon content:(NSString *)content
{
    if (content.length == 0)  return;

    //1.创建View
    TGInfoTextView *textView = [TGInfoTextView infoTextViewXib];
    CGFloat w = _scrollView.frame.size.width;
    CGFloat h = textView.frame.size.height;
    textView.frame = CGRectMake(0, _lastY, w, h);
    
    //2.设置属性
    textView.title = title;
    textView.content = content;
    textView.icon = icon;
    
    //3.添加到_scrollView
    [_scrollView addSubview:textView];
    
    //4.计算当前最后Y的值
    _lastY = CGRectGetMaxY(textView.frame) + kVMargin;
    
    //5.设置滚动区域
    _scrollView.contentSize = CGSizeMake(0, _lastY );
    _scrollView.contentInset = UIEdgeInsetsMake(60, 0, 100, 0);

    
}

#pragma mark 往scrollView添加头部xib
-(void)addHeaderXib
{

    TGInfoHeadView *header = [TGInfoHeadView infoHeadViewXib];
    header.frame = CGRectMake(0, 0, _scrollView.frame.size.width, 0);
    header.deal = _deal;
    [_scrollView addSubview:header];
    _header = header;
}

#pragma mark 添加滚动视图
- (void)addScrollView
{
    UIScrollView *scrollView = [[UIScrollView alloc] init];
    scrollView.showsVerticalScrollIndicator = NO;
    scrollView.frame = CGRectMake(0, 0, self.view.frame.size.width - kDetailDockWidth, self.view.frame.size.height);
    
    scrollView.backgroundColor = kGlobalBg;
    CGFloat height = 50;
    scrollView.contentInset = UIEdgeInsetsMake(height, 0, 0, 0);
    scrollView.contentOffset = CGPointMake(0, -height);
    [self.view addSubview:scrollView];
    _scrollView = scrollView;
}



@end
