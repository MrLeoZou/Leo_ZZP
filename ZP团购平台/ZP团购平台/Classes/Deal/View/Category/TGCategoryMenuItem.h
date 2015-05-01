//
//  TGCategoryMenuItem.h
//描述每一个分类底部菜单项Item ， 继承父类团购底部菜单项

#import "TGDealBottomMenuItem.h"

@class TGCategory;
@interface TGCategoryMenuItem : TGDealBottomMenuItem
// 需要显示的分类数据 使用TGCategory的模型数据
@property (nonatomic, strong) TGCategory *category;
@end
