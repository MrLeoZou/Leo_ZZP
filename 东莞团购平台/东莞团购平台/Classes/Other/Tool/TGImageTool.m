//
//  TGImageTool.m
//

#import "TGImageTool.h"
#import "UIImageView+WebCache.h"

@implementation TGImageTool

///提供图片缓存下载
+ (void)downloadImage:(NSString *)url placeholder:(UIImage *)place imageView:(UIImageView *)imageView
{
    [imageView setImageWithURL:[NSURL URLWithString:url] placeholderImage:place options:SDWebImageLowPriority | SDWebImageRetryFailed];
}

///提供清空缓存图片的方法
+ (void)clear
{
    // 1.清除内存中的缓存图片
    [[SDImageCache sharedImageCache] clearMemory];
    
    // 2.取消所有的下载请求
    [[SDWebImageManager sharedManager] cancelAll];
}
@end
