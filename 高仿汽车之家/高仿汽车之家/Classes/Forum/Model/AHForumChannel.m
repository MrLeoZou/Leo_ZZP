//
//  AHForumChannel.m
//  高仿汽车之家
//
//  Created by apple on 15/4/5.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHForumChannel.h"

@interface AHForumChannel()
///  记录字典数组
@property(nonatomic,strong)NSDictionary *channelDict;
@end

@implementation AHForumChannel

+ (instancetype)channelWithDict:(NSDictionary *)dict {
    id obj = [[self alloc] init];
    
    // 遍历属性数组
    for (NSString *key in [self properties]) {
        if (dict[key] != nil) {
            [obj setValue:dict[key] forKey:key];
        }
    }
    
    return obj;
}

+ (NSArray *)properties {
    return @[@"name", @"value", @"type"];
}

+ (NSArray *)channel
{
    NSMutableArray *temp = [NSMutableArray array];
    
    //从本地json文件加载频道数据
    NSString *path = [[NSBundle mainBundle] pathForResource:@"Forum.json" ofType:nil];
    NSData *data = [NSData dataWithContentsOfFile:path];
    
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:NULL];
    //取出json中需要的字典数组
    NSArray *arrayTemp = dict[@"result"][@"metalist"];
    NSArray *array = arrayTemp[4][@"list"];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        
        AHForumChannel *model = [self channelWithDict:obj];
        [temp addObject:model];
      
    }];
    //根据对象的id值，value排序
    return [temp sortedArrayUsingComparator:^NSComparisonResult(AHForumChannel *obj1, AHForumChannel *obj2) {
        return obj1.value > obj2.value;
    }];
}

- (NSString *)description {
    return [NSString stringWithFormat:@"<%@: %p>, %@", self.class, self, [self dictionaryWithValuesForKeys:[AHForumChannel properties]]];
}

@end
