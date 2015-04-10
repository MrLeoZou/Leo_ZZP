

#import "TGCollectTool.h"
#import "TGDeal.h"

#define kFilePath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0] stringByAppendingPathComponent:@"collects.data"]

@interface TGCollectTool()
{
    NSMutableArray *_collectedDeals;
}
@end

@implementation TGCollectTool
single_implementation(TGCollectTool)

// 从文件中读取了2个团购对象
//

- (id)init
{
    if (self = [super init]) {
        // 1.加载沙盒中的收藏数据
        _collectedDeals = [NSKeyedUnarchiver unarchiveObjectWithFile:kFilePath];
        
        // 2.第一次没有收藏数据
        if (_collectedDeals == nil) {
            _collectedDeals = [NSMutableArray array];
        }
    }
    return self;
}

- (void)handleDeal:(TGDeal *)deal
{
    deal.collected = [_collectedDeals containsObject:deal];
}

//添加收藏
- (void)collectDeal:(TGDeal *)deal
{
    deal.collected = YES;
    [_collectedDeals insertObject:deal atIndex:0];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}

//取消收藏
- (void)uncollectDeal:(TGDeal *)deal
{
    deal.collected = NO;
    [_collectedDeals removeObject:deal];
    [NSKeyedArchiver archiveRootObject:_collectedDeals toFile:kFilePath];
}
@end