//
//  TGImageTool.h
//

#import <Foundation/Foundation.h>

@interface TGImageTool : NSObject
///根据图片URL下载网络图片
+ (void)downloadImage:(NSString *)url placeholder:(UIImage *)place imageView:(UIImageView *)imageView;

///清理图片缓存
+ (void)clear;
@end
