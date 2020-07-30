//
//  MyCollectionViewCell.m
//  UICollectionViewLayout
//
//  Created by 刘云天 on 2020/5/27.
//  Copyright © 2020 刘云天. All rights reserved.
//

#import "MyCollectionViewCell.h"

@interface MyCollectionViewCell ()

@property (weak, nonatomic) IBOutlet UIView *contentVIew;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation MyCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.contentVIew.layer.cornerRadius = 6;
    self.contentVIew.layer.masksToBounds = YES;
}

- (void)setContent:(NSString *)content
{
    self.contentLabel.text = content;
}

@end
