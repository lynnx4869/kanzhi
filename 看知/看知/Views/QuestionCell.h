//
//  QuestionCell.h
//  看知
//
//  Created by qianfeng on 15/8/14.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QuestionModel.h"

@interface QuestionCell : UITableViewCell

- (void)config:(QuestionModel *)model;
- (NSInteger)heightForRow:(QuestionModel *)model;

@end
