//
//  LYTCircleFlowLayout.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/29.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "LYTCircleFlowLayout.h"

@implementation LYTCircleFlowLayout
{
    NSMutableArray *_attributeArray;
}

- (void)prepareLayout
{
    [super prepareLayout];
    
    _attributeArray = [NSMutableArray array];
    
    CGFloat radius = MIN(self.collectionView.frame.size.width, self.collectionView.frame.size.height) / 2.0;
    
    CGPoint circleCenter = CGPointMake(self.collectionView.frame.size.width / 2.0, self.collectionView.frame.size.height / 2.0);
    
    NSInteger  count = [self.collectionView numberOfItemsInSection:0];
    
    for (int i = 0; i < count; i++)
    {
        UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:[NSIndexPath indexPathForItem:i inSection:0]];
        
        attribute.size = self.itemSize;
        
        // 计算每个item的中心
        CGFloat x = circleCenter.x+cos(2 * M_PI / count * i) * (radius - self.itemSize.width / 2);
        CGFloat y = circleCenter.y+sin(2 * M_PI / count * i) * (radius - self.itemSize.width / 2);
        
        attribute.center = CGPointMake(x, y);
        
        [_attributeArray addObject:attribute];
    }
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attributeArray;
}

- (CGSize)collectionViewContentSize
{
    return self.collectionView.frame.size;
}

@end
