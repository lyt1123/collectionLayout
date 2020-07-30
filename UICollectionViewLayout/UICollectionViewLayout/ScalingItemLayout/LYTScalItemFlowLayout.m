//
//  LYTScalItemFlowLayout.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/28.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "LYTScalItemFlowLayout.h"

@implementation LYTScalItemFlowLayout

-(NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSArray *arr = [[super layoutAttributesForElementsInRect:rect] copy];
    //屏幕中线
    CGFloat centerX = self.collectionView.contentOffset.x + self.collectionView.bounds.size.width/2.0f;
    
    for (UICollectionViewLayoutAttributes *attributes in arr)
    {
        CGFloat distance = fabs(attributes.center.x - centerX);
        
        //移动的距离和屏幕宽度的的比例
        CGFloat apartScale = distance/self.collectionView.bounds.size.width;
        
        CGFloat scale = fabs(cos(apartScale * M_PI/3));
        
        //设置cell的缩放 按照余弦函数曲线 越居中越趋近于1
        attributes.transform = CGAffineTransformMakeScale(1.0, scale);
    }
    return arr;
}

-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

/*
  *这个方法的返回时就决定了collectionView停止滚动时的偏移量
  */
- (CGPoint)targetContentOffsetForProposedContentOffset:(CGPoint)proposedContentOffset withScrollingVelocity:(CGPoint)velocity
{
    //计算出最终显示的矩形框
    CGRect rect;
    rect.origin.y = 0;
    rect.origin.x = proposedContentOffset.x;
    rect.size = self.collectionView.frame.size;

    //这里建议调用super,因为用self会把里面for循环的transform再算一遍,但我们仅仅想拿到中心点X,super中已经算好中心点X的值了
    NSArray *array =[[super layoutAttributesForElementsInRect:rect] copy];
    //计算collectionView最中心点的X的值
    /*
          proposedContentOffset 目的,原本
          拿到最后这个偏移量的X,最后这些cell,距离最后中心点的位置
          */
    CGFloat centerX = proposedContentOffset.x + self.collectionView.frame.size.width * 0.5;
    //存放最小的间距值
    CGFloat minDelta = MAXFLOAT;
    for (UICollectionViewLayoutAttributes *attrs in array)
    {
        if (ABS(minDelta) > ABS(attrs.center.x - centerX))
        {
            minDelta = attrs.center.x - centerX;
        }
    }
    //修改原有的偏移量
    proposedContentOffset.x +=minDelta;

    return proposedContentOffset;
}

@end
