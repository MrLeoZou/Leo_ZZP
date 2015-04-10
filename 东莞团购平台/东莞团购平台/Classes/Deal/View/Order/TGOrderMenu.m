 //
//  TGOrderMenu.m
//  东莞团购平台
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGOrderMenu.h"
#import "TGMetaDataTool.h"
#import "TGOrderMenuItem.h"

@implementation TGOrderMenu

-(id)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    if (self) {
        //1.往scrollView添加内容
        
        //获取当前城市
        NSArray *orders = [TGMetaDataTool sharedTGMetaDataTool].totalOrders;
        NSUInteger count = orders.count;
        
        for (int i = 0; i < count; i++) {
            //创建item
            TGOrderMenuItem *item = [[TGOrderMenuItem alloc]init];
            item.order = orders[i];
            //调用父类的item点击方法
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
  
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, 0, 0);
            [_scrollView addSubview:item];
            
            if (i == 0) {
                //默认选择默认排序
                item.selected = YES;
                _selectedItem = item;
            }
        }
        _scrollView.contentSize = CGSizeMake(kBottomMenuItemW * count, 0);
    }
    return  self;
}


@end
