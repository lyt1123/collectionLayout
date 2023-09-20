//
//  ScalItemViewController.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/28.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "ScalItemViewController.h"
#import "LYTScalItemFlowLayout.h"

@interface ScalItemViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView   *collectionView;

@end

@implementation ScalItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    LYTScalItemFlowLayout *layout = [[LYTScalItemFlowLayout alloc] init];
    layout.minimumLineSpacing = 20;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    CGFloat itemWidth = self.view.frame.size.width - 80;
    layout.itemSize = CGSizeMake(itemWidth, 200);
    layout.sectionInset = UIEdgeInsetsMake(0, 40, 0, 40);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 200) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    collectionView.bounces = NO;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 10;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    UILabel *label = [cell.contentView viewWithTag:10];
    
    if (!label)
    {
        label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:30];
        label.backgroundColor = [UIColor orangeColor];
        label.tag = 10;
        label.textAlignment = NSTextAlignmentCenter;
        [cell.contentView addSubview:label];
    }
    
    label.frame = CGRectMake(0, 0, cell.contentView.frame.size.width, cell.contentView.frame.size.height);
    label.text = [NSString stringWithFormat:@"%ld",(long)indexPath.item];
    
    return cell;
}

////拖动停止
//-(void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
//{
//    CGFloat index = scrollView.contentOffset.x  / self.itemWidth;
//
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:roundf(index) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//
//    NSLog(@"%f",index);
//}
//
//// 停止滑动
//- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
//{
//    CGFloat index = scrollView.contentOffset.x  / self.itemWidth;
//
//    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:roundf(index) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
//
//    NSLog(@"%f",index);
//}

@end
