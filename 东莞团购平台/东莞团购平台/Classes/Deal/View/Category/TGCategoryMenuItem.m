//
//  TGCategoryMenuItem.m
//

#import "TGCategoryMenuItem.h"
#import "TGCategory.h"

#define kTitleRatio 0.5

@implementation TGCategoryMenuItem

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 1.文字
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        self.titleLabel.font = [UIFont systemFontOfSize:14];

        // 2.图片
        self.imageView.contentMode = UIViewContentModeCenter;

    }
    return self;
}

//调用父类方法，给它传递自己的子分类名称
- (NSArray *)titles
{
    return _category.subcategories;
}

//View拿到模型数据，设置自己的属性
- (void)setCategory:(TGCategory *)category
{
    _category = category;
    
    // 1.图标
    [self setImage:[UIImage imageNamed:category.icon] forState:UIControlStateNormal];
    
    // 2.标题
    [self setTitle:category.name forState:UIControlStateNormal];
}

#pragma mark 设置按钮标题的frame
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGFloat titleHeight = contentRect.size.height * kTitleRatio;
    CGFloat titleY = contentRect.size.height - titleHeight;
    return CGRectMake(0, titleY, contentRect.size.width,  titleHeight);
}
#pragma mark 设置按钮图片的frame
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    return CGRectMake(0, 0, contentRect.size.width, contentRect.size.height * (1 - kTitleRatio));
}

@end
