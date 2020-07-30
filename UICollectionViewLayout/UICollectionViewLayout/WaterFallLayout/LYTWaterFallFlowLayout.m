//
//  LYTWaterFallFlowLayout.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/28.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "LYTWaterFallFlowLayout.h"

@interface LYTWaterFallFlowLayout ()

/** 存放每一列的最大Y值(整体高度) */
@property (nonatomic, strong) NSMutableArray *maxYs;

@property (nonatomic, strong) NSMutableArray *attrsArray;

@end

@implementation LYTWaterFallFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];
    
    self.maxYs = [NSMutableArray array];
    
    for (NSUInteger i = 0; i < self.columnCount; i++)
    {
        [self.maxYs addObject:@(self.collectionInsets.top)];
    }
    
    self.attrsArray = [NSMutableArray array];
    
    if (self.headHeight > 0)
    {
        UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:[NSIndexPath indexPathForItem:0 inSection:0]];
        attrs.frame = CGRectMake(self.collectionInsets.left, self.collectionInsets.top, self.collectionView.frame.size.width - 2 * self.collectionInsets.left, self.headHeight);
        [self.attrsArray addObject:attrs];
    }
    
    NSInteger count = [self.collectionView numberOfItemsInSection:0];
    for (NSUInteger i = 0; i < count; i++)
    {
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:i inSection:0];
        UICollectionViewLayoutAttributes *attrs = [self layoutAttributesForItemAtIndexPath:indexPath];
        [self.attrsArray addObject:attrs];
    }
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 创建属性
    UICollectionViewLayoutAttributes *attrs = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    
    // item(cell)的宽度
    CGFloat itemW = (self.collectionView.bounds.size.width - self.collectionInsets.left - self.collectionInsets.right - (self.columnCount - 1) * self.columnSpace) / self.columnCount;
    
    CGFloat itemH =  0;
    if ([self.delegate respondsToSelector:@selector(waterflowLayout:heightForItemAtIndexPath:itemWidth:)])
    {
       itemH = [self.delegate waterflowLayout:self heightForItemAtIndexPath:indexPath itemWidth:itemW];
    }
    
    // 设置位置和尺寸
    CGFloat minMaxY = [self.maxYs[0] doubleValue]; // 最短那一列 的 最大Y值
    int minColumn = 0; // 最短那一列 的 列号
    for (int i = 1; i < self.columnCount; i++)
    {
        CGFloat maxY = [self.maxYs[i] doubleValue];
        if (maxY < minMaxY) {
            minMaxY = maxY;
            minColumn = i;
        }
    }
    
    CGFloat itemX = self.collectionInsets.left + minColumn * (itemW + self.columnSpace);
    CGRect frame = CGRectMake(itemX, minMaxY , itemW, itemH);
    
    // 累加这一列的最大Y值
    self.maxYs[minColumn] = @(CGRectGetMaxY(frame) + self.rowSpace);

    frame.origin.y += self.headHeight;
    attrs.frame = frame;

    return attrs;
}

- (CGSize)collectionViewContentSize
{
    double longMaxY = 0;
    if (self.maxYs.count) {
        longMaxY = [self.maxYs[0] doubleValue]; // 最长那一列 的 最大Y值
        for (int i = 1; i < self.columnCount; i++) {
            CGFloat maxY = [self.maxYs[i] doubleValue];
            if (maxY > longMaxY) {
                longMaxY = maxY;
            }
        }
        
        // 累加底部的间距
        longMaxY += self.collectionInsets.bottom + self.headHeight;
    }
    return CGSizeMake(0, longMaxY);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attrsArray;
}

// 在出现新的cell时重新布局并调用preparelayout方法
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

- (NSInteger)columnCount
{
    if (_columnCount){
        return _columnCount;
    }
    return 2;
}

- (CGFloat)columnSpace
{
    if (_columnSpace){
        return _columnSpace;
    }
    return 10;
}

- (CGFloat)rowSpace
{
    if (_rowSpace){
        return _rowSpace;
    }
    return 10;
}

@end
