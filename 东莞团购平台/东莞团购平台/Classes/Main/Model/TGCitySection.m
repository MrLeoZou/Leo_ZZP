//
//  TGCitySection.m
//  团购
//
//  Created by zhipeng on 14-8-6.
//  Copyright (c) 2014年 zou. All rights reserved.
//

#import "TGCitySection.h"
#import "TGCity.h"
#import "NSObject+Value.h"

@implementation TGCitySection
//重写set方法，将cities字典转换成数组
-(void)setCities:(NSMutableArray *)cities
{
    //当cities里面为空或者装的是模型数据，就直接赋值
    id obj = [cities lastObject];
    if (![obj isKindOfClass:[NSDictionary class]]) {
        _cities = cities;
        return;
    }
    NSMutableArray *array = [[NSMutableArray alloc]init];
    for (NSDictionary *dict in cities) {

        TGCity *city = [[TGCity alloc]init];
        
        [city setValues:dict];
        [array addObject:city];
    }
    _cities = array;
}
@end
