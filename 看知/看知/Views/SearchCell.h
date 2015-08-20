//
//  SearchCell.h
//  看知
//
//  Created by qianfeng on 15/8/20.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PersonModel.h"
#import "PersonDetailModel.h"

@interface SearchCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *signatureLabel;

- (void)config:(PersonModel *)model;
- (void)configDetail:(PersonDetailModel *)model;

@end
