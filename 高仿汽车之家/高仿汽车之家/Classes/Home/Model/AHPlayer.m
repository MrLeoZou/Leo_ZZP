//
//  AHPlayer.m
//  高仿汽车之家
//
//  Created by apple on 15/4/6.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.


//图片轮播器的模型数据

#import "AHPlayer.h"
#import "AHNetWorkTool.h"

@implementation AHPlayer

+(instancetype)playerWithDict:(NSDictionary *)dict
{

    id player = [[self alloc]init];
    for (NSString *key in [self properties]) {
        if (dict[key] != nil) {
            [player setValue:dict[key] forKeyPath:key];
        }
    }
    return player;
}

+(void)playersWithURLString:(NSString *)urlString complection:(void (^)(NSArray *))complection
{
    
    [[AHNetWorkTool shareNetWorkTool] GET:urlString parameters:nil success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
        
        NSArray *array = responseObject[@"result"][@"focusimg"];
        NSMutableArray *arrayM = [NSMutableArray arrayWithCapacity:array.count];
        
        for (NSDictionary *dict in array) {
            //网络加载的字典数据，直接转成模型
            [arrayM addObject:[self playerWithDict:dict]];
        }
        
        if (complection != nil) {
            complection(arrayM);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        NSLog(@"%@", error);
    }];
    
}

+ (NSArray *)properties
{

    return @[@"imgurl",@"updatetime",@"id",@"replycount",@"title",@"mediatype",@"type"];
}
@end
