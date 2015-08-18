//
//  PersonModel.h
//  看知
//
//  Created by qianfeng on 15/8/17.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonModel : NSObject

@property (nonatomic, strong, setter=setId:) NSString *personId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong, setter=setHash:) NSString *personHash;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *signature;

//发表
@property (nonatomic, strong) NSNumber *ask;
@property (nonatomic, strong) NSNumber *answer;
@property (nonatomic, strong) NSNumber *post;

//赞同
@property (nonatomic, strong) NSNumber *agree;
@property (nonatomic, strong) NSNumber *agreei;
@property (nonatomic, strong) NSString *agreeiratio;
@property (nonatomic, strong) NSNumber *agreeiw;
@property (nonatomic, strong) NSString *agreeiratiow;
@property (nonatomic, strong) NSNumber *ratio;

//关注
@property (nonatomic, strong) NSNumber *follower;
@property (nonatomic, strong) NSNumber *followee;
@property (nonatomic, strong) NSNumber *followeri;
@property (nonatomic, strong) NSString *followiratio;
@property (nonatomic, strong) NSNumber *followeriw;
@property (nonatomic, strong) NSString *followiratiow;

//感谢/收藏
@property (nonatomic, strong) NSNumber *thanks;
@property (nonatomic, strong) NSNumber *tratio;
@property (nonatomic, strong) NSNumber *fav;
@property (nonatomic, strong) NSNumber *fratio;
@property (nonatomic, strong) NSNumber *logs;

//高票答案数量
@property (nonatomic, strong) NSNumber *count10000;
@property (nonatomic, strong) NSNumber *count5000;
@property (nonatomic, strong) NSNumber *count2000;
@property (nonatomic, strong) NSNumber *count1000;
@property (nonatomic, strong) NSNumber *count500;
@property (nonatomic, strong) NSNumber *count200;
@property (nonatomic, strong) NSNumber *count100;

@end
