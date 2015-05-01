//
//  TGMetaDataTool.h
//  东莞团购平台
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//单例 --》元数据管理类，管理所有
//1.城市数据
//2.分区数据
//3.分类数据

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class TGCity,TGOrder;
@interface TGMetaDataTool : NSObject

single_interface(TGMetaDataTool);
/// 所有的城市
@property (nonatomic, strong, readonly) NSDictionary *totalCities;

///所有的城市组数据
@property(nonatomic,strong,readonly)NSArray *totalCitySections;

///所有的分类数据
@property(nonatomic,strong,readonly)NSArray *totalCategories;

///所有的排序数据
@property(nonatomic,strong,readonly)NSArray *totalOrders;

/// 当前选中的城市（使用模型：包括分区，热度）
@property (nonatomic, strong) TGCity *currentCity;

///当前选中的类别
@property(nonatomic,strong)NSString *currentCategory;

///当前选中的区域
@property(nonatomic,strong)NSString *currentDistrict;

/// 当前选中的排序（使用模型：包括名称，索引）
@property (nonatomic, strong) TGOrder *currentOrder;

///外界传入排序的名称，返回一个order模型
-(TGOrder *)orderWithName:(NSString *)name;

///外界传入一个分类的名称，返回一个对应的图片(地图模块)
-(NSString *)iconWithCategoryName:(NSString *)name;
@end
