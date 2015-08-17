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
    
    UIActivityIndicatorView *indeicatorView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
    indeicatorView.backgroundColor = [UIColor clearColor];
    indeicatorView.color = [UIColor whiteColor];
    indeicatorView.center = CGPointMake(_headWallImageView.bounds.size.width/2, _headWallImageView.bounds.size.height/2);
    [_headWallImageView addSubview:indeicatorView];
    _headWallImageView.backgroundColor = [UIColor grayColor];
    [indeicatorView startAnimating];
    [_headWallImageView sd_setImageWithURL:[NSURL URLWithString:model.pic]
                                 completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
                                     dispatch_queue_t mainQueue = dispatch_get_main_queue();
                                     dispatch_async(mainQueue, ^{
                                         [indeicatorView stopAnimating];
                                         indeicatorView.hidden = YES;
                                     });
                                 }];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
