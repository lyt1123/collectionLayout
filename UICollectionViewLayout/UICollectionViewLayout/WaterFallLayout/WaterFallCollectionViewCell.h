//
//  WaterFallCollectionViewCell.h
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/28.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WaterFallCollectionViewCell : UICollectionViewCell

- (void)setItemDic:(NSDictionary *)dic;

+ (CGFloat)heightForItem:(NSDictionary *)dic itemWidth:(CGFloat)itemWidth;

@end

