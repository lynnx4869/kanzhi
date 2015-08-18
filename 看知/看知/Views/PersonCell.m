//
//  PersonCell.m
//  看知
//
//  Created by qianfeng on 15/8/17.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "PersonCell.h"
#import "UIImageView+WebCache.h"
#import "MyUtil.h"

@implementation PersonCell

- (void)config:(PersonModel *)model order:(NSString *)order type:(NSString *)typeString{
    _orderLabel.text = order;
    
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 25;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:model.avatar]];
    
    _nameLabel.text = model.name;
    _signatureLabel.text = model.signature;
    
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    [_bgView.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 25/255.0, 153/255.0, 255/255.0, 1 });
    [_bgView.layer setBorderColor:colorref];
    
    _typeLabel.text = typeString;
    _numLabel.text = [MyUtil countNumFromType:typeString person:model];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
