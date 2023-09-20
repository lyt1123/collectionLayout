//
//  CirlcleItemViewController.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/29.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "CirlcleItemViewController.h"
#import "LYTCircleFlowLayout.h"

@interface CirlcleItemViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource>

@property (nonatomic,strong) UICollectionView   *collectionView;

@property (nonatomic,assign) NSInteger          dataCount;

@end

@implementation CirlcleItemViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    self.dataCount = 16;
    
    [self.collectionView reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    self.dataCount = 10;
    
    LYTCircleFlowLayout *layout = [[LYTCircleFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(50, 50);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 100, self.view.frame.size.width, 400) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor lightGrayColor];
    [collectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellID"];
//    collectionView.bounces = NO;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    
    CGFloat r = arc4random() % 255;
    
    CGFloat g = arc4random() % 255;
    
    CGFloat b = arc4random() % 255;
    
    cell.backgroundColor = [UIColor colorWithRed:r / 255  green:g / 255  blue:b / 255  alpha:1];
    cell.layer.masksToBounds = YES;
    cell.layer.cornerRadius = 25;
    return cell;
}

@end
