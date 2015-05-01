//
//  AHCarGroup.m
//  高仿汽车之家
//
//  Created by apple on 15/4/23.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHCarGroup.h"
#import "AHCar.h"
#import <MJExtension.h>

@implementation AHCarGroup
+ (NSDictionary *)objectClassInArray
{

    return @{@"list":[AHCar class]};
}

+(NSArray *)carArray
{
    
    NSMutableArray *bigArr = [NSMutableArray array];
    
    //从本地json文件加载频道数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"carList.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //取出json中需要的字典数组
    NSArray *brandlistArr = dict[@"result"][@"brandlist"];
    for (NSDictionary *dict in brandlistArr) {
        
         AHCarGroup *group =  [AHCarGroup objectWithKeyValues:dict];
        [bigArr addObject:group];
    }
    
    return bigArr;
}

-(NSString *)description
{

    return [NSString stringWithFormat:@"letter = %@,cars = %@",self.letter,self.list];
}
@end
