//
//  PostsCell.m
//  看知
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "PostsCell.h"
#import "MyUtil.h"

@implementation PostsCell

- (void)config:(PostsModel *)model{
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _titleBgView.backgroundColor = [MyUtil transNameForColor:model.name];
    _typeLabel.text = [MyUtil transNameForZh:model.name];
    _dateLabel.text = model.date;
    _countLabel.text = model.count;
    _detailLabel.text = model.excerpt;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
