//
//  LYTLeftEqualFlowLayout.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/27.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "LYTLeftEqualFlowLayout.h"

@interface LYTLeftEqualFlowLayout ()

@property (nonatomic,assign) CGFloat currentLeft;

@property (nonatomic,assign) CGFloat currentTop;

@property (nonatomic,strong) NSMutableArray *attrubutesArray;

@end

@implementation LYTLeftEqualFlowLayout

- (void)prepareLayout
{
    [super prepareLayout];

    // 初始化首个item位置
    _currentTop = _collectionInsets.top;
    _currentLeft = _collectionInsets.left;

    _attrubutesArray = [NSMutableArray array];

    NSInteger sectionCount = [self.collectionView numberOfSections];

    for (int i = 0; i < sectionCount; i++) {
        
        // 判断是否有header
        if (_headHeight)
        {
             UICollectionViewLayoutAttributes *headerAttr = [self layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader atIndexPath:[NSIndexPath indexPathForItem:0 inSection:i]];
            [_attrubutesArray addObject:headerAttr];
        }

        NSInteger itemCount = [self.collectionView numberOfItemsInSection:i];

        for (int j = 0; j < itemCount; j++) {

            NSIndexPath *indexPath = [NSIndexPath indexPathForItem:j inSection:i];

            UICollectionViewLayoutAttributes *attributes = [self layoutAttributesForItemAtIndexPath:indexPath];

            [_attrubutesArray addObject:attributes];
        }
    }
    
//    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPressAction:)];
//    [self.collectionView addGestureRecognizer:longPress];
}

//- (void)longPressAction:(UILongPressGestureRecognizer *)longPress
//{
//    switch (longPress.state) {
//        case UIGestureRecognizerStateBegan:
//        {
//            NSIndexPath *indexPath = [self.collectionView indexPathForItemAtPoint:[longPress locationInView:self.collectionView]];
//            if (indexPath == nil)
//            {
//                break;
//            }
//            [self.collectionView beginInteractiveMovementForItemAtIndexPath:indexPath];
//        }
//            break;
//        case UIGestureRecognizerStateChanged:
//            [self.collectionView updateInteractiveMovementTargetPosition:[longPress locationInView:self.collectionView]];
//            break;
//        case UIGestureRecognizerStateEnded:
//            [self.collectionView endInteractiveMovement];
//            break;
//        default:
//            [self.collectionView cancelInteractiveMovement];
//            break;
//    }
//}



- (UICollectionViewLayoutAttributes *)layoutAttributesForSupplementaryViewOfKind:(NSString *)elementKind atIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewLayoutAttributes *headAtt = [UICollectionViewLayoutAttributes layoutAttributesForSupplementaryViewOfKind:UICollectionElementKindSectionHeader withIndexPath:indexPath];

    CGFloat contentWidth = self.collectionView.frame.size.width - _collectionInsets.left - _collectionInsets.right;

    if (headAtt.indexPath.section > 0)
    {
        _currentLeft = _collectionInsets.left;
        _currentTop += (_lineSpace + _itemHeight);
    }

    headAtt.frame = CGRectMake(_currentLeft, _currentTop, contentWidth, _headHeight);

    _currentLeft = _collectionInsets.left;
    _currentTop += (_headHeight + _lineSpace);

    return headAtt;
}

- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    // 通过indexpath创建一个item属性
    UICollectionViewLayoutAttributes *itemAtt = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];

    CGFloat contentWidth = self.collectionView.frame.size.width - _collectionInsets.left - _collectionInsets.right;
    
    // 计算item宽度
    CGFloat itemW = 0;
    if ([self.delegate respondsToSelector:@selector(widthForItemIndexPath:itemHeight:)]){
        
        itemW = [self.delegate widthForItemIndexPath:indexPath itemHeight:_itemHeight];
        
        if (itemW > contentWidth){
            itemW = contentWidth;
        }
    }else
    {
        NSLog(@"需要实现widthForItemIndexPath代理方法");
    }
    
    CGRect frame;
    frame.size = CGSizeMake(itemW, _itemHeight);
    
    // 判断位置
    if(_currentLeft + itemW > contentWidth + self.collectionInsets.right){
        _currentLeft = _collectionInsets.left;
        _currentTop += (_lineSpace + _itemHeight);
    }
    
    frame.origin = CGPointMake(_currentLeft, _currentTop);
    itemAtt.frame = frame;
    
    _currentLeft += (itemW + _itemSpace);

    return itemAtt;
}

- (CGSize)collectionViewContentSize
{
    return CGSizeMake(self.collectionView.contentSize.width, _currentTop + _itemHeight + _collectionInsets.bottom);
}

- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect
{
    return _attrubutesArray;
}

// 在出现新的cell时重新布局并调用preparelayout方法
-(BOOL)shouldInvalidateLayoutForBoundsChange:(CGRect)newBounds
{
    return YES;
}

@end
