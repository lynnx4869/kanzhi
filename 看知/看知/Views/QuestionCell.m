//
//  QuestionCell.m
//  看知
//
//  Created by qianfeng on 15/8/14.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "QuestionCell.h"

@interface QuestionCell ()

@property (strong, nonatomic) UILabel *questionLabel;
@property (strong, nonatomic) UILabel *answerLabel;

@end

@implementation QuestionCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _questionLabel = [[UILabel alloc] init];
        _questionLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _questionLabel.font = [UIFont systemFontOfSize:15];
        _questionLabel.numberOfLines = 0;
        [_questionLabel setTextColor:[UIColor blackColor]];
        [self.contentView addSubview:_questionLabel];
        
        _answerLabel = [[UILabel alloc] init];
        _answerLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _answerLabel.font = [UIFont systemFontOfSize:15];
        _answerLabel.numberOfLines = 0;
        [_answerLabel setTextColor:[UIColor darkGrayColor]];
        [self.contentView addSubview:_answerLabel];
    }
    return self;
}

- (void)config:(QuestionModel *)model{
    _questionLabel.text = model.q;
    _answerLabel.text = model.a;
    
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect qFrame = [model.q boundingRectWithSize:CGSizeMake(self.contentView.bounds.size.width, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:dict
                                          context:nil];
    CGRect aFrame = [model.a boundingRectWithSize:CGSizeMake(self.contentView.bounds.size.width, CGFLOAT_MAX)
                                          options:NSStringDrawingUsesLineFragmentOrigin
                                       attributes:dict
                                          context:nil];
    
    NSDictionary *nameMap = @{@"questionLabel":_questionLabel, @"answerLabel":_answerLabel};
    NSArray *consQuestionHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[questionLabel]-10-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:nameMap];
    [self.contentView addConstraints:consQuestionHor];
    NSArray *consAnswerHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[answerLabel]-10-|"
                                                                       options:0
                                                                       metrics:nil
                                                                         views:nameMap];
    [self.contentView addConstraints:consAnswerHor];
    NSDictionary *heightDic = @{@"qH":@(qFrame.size.height), @"aH":@(aFrame.size.height)};
    NSArray *consVor = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-3-[questionLabel(qH)]-3-[answerLabel]-3-|"
                                                                     options:0
                                                                     metrics:heightDic
                                                                       views:nameMap];
    [self.contentView addConstraints:consVor];
}

- (NSInteger)heightForRow:(QuestionModel *)model{
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:15]};
    CGRect qFrame = [model.q boundingRectWithSize:CGSizeMake(self.contentView.bounds.size.width, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:dict
                                             context:nil];
    CGRect aFrame = [model.a boundingRectWithSize:CGSizeMake(self.contentView.bounds.size.width, CGFLOAT_MAX)
                                             options:NSStringDrawingUsesLineFragmentOrigin
                                          attributes:dict
                                             context:nil];
    return 27+qFrame.size.height+aFrame.size.height;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
