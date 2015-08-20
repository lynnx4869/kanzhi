//
//  DetailMeansCell.m
//  看知
//
//  Created by qianfeng on 15/8/20.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "DetailMeansCell.h"

@implementation DetailMeansCell

- (void)config:(NSArray *)array{
    _titleLabel.text = array[0];
    _countLabel.text = array[1];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
