//
//  PersonPostsCell.h
//  看知
//
//  Created by qianfeng on 15/8/19.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonDetailModel.h"

@interface PersonPostsCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIView *typeBgView;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *contextLabel;

- (void)config:(Topanswers *)model index:(NSInteger)index;

@end
