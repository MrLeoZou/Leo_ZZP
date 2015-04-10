//
//  TGMetaDataTool.m
//  东莞团购平台
//
//  Created by mac on 14-11-21.
//  Copyright (c) 2014年 tuangou. All rights reserved.

//管理所有元数据

#import "TGMetaDataTool.h"
#import "TGCitySection.h"
#import "NSObject+Value.h"
#import "TGCity.h"
#import "TGCategory.h"
#import "TGOrder.h"

///最近访问城市的归档路径
#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"visitedCityNames.data"]

@interface TGMetaDataTool ()
{

    NSMutableArray *_visitedCityNames; // 存储曾经访问过城市的名称
    
    NSMutableDictionary *_totalCities; // 存放所有的城市 key 是城市名  value 是城市对象
    
    TGCitySection *_visitedSection; // 最近访问的城市组数组
}
@end


@implementation TGMetaDataTool

single_implementation(TGMetaDataTool)

-(id)init
{
    if (self = [super init]) {
        
        //1.加载城市数据
        [self loadCityData];

        //2.加载分区数据
        [self loadCategoryData];
        
        //3.加载排序数据
        [self loadOrderData];
        
    }
        return self;
}

#pragma mark 加载城市数据
-(void)loadCityData
{

    //0.存放所有城市
    _totalCities = [NSMutableDictionary dictionary];
    
    //1.定义一个临时可变数组,存放所有城市组
    NSMutableArray *temp  = [NSMutableArray array];
    
    //2. 添加热门城市组
    TGCitySection *hotSection = [[TGCitySection alloc]init];
    hotSection.name = @"热门城市";
    hotSection.cities  = [NSMutableArray array];
    [temp addObject:hotSection];
    
    
    //3 添加A-Z组
    //3.1.加载plist文件,遍历所有字典数据，转成模型数据
    NSArray *azArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Cities.plist" ofType:nil]];
    
    for (NSDictionary *azDict in azArray) {
        //创建城市组
        TGCitySection *citySection = [[TGCitySection alloc]init];
        [citySection setValues:azDict];
        [temp addObject:citySection];
        
        //遍历这组的所有城市
        for (TGCity *city in citySection.cities) {
            if (city.hot) { //添加热门城市
                [hotSection.cities addObject:city];
            }
            [_totalCities setObject:city forKey:city.name];
        }
        
    }
    
    // 4.从沙盒中读取之前访问过的城市名称
    _visitedCityNames = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
    if (_visitedCityNames == nil) {
        _visitedCityNames = [NSMutableArray array];
    }
    
    // 5.添加最近访问城市组
    TGCitySection *visitedSection = [[TGCitySection alloc] init];
    visitedSection.name = @"最近访问";
    visitedSection.cities = [NSMutableArray array];
    _visitedSection = visitedSection;
    
    for (NSString *name in _visitedCityNames) {
        TGCity *city = _totalCities[name];
        [visitedSection.cities addObject:city];
    }
    
    if (_visitedCityNames.count) {
        [temp insertObject:visitedSection atIndex:0];
    }
    _totalCitySections = temp;

}

#pragma mark 加载分类数据
-(void)loadCategoryData
{

    //1.
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Categories.plist" ofType:nil]];
    
    NSMutableArray *tmp = [NSMutableArray array];
    //2.先添加"全部分类"
    TGCategory *allCategory = [[TGCategory alloc]init];
    allCategory.name = kAllCategory;
    allCategory.icon = @"ic_filter_category_-1.png";
    [tmp addObject:allCategory];
    
    //3.遍历数组，添加其他分类
    for (NSDictionary *dict in array) {
        TGCategory *c = [[TGCategory alloc]init];
        [c setValues:dict];
        [tmp addObject:c];
    }
    _totalCategories = tmp;
}

#pragma mark 加载排序数据
-(void)loadOrderData
{
    //1.
    NSArray *array = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Orders.plist" ofType:nil]];
    
    NSUInteger count = array.count;
    NSMutableArray *tmp = [NSMutableArray array];
    for (int i = 0; i < count; i++) {
        TGOrder *o = [[TGOrder alloc]init];
        o.name = array[i];
        o.index = i+1;
        [tmp addObject:o];
    }
    _totalOrders = tmp;
}


//外界传入排序的名称，返回一个order模型
-(TGOrder *)orderWithName:(NSString *)name
{

    for (TGOrder *order in _totalOrders) {
        if ([name isEqualToString:order.name]) {
            //传入的排序名称存在
            return order;
        }
    }
     return nil; //传入的名称不存在
}

//外界传入一个分类的名称，返回一个对应的图片
-(NSString *)iconWithCategoryName:(NSString *)name
{

    for (TGCategory *cate in _totalCategories) {
        //1.传进来的分类名称一样
        if ([cate.name isEqualToString:name])
            return cate.icon;
//        MyLog(@"name--%@icon--%@",cate.name,cate.icon);
        
        //2.包含这个子分类名
        if ([cate.subcategories containsObject:name])
            return cate.icon;
        
    }
    //3.传入的名字不存在
    return nil;
}

#pragma mark 监听城市改变,发出通知
-(void)setCurrentCity:(TGCity *)currentCity
{

    _currentCity = currentCity;
    
    //0.只要城市改变，商区就修改为"全部商区"
    _currentDistrict = kAllDistrict;
    
    //1.移除之前的城市
    [_visitedCityNames removeObject:currentCity.name];
    
    //2.将新的城市插到最前面,如果定位失败，直接返回
    if (currentCity == nil) return;
        
    [_visitedCityNames insertObject:currentCity.name atIndex:0];
    
    //3.将新的城市插到visitedSection.cities的最前面
    [_visitedSection.cities removeObject:currentCity];
    [_visitedSection.cities insertObject:currentCity atIndex:0];
    
    //4.归档
    [NSKeyedArchiver archiveRootObject:_visitedCityNames toFile:kFilePath];
    
    //5.城市改变，发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCityChangeNote object:nil userInfo:@
    {
        kCityKey : currentCity
    }];
    
    //6.添加"最近访问"
    if (![_totalCitySections containsObject:_visitedSection]) {
        NSMutableArray *allSections = (NSMutableArray *)_totalCitySections;
        [allSections insertObject:_visitedSection atIndex:0];
    }
}

#pragma mark 监听分类改变,发出通知
-(void)setCurrentCategory:(NSString *)currentCategory
{
 
    _currentCategory = currentCategory;
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kCategoryChangeNote object:nil ];
}

#pragma mark 监听商区改变,发出通知
-(void)setCurrentDistrict:(NSString *)currentDistrict
{

    _currentDistrict = currentDistrict;
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kDistrictChangeNote object:nil ];
}

#pragma mark 监听排序改变,发出通知
-(void)setCurrentOrder:(TGOrder *)currentOrder
{

    _currentOrder = currentOrder;
    //发出通知
    [[NSNotificationCenter defaultCenter] postNotificationName:kOrderChangeNote object:nil ];
}

@end
