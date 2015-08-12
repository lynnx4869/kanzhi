//
//  PostDetailCell.h
//  看知
//
//  Created by qianfeng on 15/8/12.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostDetailModel.h"

@interface PostDetailCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *voteLabel;
@property (weak, nonatomic) IBOutlet UILabel *summaryLabel;

- (void)config:(PostDetailModel *)model;

@end
