//
//  WaterFallViewController.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/28.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "WaterFallViewController.h"
#import "LYTWaterFallFlowLayout.h"
#import "WaterFallCollectionViewCell.h"

@interface WaterFallViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
LYTWaterFallFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray   *dataArray;

@end

@implementation WaterFallViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [NSMutableArray array];
    NSString *titleStr = @"全国政协十三届三次会议圆满完成各项议程27日胜利闭幕。委员们带";
    
    for (int i = 0; i < 16; i++)
    {
        NSString *imgStr = [NSString stringWithFormat:@"%d.JPG",i + 1];
        int index = arc4random()%titleStr.length;
        NSString *title = [titleStr substringWithRange:NSMakeRange(index, titleStr.length - index)];
        [self.dataArray addObject:@{@"img":imgStr,@"text":title}];
    }
    
    LYTWaterFallFlowLayout *layout = [[LYTWaterFallFlowLayout alloc] init];
    layout.columnCount = 2;
    layout.columnSpace = 10;
    layout.rowSpace = 10;
    layout.headHeight = 40;
    layout.delegate = self;
    layout.collectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 600) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerClass:[WaterFallCollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID"];
    collectionView.alwaysBounceVertical = YES;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    WaterFallCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell setItemDic:self.dataArray[indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID" forIndexPath:indexPath];
    
    headView.backgroundColor = [UIColor redColor];
    
    return headView;
}

- (CGFloat)waterflowLayout:(LYTWaterFallFlowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth
{
    return [WaterFallCollectionViewCell heightForItem:self.dataArray[indexPath.item] itemWidth:itemWidth];
}

@end
