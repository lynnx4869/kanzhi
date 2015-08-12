//
//  PostDetailCell.m
//  看知
//
//  Created by qianfeng on 15/8/12.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "PostDetailCell.h"
#import "UIImageView+WebCache.h"

@implementation PostDetailCell

- (void)config:(PostDetailModel *)model{
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _titleLabel.text = model.title;
    
    _headImageView.layer.masksToBounds = YES;
    _headImageView.layer.cornerRadius = 15;
    [_headImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]
                      placeholderImage:[UIImage imageNamed:@"ImageDefault"]];
    
    _nameLabel.text = model.authorname;
    
    _voteLabel.layer.masksToBounds = YES;
    _voteLabel.layer.cornerRadius = 3;
    _voteLabel.text = model.vote;
    
    _summaryLabel.text = model.summary;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
