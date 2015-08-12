//
//  PostsCell.h
//  看知
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostsModel.h"

@interface PostsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *titleBgView;
@property (weak, nonatomic) IBOutlet UILabel *typeLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *detailLabel;

- (void)config:(PostsModel *)model;

@end
