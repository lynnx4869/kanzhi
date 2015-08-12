//
//  PostsPicCell.m
//  看知
//
//  Created by qianfeng on 15/8/12.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "PostsPicCell.h"
#import "MyUtil.h"
#import "UIImageView+WebCache.h"

@implementation PostsPicCell

- (void)config:(PostsModel *)model{
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _typeLabel.text = [MyUtil transNameForZh:model.name];
    
    NSString *dateStr = model.date;
    NSArray *dateArray = [dateStr componentsSeparatedByString:@"-"];
    NSMutableArray *resArray = [NSMutableArray array];
    for(int i = 0; i < dateArray.count; i++){
        NSString *str = dateArray[i];
        if([str characterAtIndex:0] == '0'){
            NSRange range = NSMakeRange(0, 1);
            str = [str stringByReplacingCharactersInRange:range withString:@""];
        }
        [resArray addObject:str];
    }
    _dateLabel.text = [NSString stringWithFormat:@"%@月%@日", resArray[1], resArray[2]];
    
    _countLabel.text = model.count;
    [_headWallImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]
                          placeholderImage:[UIImage imageNamed:@"ImageDefault"]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
