//
//  TGDistrictMenuItem.m
//  东莞团购平台
//
//  Created by mac on 14-12-2.
//  Copyright (c) 2014年 tuangou. All rights reserved.
//

#import "TGDistrictMenuItem.h"
#import "TGDistrict.h"

@implementation TGDistrictMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//拿到模型数据，设置item的文字
-(void)setDistrict:(TGDistrict *)district
{

    _district  = district;
    [self setTitle:district.name forState:UIControlStateNormal];
}

//调用父类方法，给它传递自己的子分类名称
- (NSArray *)titles
{
    return _district.neighborhoods;
}

@end
