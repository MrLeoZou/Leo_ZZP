//
//  TGInfoTextView.h
//

//#import "TGRoundRectView.h"
#import "TGRoundRectView.h"

@interface TGInfoTextView :TGRoundRectView
@property (weak, nonatomic) IBOutlet UIButton *titleView;
@property (weak, nonatomic) IBOutlet UILabel *contentView;

//提供给外界传入相关属性
@property (nonatomic, copy) NSString *icon; // 图标
@property (nonatomic, copy) NSString *title; // 标题
@property (nonatomic, copy) NSString *content; // 内容

//提供一个类方法，返回创建好的xib
+ (id)infoTextViewXib;

@end


