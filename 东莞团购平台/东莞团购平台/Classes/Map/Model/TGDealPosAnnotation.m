

#import "TGDealPosAnnotation.h"
#import "TGMetaDataTool.h"
#import "TGDeal.h"

@implementation TGDealPosAnnotation

//内部设置大头针图标属性
- (void)setDeal:(TGDeal *)deal
{
    _deal = deal;
    
    for (NSString *c in deal.categories) {
        //1.调用元数据工具类方法，获得分类的icon
        NSString *icon = [[TGMetaDataTool sharedTGMetaDataTool] iconWithCategoryName:c];
 
        if (icon) {
            //2.把plist里面的图片名称截串，就得到地图模块使用的分类图片
            _icon = [icon stringByReplacingOccurrencesOfString:@"filter_" withString:@""];
            
            break;
        }
    }
}
@end
