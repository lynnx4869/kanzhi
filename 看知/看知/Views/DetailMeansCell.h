//
//  DetailMeansCell.h
//  看知
//
//  Created by qianfeng on 15/8/20.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailMeansCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *countLabel;

- (void)config:(NSArray *)array;

@end
