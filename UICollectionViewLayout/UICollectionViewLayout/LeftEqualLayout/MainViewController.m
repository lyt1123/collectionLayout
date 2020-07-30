//
//  MainViewController.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/27.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "MainViewController.h"
#import "LYTLeftEqualFlowLayout.h"
#import "MyCollectionViewCell.h"

@interface MainViewController ()<
UICollectionViewDelegate,
UICollectionViewDataSource,
LYTLeftEqualFlowLayoutDelegate>

@property (nonatomic,strong) UICollectionView *collectionView;

@property (nonatomic,strong) NSMutableArray          *dataArray;


@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.dataArray = [@[@"全额侮辱",@"注册是从v",@"啊速度却发挥其违法气温去违反企鹅王发机器配件群文件付钱而非权威发全微分",@"123",@"在",@"而不去二个如果",@"手动发布手动发布",@"而其认为",@"主线程v这v",@"发吧首付吧"] mutableCopy];
    
    LYTLeftEqualFlowLayout *layout = [[LYTLeftEqualFlowLayout alloc] init];
    layout.itemHeight = 40;
    layout.itemSpace = 10;
    layout.lineSpace = 10;
    layout.headHeight = 40;
    layout.delegate = self;
    layout.collectionInsets = UIEdgeInsetsMake(10, 10, 10, 10);
    
    UICollectionView *collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 600) collectionViewLayout:layout];
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.backgroundColor = [UIColor whiteColor];
    [collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([MyCollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:@"cellID"];
    [collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID"];
    collectionView.alwaysBounceVertical = YES;
    self.collectionView = collectionView;
    [self.view addSubview:collectionView];
}


//- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
//{
//    return 4;
//}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MyCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellID" forIndexPath:indexPath];
    [cell setContent:self.dataArray[indexPath.item]];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionReusableView *headView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"headID" forIndexPath:indexPath];
    
    headView.backgroundColor = indexPath.section == 0?[UIColor redColor]:[UIColor cyanColor];
    
    return headView;
}

//- (void)collectionView:(UICollectionView *)collectionView moveItemAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath
//{
//    NSString  *index = self.dataArray[sourceIndexPath.item];
//    [self.dataArray removeObject:index];
//    [self.dataArray insertObject:index atIndex:destinationIndexPath.item];
//}


- (CGFloat)widthForItemIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight
{
    NSString *text = self.dataArray[indexPath.item];
    return [self widthWithText:text];
}

- (CGFloat)widthWithText:(NSString *)text
{
    NSDictionary *attr = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};

    CGRect rect = [text boundingRectWithSize:CGSizeMake(HUGE, 40)
                                           options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                        attributes:attr context:nil];
    return rect.size.width + 32;
}


@end
