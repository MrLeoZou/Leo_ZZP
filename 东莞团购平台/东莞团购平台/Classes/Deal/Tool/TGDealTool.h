

#import <Foundation/Foundation.h>
#import "Singleton.h"
#import <MapKit/MapKit.h>

@class TGDeal;
/// deals里面装的都是模型数据--用于加载所有团购数据
typedef void (^DealsSuccessBlock)(NSArray *deals , int totalCount);
typedef void (^DealsErrorBlock)(NSError *error);

/// deals里面装的都是模型数据--用于指定的团购数据
typedef void (^OneDealSuccessBlock)(TGDeal *deal);
typedef void (^OneDealErrorBlock)(NSError *error);

@interface TGDealTool : NSObject
single_interface(TGDealTool)

///工具类分装方法，发送请求,加载指定页数的所有团购数据
-(void)dealsWithPage:(int)page success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;

///工具类分装方法，发送请求,加载指定id的详细团购数据
-(void)dealWithID:(NSString *)ID success:(OneDealSuccessBlock)success error:(OneDealErrorBlock)error;

///工具类分装方法，加载周边团购信息
-(void)dealWithPos:(CLLocationCoordinate2D)pos success:(DealsSuccessBlock)success error:(DealsErrorBlock)error;
@end