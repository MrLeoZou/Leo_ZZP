
#import "TGDealTool.h"
#import "TGMetaDataTool.h"
#import "DPAPI.h"
#import "TGCity.h"
#import "TGDeal.h"
#import "TGOrder.h"
#import "NSObject+Value.h"
#import "TGLocationTool.h"

typedef void (^RequestBlock)(id result,NSError *errorRequest); //定义一个发送请求的block，用来处理传进来的block

@interface TGDealTool() <DPRequestDelegate>
{

    NSMutableDictionary *_blocks; //使用一个字典保存所有请求返回的block
}
@end

@implementation TGDealTool
single_implementation(TGDealTool)

//单例对象，只需要使用init方法创建一次
-(id)init
{

    if (self = [super init]) {
        
        _blocks = [NSMutableDictionary dictionary];
    }
    return self;
}

#pragma mark 获得指定的团购数据
- (void)dealWithID:(NSString *)ID success:(OneDealSuccessBlock)success error:(OneDealErrorBlock)error{
    [self requestWithUrl:@"v1/deal/get_single_deal" params:@{
    @"deal_id" : ID
    } block:^(id result, NSError *errorObj) {
        NSArray *deals = result[@"deals"];
     if (deals.count) { // 成功,并且有值
        if (success) {
            TGDeal *deal = [[TGDeal alloc] init];
            [deal setValues:result[@"deals"][0]];
            success(deal);
//            MyLog(@"%@",result);
            }
    } else { // 失败
         if (error) {
            error(errorObj);
            }
        }
    }];
}

#pragma mark 获得大批量团购
- (void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    //0.限制一次加载多少条团购
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithObject:@(10) forKey:@"limit"];
    
    //1.添加城市参数
    NSString *city = [TGMetaDataTool sharedTGMetaDataTool].currentCity.name;
    if (city) { //定位成功，有城市名才进行解析
         [params setObject:city forKey:@"city"];
    }
   
    
    //2.添加分类参数
    NSString *category = [TGMetaDataTool sharedTGMetaDataTool].currentCategory;
    if (category && ![category isEqualToString:kAllCategory]) {
        [params setObject:category forKey:@"category"];
    }
    
    //3.添加商区参数
    NSString *district = [TGMetaDataTool sharedTGMetaDataTool].currentDistrict;
    if (district && ![district isEqualToString:kAllDistrict]) {
        [params setObject:district forKey:@"region"];
    }
    
    //4.添加排序参数
    TGOrder *order = [TGMetaDataTool sharedTGMetaDataTool].currentOrder;
    if (order) {
        if (order.index == 7) {// 按距离最近排序
            TGCity *city = [TGLocationTool sharedTGLocationTool].locationCity;
            if (city) { // 按距离最近排序
                [params setObject:@(order.index) forKey:@"sort"];
                // 多增加经纬度参数
                [params setObject:@(city.position.latitude) forKey:@"latitude"];
                [params setObject:@(city.position.longitude) forKey:@"longitude"];
            }
        } else { // 按照其他方式排序
            [params setObject:@(order.index) forKey:@"sort"];
        }
    }

    //5.页码参数
    [params setObject:@(page) forKey:@"page"];
    
    //6.发送请求
    [self getDealsWithParams:params success:success error:error];
}

#pragma mark 获得指点坐标的周边团购信息
-(void)dealWithPos:(CLLocationCoordinate2D )pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{

    TGCity *city = [TGLocationTool sharedTGLocationTool].locationCity;
//    if (city == nil) return;
    
    [self getDealsWithParams:@{
                               @"city" : @"东莞",
                               @"latitude" : @(pos.latitude),
                               @"longitude" : @(pos.longitude),
                               @"radius" : @5000
                               }
                     success:success
                       error:error];
}

#pragma mark 获得大批量团购(封装一个内部方法)
- (void)getDealsWithParams:(NSDictionary *)params success:(DealsSuccessBlock)success error:(DealsErrorBlock)error
{
    [self requestWithUrl:@"v1/deal/find_deals" params:params block:^(id result, NSError *errorRequest) {
        //这个requestblock处理外面传进来的那两个block（block里面调用block）
        
        if (errorRequest) { //请求失败
            if (error) {
                error(errorRequest);
            }
        }else if (success){ //请求成功
            //取出result里面的数据，解析传递给successBlock
            NSArray *array = result[@"deals"];
            NSMutableArray *deals = [NSMutableArray array];
            for (NSDictionary *dict in array) {
                TGDeal *d = [[TGDeal alloc]init];
                [d setValues:dict];
                [deals addObject:d];
                
            }
            success(deals,[result[@"total_count"] intValue]);
            
        }
    }];
}

#pragma mark 封装大众点评请求方法
-(void)requestWithUrl:(NSString *)url params:(NSDictionary *)params block:(RequestBlock)block
{

    DPAPI *api = [DPAPI sharedDPAPI];
    DPRequest *request = [api requestWithURL:url params:params delegate:self];
    
    //一次请求对应一个block,利用_block字典key来区别不同的block
    [_blocks setValue:block forKey:request.description];
}

#pragma mark 大众点评的代理方法
-(void)request:(DPRequest *)request didFinishLoadingWithResult:(id)result
{
    //每一次请求成功都拿到这次对应的block
    RequestBlock block = _blocks[request.description];
    if (block) { //给block传递参数
        block(result,nil);
    }
}

-(void)request:(DPRequest *)request didFailWithError:(NSError *)error
{
    //每一次请求失败都拿到这次对应的block
    RequestBlock block = _blocks[request.description];
    if (block) { //给block传递参数
        block(nil,error);
    }
}

@end