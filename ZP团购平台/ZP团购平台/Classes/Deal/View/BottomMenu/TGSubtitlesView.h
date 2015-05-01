//
//  TGSubtitlesView.h
//  用来显示所有的子标题

#import <UIKit/UIKit.h>

@interface TGSubtitlesView : UIImageView
@property (nonatomic, strong) NSArray *titles; // 所有的底部子标题文字（例：广西菜、火锅..）

@property(nonatomic,copy)NSString *bottomTitle; //底部菜单被选中的标题（例：美食、购物..）

//使用block把子菜单的标题传出去,外界自己设置,set方法
@property(nonatomic,copy) void(^setTitleBlock)(NSString *title);

//使用block把子菜单的标题传进来,get方法
@property(nonatomic,copy) NSString*(^getTitleBlock)();

// 通过动画显示出来
- (void)show;
// 通过动画隐藏
- (void)hide;
@end