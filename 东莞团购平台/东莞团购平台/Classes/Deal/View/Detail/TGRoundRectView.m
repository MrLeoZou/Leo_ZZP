//
//  TGRoundRectView.m
//

#import "TGRoundRectView.h"

#import "UIImage+ZP.h"
@implementation TGRoundRectView

- (void)drawRect:(CGRect)rect
{
    [[UIImage resizedImage:@"bg_order_cell.png"] drawInRect:rect];
}

@end
