//
//  TGCategoryMenu.m
//  东莞团购平台
//
//  Created by mac on 14-11-23.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGCategoryMenu.h"
#import "TGMetaDataTool.h"
#import "TGCategoryMenuItem.h"
#import "TGCategory.h"
#import "TGSubtitlesView.h"

@interface TGCategoryMenu()
//{
//
//    TGSubtitlesView *_subtitlesView;
//}

@end

@implementation TGCategoryMenu

//1.调用initWithFrame，获取父类共有属性
-(id)initWithFrame:(CGRect)frame
{

    self = [super initWithFrame:frame];
    if (self) {
        
        //0.获取所有的分类数据
        NSArray *categories = [TGMetaDataTool sharedTGMetaDataTool].totalCategories;
        
        //1.往scrollView上面添加内容（分类）
        //1.1 遍历所有的其他分类数据
        NSUInteger count = categories.count;
        for (int i = 0; i<count; i++) {
            
            //创建item
            TGCategoryMenuItem *item = [[TGCategoryMenuItem alloc]init];
            item.category = categories[i];
            [item addTarget:self action:@selector(itemClick:) forControlEvents:UIControlEventTouchUpInside];
            item.frame = CGRectMake(i * kBottomMenuItemW, 0, kBottomMenuItemW, 35);
            [_scrollView addSubview:item];
            
            if (i == 0) {
                //默认选择全部分类
                item.selected = YES;
                _selectedItem = item;
            }
        }
        _scrollView.contentSize = CGSizeMake(count * kBottomMenuItemW, 0);
        _scrollView.userInteractionEnabled = YES;
    }
    return self;
}


//2.实现父类声明的方法，设置自己子菜单的标题
-(void)settingSubtitlesView
{
    //2.1 使用传进来的block中的title来设置自己title
    _subtitlesView.setTitleBlock = ^(NSString *title){
    
        [TGMetaDataTool sharedTGMetaDataTool].currentCategory = title;
    };
    
    //2.2 使用block把当前子菜单标题传出去
    _subtitlesView.getTitleBlock = ^{
    
        return [TGMetaDataTool sharedTGMetaDataTool].currentCategory;
    };
}
@end
