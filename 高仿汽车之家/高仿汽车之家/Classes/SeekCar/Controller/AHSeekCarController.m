//
//  AHSeekCarController.m
//  高仿汽车之家
//
//  Created by apple on 15/4/4.
//  Copyright (c) 2015年 Leo_zzp. All rights reserved.
//

#import "AHSeekCarController.h"
#import "AHCar.h"
#import "AHCarGroup.h"

#define kIndexLabelW 60
#define kIndexLabelH 60

@interface AHSeekCarController ()<UITableViewDataSource,UITableViewDelegate>
///  顶部导航view
@property (weak, nonatomic) IBOutlet UIView *TopView;
///  底部选中线
@property (weak, nonatomic) IBOutlet UIView *lineView;

///  tableView
@property (weak, nonatomic) IBOutlet UITableView *AHtableView;
///  弹出索引文字label
@property(nonatomic ,weak)UILabel *indexLab;

///  存放模型数组
@property(nonatomic,strong)NSArray *carArr;

@end

@implementation AHSeekCarController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    self.AHtableView.delegate = self;
    self.AHtableView.dataSource = self;
    self.AHtableView.rowHeight = 60;
    //设置索引的颜色
    self.AHtableView.sectionIndexColor = [UIColor blueColor];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{

    return self.carArr.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    AHCarGroup *group = self.carArr[section];
    return group.list.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"seekCarCell"];
    
    //取出模型数据
    AHCarGroup *group = self.carArr[indexPath.section];
    AHCar *car = group.list[indexPath.row];
    
    //设置图片和标题
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:car.imgurl] placeholderImage:[UIImage imageNamed:@"dropdown_anim__0001"] options:SDWebImageRetryFailed | SDWebImageLowPriority];
    
    cell.textLabel.text = car.name;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //取出模型数据
    AHCarGroup *group = self.carArr[section];
    return group.letter;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{

    return 20;
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return [self.carArr valueForKeyPath:@"letter"];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{

//    NSLog(@"%@ -- %tu",title,index);
    //滚动到点击行
    [tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:index] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    //弹出对应的索引文字
    [self popIndexTitle:title];
    
    return index;
}

#pragma mark 弹出选中索引文字
- (void)popIndexTitle:(NSString *)title
{
    self.indexLab.frame = CGRectMake(self.view.bounds.size.width * 0.6 - kIndexLabelW * 0.5, self.view.bounds.size.height * 0.45 - kIndexLabelH * 0.5, kIndexLabelW, kIndexLabelH);
    [UIView animateWithDuration:0.25 animations:^{
        
        self.indexLab.hidden = NO;
        self.indexLab.text = title;
        
    } completion:^(BOOL finished) {
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.25 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            self.indexLab.hidden = YES;
            self.indexLab.text = nil;
        });
    }];
    
}

#pragma mark - lazy
- (NSArray *)carArr
{

    if (!_carArr) {
        _carArr = [AHCarGroup carArray];
    }
//    NSLog(@"%@ \n count=%ld",_carArr,_carArr.count);
    return _carArr;
}

-(UILabel *)indexLab
{

    if (!_indexLab) {
        UILabel *label = [[UILabel alloc]init];
     
        
        label.font = [UIFont systemFontOfSize:30];
        label.textColor = [UIColor blueColor];
        
        [self.view addSubview:label];
        _indexLab = label;
    }
    return _indexLab;
}

@end
