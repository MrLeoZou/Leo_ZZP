//
//  AHHeadView.m
//  高仿汽车之家
//
//  Created by apple on 15/4/6.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHHeadView.h"
#import "AHPlayer.h"
#import "NSArray+Log.h"
#import <UIImageView+AFNetworking.h>

#define imgCount 6

@interface AHHeadView ()

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIPageControl *pageControl;
@property (nonatomic, strong) NSTimer *timer;

///  接收play模型
@property(nonatomic,strong)NSArray *playerArr;

///  存放创建好的imageView
@property(nonatomic,strong)NSMutableArray *imageViewArr;

@end

@implementation AHHeadView

+ (instancetype)headerView
{
    return [[[UINib nibWithNibName:@"AHHeadView" bundle:nil] instantiateWithOwner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    
    //定义属性常量
    CGFloat imgW = [UIScreen mainScreen].bounds.size.width;
    CGFloat imgH = 155;
    CGFloat imgY = 0;
    
    // 动态创建5个UIImageView加到UIScrollView中。
    for (int i = 0; i < imgCount; i++) {
        // 创建一个UIImageView
        UIImageView *imgView = [[UIImageView alloc] init];
        
        // 设置frame
        CGFloat imgX = i * imgW;
        imgView.frame = CGRectMake(imgX, imgY, imgW, imgH);
        imgView.userInteractionEnabled = YES;
        imgView.tag = i;
        
        //添加手势，监听点击
        UITapGestureRecognizer *ges = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(imgOnClick:)];
        [imgView addGestureRecognizer:ges];
        
        // 把UIImageView加到self.scrollView中
        [self.scrollView addSubview:imgView];
        [self.imageViewArr addObject:imgView];
    }
    //
    //    NSLog(@"%@ %ld",self.imageViewArr,self.imageViewArr.count);
    
    
    //加载player模型数据
    __weak typeof(self)weakSelf = self;
    [AHPlayer playersWithURLString:@"http://app.api.autohome.com.cn/autov4.6/news/newslist-a2-pm1-v4.6.6-c0-nt0-p1-s30-l0.html" complection:^(NSArray *players) {
        //
        weakSelf.playerArr = players;
    }];
    
    
    // 设置UIScrollView的内容的大小
    self.scrollView.contentSize = CGSizeMake(imgCount * imgW, 0);
    
    // 实现分页
    self.scrollView.pagingEnabled = YES;
    
    // 隐藏水平滚动条
    self.scrollView.showsHorizontalScrollIndicator = NO;
    
    // 启动一个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
    
    // 解决拖动其他控件的时候, 图片轮播期不动了
    // 获取当前线程的消息循环
    NSRunLoop *runLoop = [NSRunLoop currentRunLoop];
    //把self.timer加进去
    [runLoop addTimer:self.timer forMode:NSRunLoopCommonModes];
}

#pragma mark 点击图片轮播器上面的图片事件
- (void)imgOnClick:(UIGestureRecognizer *)ges
{
//    NSLog(@"%tu",ges.view.tag);
    //根据点击图片的tag从模型数组中取出对应模型的ID
    NSInteger index = ges.view.tag;
    NSInteger ID = [self.playerArr[index] id];
    
    //拼接URL
    NSString *urlStr = [NSString stringWithFormat:@"http://cont.app.autohome.com.cn/autov4.6/content/news/newscontent-n%tu-t0.json",ID];
    
    //发出通知，通知baseVC，跳转到对应的详情界面
    [[NSNotificationCenter defaultCenter] postNotificationName:ZP_IMAGEDIDCLICK_NOTIFICATION object:self userInfo:@{@"urlStr":urlStr}];
}

///  拦截图片加载完成，记在完成再去设置轮播器上面的图片
-(void)setPlayerArr:(NSArray *)playerArr
{
    _playerArr = playerArr;
    //设置图片
    for (int i = 0; i < self.imageViewArr.count; i++) {
        UIImageView *imageV = self.imageViewArr[i];
#warning 需要判断，有图片才设置
        if (self.playerArr.count != 0) {
            
            AHPlayer *player = self.playerArr[i];
            [imageV setImageWithURL:[NSURL URLWithString:player.imgurl] placeholderImage:[UIImage imageNamed:@"img_nopic_day"]];
        }
    }
}

// 显示下一张图片
- (void)nextImage
{
    //1. 获取当前页数
    NSInteger page = self.pageControl.currentPage;
    // 判断是否滚动到了最后一页
    if(page == self.pageControl.numberOfPages - 1){
        page = 0;
    } else {
        page++;
    }
    
    // 2. 根据当前要显示的页数, 设置UIScrollView的contentOffset偏移的x值
    CGFloat offsetX = page * self.scrollView.frame.size.width;
    
    [self.scrollView setContentOffset: CGPointMake(offsetX, 0) animated:YES];
    
}

// UIScrollView的代理方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // 获取当前scrollView的contentOffset
    CGPoint point = scrollView.contentOffset;
    CGFloat scrollW = scrollView.frame.size.width;
    int page = (point.x + (scrollW * 0.5)) /scrollW;
    self.pageControl.currentPage = page;
}

// 即将开始拖拽的时候执行
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 1.停止计时器, 计时器一旦停止以后, 就不能重用了.
    [self.timer invalidate];
    // 所以self.timer也没有保留对上一个计时器的引用了。
    self.timer = nil;
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 启动一个计时器
    self.timer = [NSTimer scheduledTimerWithTimeInterval:2 target:self selector:@selector(nextImage) userInfo:nil repeats:YES];
}

///  lazy
-(NSMutableArray *)imageViewArr
{
    
    if (_imageViewArr == nil) {
        _imageViewArr = [NSMutableArray array];
    }
    return _imageViewArr;
}

@end
