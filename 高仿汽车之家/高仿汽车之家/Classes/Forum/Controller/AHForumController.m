//
//  AHForumController.m
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHForumController.h"
#import "AHForumChannel.h"
#import "AHChannelLabel.h"
#import "AHForumCollectionCell.h"

@interface AHForumController ()<AHChannelLabelDelegate>
///  显示内容的view
@property (weak, nonatomic) IBOutlet UICollectionView *ContentView;
///  顶部导航view
@property (weak, nonatomic) IBOutlet UIScrollView *TopScrollView;
////  collectionView的流水布局
@property (weak, nonatomic) IBOutlet UICollectionViewFlowLayout *flowLayout;
///  存放频道模型
@property(nonatomic,strong)NSArray *channels;
///  当前选中的索引
@property (nonatomic, assign) NSUInteger currentIndex;

@end

@implementation AHForumController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //隐藏顶部导航条
    self.navigationController.navigationBarHidden = YES;
    
    [self setupChannel];
}

///  拦截view即将重新显示，设置导航栏隐藏
- (void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}

///  view完成布局的时候调用
-(void)viewDidLayoutSubviews
{
    
    [super viewDidLayoutSubviews];
    //设置布局参数
    //为什么不在init方法中设置，因为当前控制器是通过storyboard创建的，不会走init方法
    [self setLayout];
}

- (void)setLayout
{
//    self.flowLayout.itemSize = CGSizeMake(self.ContentView.frame.size.width, self.ContentView.frame.size.height - 64);
    self.flowLayout.itemSize = self.ContentView.frame.size;
    
    //设置同一列cell的间距
    self.flowLayout.minimumLineSpacing = 0;
    //设置同一行cell的间距
    self.flowLayout.minimumInteritemSpacing = 0;
    //设置滚动方向
    self.flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    //支持分页
    self.ContentView.pagingEnabled = YES;
}


#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    ///  通过storyboard创建自定义cell，item
    AHForumCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ContentCell" forIndexPath:indexPath];
    
    cell.backgroundColor = [UIColor whiteColor];
    
    // 检测子控制器,如果有创建过，才需要添加
    if (![self.childViewControllers containsObject:cell.contentVc]) {
        [self addChildViewController:(UIViewController *)cell.contentVc];
    }
    cell.forumChannel = self.channels[indexPath.item];
    
    return cell;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    
    int index = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    self.currentIndex = index;
    
    // 标签居中
    AHChannelLabel *label = self.TopScrollView.subviews[index];
    
    CGFloat offset = label.center.x - self.TopScrollView.bounds.size.width * 0.5;
    CGFloat maxOffset = self.TopScrollView.contentSize.width - label.bounds.size.width - self.TopScrollView.bounds.size.width;
    if (offset < 0) {
        offset = 0;
    } else if (offset > maxOffset) {
        offset = maxOffset + label.bounds.size.width;
    }
    
    [self.TopScrollView setContentOffset:CGPointMake(offset, 0) animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    // 判断方向
    AHChannelLabel *currentLabel = self.TopScrollView.subviews[self.currentIndex];
    AHChannelLabel *nextLabel = nil;
    for (NSIndexPath *indexPath in [self.ContentView indexPathsForVisibleItems]) {
        if (indexPath.item != self.currentIndex) {
            nextLabel = self.TopScrollView.subviews[indexPath.item];
            break;
        }
    }
    
    if (nextLabel == nil) {
        return;
    }
    
    // 计算偏移量
    CGFloat nextOffset = ABS((scrollView.contentOffset.x / scrollView.frame.size.width) - self.currentIndex);
    CGFloat currentOffset = 1 - nextOffset;
    
    // 设置动画
    currentLabel.scale = currentOffset;
    nextLabel.scale = nextOffset;
}

#pragma mark - ChannelLabelDelegate
- (void)channelLabelDidSelected:(AHChannelLabel *)label {
    //    NSLog(@"%@ %tu", label.topic, label.tag);
    
    self.currentIndex = label.tag;
    NSIndexPath *indexPath = [NSIndexPath indexPathForItem:label.tag inSection:0];
    [self.ContentView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:NO];
}

///  设置频道
- (void)setupChannel {
    // 禁止自动调整滚动视图边距
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    CGFloat margin = 8;
    __block CGFloat x = margin;
    CGFloat h = self.TopScrollView.bounds.size.height;
    
    [self.channels enumerateObjectsUsingBlock:^(AHChannel *channel, NSUInteger idx, BOOL *stop) {
        AHChannelLabel *label = [AHChannelLabel channelLabelWithTitle:channel];
        label.delegate = self;
        label.tag = idx;
        
        CGSize s = label.bounds.size;
        
        label.frame = CGRectMake(x, 0, s.width, h);
        
        x += s.width;
        
        [self.TopScrollView addSubview:label];
    }];
    //    NSLog(@"%@ - %@ -- %ld",self.TopScrollView,self.TopScrollView.subviews,self.TopScrollView.subviews.count);
    self.TopScrollView.contentSize = CGSizeMake(x + margin, h);
    
    // 选中第一项，并且记录当前标签
    AHChannelLabel *label = self.TopScrollView.subviews[0];
    label.scale = 1;
    
    self.currentIndex = 0;
}

// MARK: - 懒加载
- (NSArray *)channels {
    if (_channels == nil) {
        _channels = [AHForumChannel channel];
    }
//        NSLog(@"%@",_channels);
    return _channels;
}

@end
