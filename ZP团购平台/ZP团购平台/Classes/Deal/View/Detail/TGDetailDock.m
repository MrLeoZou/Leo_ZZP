//
//  TGDetailDock.m
//  东莞团购平台
//
//  Created by mac on 14-12-25.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDetailDock.h"

@interface TGDetailDock()
{

    UIButton *_selected;
}
@end

//实现自己定义的类，覆盖点高亮状态
@implementation TGDetailDockItem

-(void)setHighlighted:(BOOL)highlighted {};

@end

@implementation TGDetailDock

+(id)detailDockXib
{
    return [[NSBundle mainBundle]loadNibNamed:@"TGDetailDock" owner:nil options:nil][0];
    
}

-(void)setFrame:(CGRect)frame
{
    //用当前的frame覆盖传进来的frame，不允许外面修改自身的frame
    frame.size = self.frame.size;
    [super setFrame:frame];
}

-(void)awakeFromNib
{
    //默认选中第一个
    [self btnClick:_infoBtn];
}

- (IBAction)btnClick:(UIButton *)sender
{
    //0.通知代理
    if ([_delegate respondsToSelector:@selector(detailDock:btnClickFrom:to:)]) {
        [_delegate detailDock:self btnClickFrom:_selected.tag to:sender.tag];
    }
    
    //1.控制选中状态
    _selected.enabled = YES;
    sender.enabled = NO;
    _selected = sender;
    
}
@end
