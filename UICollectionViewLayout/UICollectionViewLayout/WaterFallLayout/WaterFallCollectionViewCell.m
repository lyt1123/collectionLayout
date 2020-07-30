//
//  WaterFallCollectionViewCell.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/28.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "WaterFallCollectionViewCell.h"
#import <Masonry.h>

@interface WaterFallCollectionViewCell ()

@property (nonatomic,strong) UIImageView *img;

@property (nonatomic,strong) UILabel *titleLabel;

@end

@implementation WaterFallCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.contentView.backgroundColor = [UIColor colorWithRed:243/255.0 green:243/255.0 blue:243/255.0 alpha:1];
        
        UIImageView *imgView = [[UIImageView alloc] init];
        self.img = imgView;
        [self.contentView addSubview:imgView];
        
        [imgView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-50);
        }];
        
        UILabel *label = [[UILabel alloc] init];
        label.numberOfLines = 2;
        label.font = [UIFont systemFontOfSize:15];
        self.titleLabel = label;
        [self.contentView addSubview:label];
        
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(imgView.mas_bottom).offset(10);
        }];
    }
    return self;
}

- (void)setItemDic:(NSDictionary *)dic
{
    self.img.image = [UIImage imageNamed:dic[@"img"]];
    
    self.titleLabel.text = dic[@"text"];
}

 + (CGFloat)heightForItem:(NSDictionary *)dic itemWidth:(CGFloat)itemWidth
{
    UIImage *image = [UIImage imageNamed:dic[@"img"]];
    CGFloat itemHeight =  itemWidth / image.size.width * image.size.height;
    return itemHeight + 50;
}

@end
