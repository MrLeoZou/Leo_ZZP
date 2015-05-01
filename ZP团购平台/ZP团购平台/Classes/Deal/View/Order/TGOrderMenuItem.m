//
//  TGOrderMenuItem.m
//  东莞团购平台
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGOrderMenuItem.h"
#import "TGOrder.h"

@implementation TGOrderMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//拿到模型数据，设置item的文字
-(void)setOrder:(TGOrder *)order
{

    _order = order;
    [self setTitle:order.name forState:UIControlStateNormal];
}
@end
