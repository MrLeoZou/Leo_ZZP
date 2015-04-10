//
//  TGSubtitlesView.m
//

#import "TGSubtitlesView.h"
#import "UIImage+ZP.h"
#import "TGMetaDataTool.h"

#define kTitleW 70
#define kTitleH 30

#pragma mark 自定义一个内部类，处理选中按钮时的背景
@interface SubtitleBtn : UIButton
@end

@implementation SubtitleBtn
- (void)drawRect:(CGRect)rect
{
    if (self.selected) {
        CGRect frame = self.titleLabel.frame;
        frame.origin.x -= 5;
        frame.size.width += 10;
        frame.origin.y -= 5;
        frame.size.height += 10;
        [[UIImage resizedImage:@"slider_filter_bg_active.png"] drawInRect:frame];
    }
}
@end

@interface TGSubtitlesView()
{

    UIButton *_selectedBtn;
}
@end

@implementation TGSubtitlesView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.autoresizingMask = UIViewAutoresizingFlexibleWidth;
        self.image = [UIImage resizedImage:@"bg_subfilter_other.png"];
        
//        self.backgroundColor = [UIColor yellowColor];
        
        //
        self.userInteractionEnabled = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

- (void)setTitles:(NSArray *)titles
{
    //在每个底部子菜单项前面添加--"全部"
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:kAll];
    [array addObjectsFromArray:titles];
    _titles = array;
    
    NSUInteger count = _titles.count;
    // 设置按钮的文字
    for (int i = 0; i<count; i++) {
        // 1.取出i位置对应的按钮
        UIButton *btn = nil;
        if (i >= self.subviews.count) { // 按钮个数不够
            btn = [SubtitleBtn buttonWithType:UIButtonTypeCustom];
            [btn addTarget:self action:@selector(titleClick:) forControlEvents:UIControlEventTouchUpInside];
            [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
//            [btn setBackgroundImage:[UIImage imageNamed:@"slider_filter_bg_active.png"] forState:UIControlStateSelected];
            [self addSubview:btn];
        } else {
            btn = self.subviews[i];
        }
        
        // 2.设置按钮文字
        btn.hidden = NO;
        [btn setTitle:_titles[i] forState:UIControlStateNormal];
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        
        //3.如果当前选中文字跟记录选中文字相同，设置为选中状态
        if(_getTitleBlock){
            NSString *current = _getTitleBlock();
            
            //如果选中的是bottomTitle，就选中第0个按钮（全部）
            if ([current isEqualToString:_bottomTitle] && i == 0 ) {
                btn.selected = YES;
                _selectedBtn = btn;
            }else{
                btn.selected = [_titles[i] isEqualToString:current];
            }
            if(btn.selected){
                _selectedBtn = btn;
            }
        }else{
        
            btn.selected = NO;
        }
    }
    
    //4. 隐藏后面多余的按钮
    for (NSUInteger i = count; i<self.subviews.count; i++) {
        UIButton *btn = self.subviews[i];
        btn.hidden = YES;
    }
}

#pragma mark 子菜单小标题按钮点击事件
- (void)titleClick:(UIButton *)btn
{

    //1.控制选中状态
    _selectedBtn.selected = NO;
    btn.selected = YES;
    _selectedBtn = btn;
    
    //2.设置当前选中分类的文字
    if (_setTitleBlock) {
        NSString *title = [btn titleForState:UIControlStateNormal];
        if ([title isEqualToString:kAll]) { //选择了 "全部"
            
            title = _bottomTitle; //更改为底部菜单被选中的标题（例：美食、购物..）
        }
        //选择了其他
        _setTitleBlock(title);
    }
//    MyLog(@"%@--%@",[TGMetaDataTool sharedTGMetaDataTool].currentCategory,[TGMetaDataTool sharedTGMetaDataTool].currentDistrict);
}

// 控件本身的宽高发生改变的时候就会调用
- (void)layoutSubviews
{
    // 一定要调用super
    [super layoutSubviews];
    
    int columns = self.frame.size.width / kTitleW;
    for (int i = 0; i<_titles.count; i++) {
        UIButton *btn = self.subviews[i];
        
        // 设置位置
        CGFloat x = i % columns * kTitleW;
        CGFloat y = i / columns * kTitleH;
        btn.frame = CGRectMake(x, y, kTitleW, kTitleH);
    }
    
    [UIView animateWithDuration:1.0 animations:^{
        NSInteger rows = (_titles.count + columns - 1) / columns;
        CGRect frame = self.frame;
        frame.size.height = rows * kTitleH;
        self.frame = frame;
    }];
}

- (void)show
{
    [self layoutSubviews];
  
    self.transform = CGAffineTransformMakeTranslation(0, -kBottomMenuItemH);
    self.alpha = 0;
    [UIView animateWithDuration:kDuration animations:^{
        self.transform = CGAffineTransformIdentity;
        self.alpha = 1;
    }];
}

- (void)hide
{
    [UIView animateWithDuration:kDuration animations:^{
        self.transform = CGAffineTransformMakeTranslation(0, -kBottomMenuItemH);
        self.alpha = 0;
    } completion:^(BOOL finished) {
        self.transform = CGAffineTransformIdentity;
        
        //完全移除时候，把高度清零
        CGRect f = self.frame;
        f.size.height = 0;
        self.frame = f;
        
        [self removeFromSuperview];
        self.alpha = 1;
    }];
}
@end
