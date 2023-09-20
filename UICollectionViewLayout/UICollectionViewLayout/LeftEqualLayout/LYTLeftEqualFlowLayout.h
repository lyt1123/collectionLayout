//
//  LYTLeftEqualFlowLayout.h
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/27.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LYTLeftEqualFlowLayoutDelegate <NSObject>

//item宽度
- (CGFloat)widthForItemIndexPath:(NSIndexPath *)indexPath itemHeight:(CGFloat)itemHeight;

- (void)getContentSize:(CGSize)contentSize;

@end

@interface LYTLeftEqualFlowLayout : UICollectionViewFlowLayout

// item高度
@property (nonatomic,assign) CGFloat itemHeight;
// item间距
@property (nonatomic,assign) CGFloat itemSpace;
// 行间距
@property (nonatomic,assign) CGFloat lineSpace;

@property (nonatomic,assign) CGFloat headHeight;

@property (nonatomic,assign) UIEdgeInsets collectionInsets;

@property (nonatomic,assign) id<LYTLeftEqualFlowLayoutDelegate>delegate;

@end
