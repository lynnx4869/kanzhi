//
//  PersonPostsCell.m
//  看知
//
//  Created by qianfeng on 15/8/19.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "PersonPostsCell.h"

@implementation PersonPostsCell

- (void)config:(Topanswers *)model index:(NSInteger)index{
    _typeBgView.layer.masksToBounds = YES;
    _typeBgView.layer.cornerRadius = 10;
    [_typeBgView.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 170/255.0, 170/255.0, 170/255.0, 1 });
    [_typeBgView.layer setBorderColor:colorref];
    
    _countLabel.text = model.agree;
    _dateLabel.text = [model.date substringToIndex:9];
    _contextLabel.text = [NSString stringWithFormat:@"%d、%@", index, model.title];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
