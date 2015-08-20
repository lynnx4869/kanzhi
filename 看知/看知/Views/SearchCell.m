//
//  SearchCell.m
//  看知
//
//  Created by qianfeng on 15/8/20.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "SearchCell.h"
#import "UIImageView+WebCache.h"

@implementation SearchCell

- (void)config:(PersonModel *)model{
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 25;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    _nameLabel.text = model.name;
    _signatureLabel.text = model.signature;
}

- (void)configDetail:(PersonDetailModel *)model{
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 25;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    _nameLabel.text = model.name;
    _signatureLabel.text = model.signature;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
