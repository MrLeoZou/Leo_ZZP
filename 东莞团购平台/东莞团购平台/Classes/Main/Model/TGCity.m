//
//  TGCity.m
//  团购
//
//  Created by zhipeng on 14-8-6.
//  Copyright (c) 2014年 zou. All rights reserved.
//

#import "TGCity.h"
#import "TGDistrict.h"
#import "NSObject+Value.h"

@implementation TGCity
//重写set方法，将district字典转换成数组
-(void)setDistricts:(NSArray *)districts
{
    
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in districts) {
        TGDistrict *districts = [[TGDistrict alloc]init];
        
        [districts setValues:dict];
        [array addObject:districts];
    }
    _districts = array;
}
@end
