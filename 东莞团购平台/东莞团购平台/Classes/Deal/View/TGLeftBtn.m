//
//  TGLeftBtn.m
//  东莞团购平台
//
//  Created by mac on 14-11-5.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGLeftBtn.h"
#import "TGCity.h"
#import "TGMetaDataTool.h"
#import "TGLocationTool.h"

#define kLeftBtnW 60
#define kLeftBtnH 44
// 文字的宽度比例
#define kTitleRatio 0.3

@interface TGLeftBtn()
{

    UIActivityIndicatorView *_indicator;
}

@end

@implementation TGLeftBtn

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //1 设置文字
        [self setTitle:@"定位中" forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont systemFontOfSize:14];
        [self setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [self setTitleColor:[UIColor grayColor] forState:UIControlStateDisabled];
    

        //2监听城市改变的通知
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cityChange:) name:kCityChangeNote object:nil];
        
        //3.加载城市信息
        [self loadCity];
    }
    return self;
}

#pragma mark 加载城市信息
-(void)loadCity
{

    // 1.添加圈圈
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    CGFloat x = kLeftBtnW * 0.5 + 23;
    CGFloat y = 25;
    indicator.center = CGPointMake(x, y);
    [self addSubview:indicator];
    [indicator startAnimating];
    _indicator = indicator;
    
    //2.定位
    [TGLocationTool sharedTGLocationTool];
}

#pragma mark 城市改变
- (void)cityChange:(TGCity *)city
{
    city = [TGMetaDataTool sharedTGMetaDataTool].currentCity;
    
    if ([_delegate respondsToSelector:@selector(cityIsChange:)]) {
        [_delegate cityIsChange:city];
    }
    // 1.更改显示的城市名称
    [self setTitle:city.name forState:UIControlStateNormal];
    
    // 2.变为enable
    self.enabled = YES;

    // 3.移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIDeviceOrientationDidChangeNotification object:nil];

    //4.移除圈圈
    [_indicator removeFromSuperview];
    _indicator = nil;
    
    //5.设置图标
     [self setImage:[UIImage imageNamed:@"ic_district.png"] forState:UIControlStateNormal];
}

//内部设置button的宽高
-(void)setFrame:(CGRect)frame
{
    frame.size.width = kLeftBtnW;
    frame.size.height = kLeftBtnH;
    [super setFrame:frame];
}

#pragma mark - 设置item内部的图片、文字位置
-(CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleX = 0;
    CGFloat titleY = 3;
    CGFloat titleW = contentRect.size.width * (1-kTitleRatio);
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

-(CGRect)imageRectForContentRect:(CGRect)contentRect
{

    CGFloat imageX = contentRect.size.width * (1-kTitleRatio);
    CGFloat imageY = 13;
    CGFloat imageW = contentRect.size.width * kTitleRatio;
    CGFloat imageH = contentRect.size.height - 25;
    return CGRectMake(imageX, imageY, imageW, imageH);
}
@end
