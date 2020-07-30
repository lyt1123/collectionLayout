//
//  LYTWaterFallFlowLayout.h
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/28.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LYTWaterFallFlowLayout;
@protocol LYTWaterFallFlowLayoutDelegate <NSObject>

- (CGFloat)waterflowLayout:(LYTWaterFallFlowLayout *)waterflowLayout heightForItemAtIndexPath:(NSIndexPath *)indexPath itemWidth:(CGFloat)itemWidth;

@end

@interface LYTWaterFallFlowLayout : UICollectionViewFlowLayout

// 多少列
@property (nonatomic,assign) NSInteger columnCount;
// 行间距
@property (nonatomic,assign) CGFloat rowSpace;
// 列间距
@property (nonatomic,assign) CGFloat columnSpace;

@property (nonatomic,assign) CGFloat headHeight;

@property (nonatomic,assign) UIEdgeInsets collectionInsets;

@property (nonatomic,assign) id<LYTWaterFallFlowLayoutDelegate>delegate;

@end
