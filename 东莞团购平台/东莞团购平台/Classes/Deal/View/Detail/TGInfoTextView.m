//
//  TGInfoTextView.m
//

#import "TGInfoTextView.h"

@implementation TGInfoTextView

+ (id)infoTextViewXib
{
    return [[NSBundle mainBundle] loadNibNamed:@"TGInfoTextView" owner:nil options:nil][0];
}

- (void)setIcon:(NSString *)icon
{
    _icon = icon;
    
    [_titleView setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    
    [_titleView setTitle:title forState:UIControlStateNormal];
}

- (void)setContent:(NSString *)content
{
    _content = content;
    
    // 1.设置label的文字
    _contentView.text = content;
    
    // 2.计算文字的高度
    CGFloat textH = [content sizeWithFont:_contentView.font constrainedToSize:CGSizeMake(_contentView.frame.size.width, MAXFLOAT) lineBreakMode:_contentView.lineBreakMode].height + 20;
    CGRect contentF = _contentView.frame;
    CGFloat contentDeltaH = textH - contentF.size.height;
    contentF.size.height = textH;
    _contentView.frame = contentF;
    
    // 3.调整整体的高度
    CGRect selfF = self.frame;
    selfF.size.height += contentDeltaH;
    self.frame = selfF;
}
@end
