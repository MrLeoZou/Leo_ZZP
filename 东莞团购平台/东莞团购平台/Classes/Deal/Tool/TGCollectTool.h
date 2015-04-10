//  专门用来处理收藏业务

#import <Foundation/Foundation.h>
#import "Singleton.h"

@class TGDeal;

@interface TGCollectTool : NSObject
single_interface(TGCollectTool)

// 获得所有的收藏信息,放在一个数组里
@property(nonatomic,strong,readonly)NSArray *collectedDeals;

// 处理团购是否收藏
- (void)handleDeal:(TGDeal *)deal;

// 添加收藏
- (void)collectDeal:(TGDeal *)deal;

// 取消收藏
- (void)uncollectDeal:(TGDeal *)deal;

@end
