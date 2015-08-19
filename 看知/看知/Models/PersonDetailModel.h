//
//  PersonDetailModel.h
//  看知
//
//  Created by qianfeng on 15/8/18.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PersonDetailModel : NSObject

@property (nonatomic, strong, setter=setHash:) NSString *personHash;

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *signature;
@property (nonatomic, strong, setter=setDescription:) NSString *personDescription;

//发表
@property (nonatomic, strong) NSString *ask;
@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *post;

//赞同
@property (nonatomic, strong) NSString *agree;
@property (nonatomic, strong) NSString *agreei;
@property (nonatomic, strong) NSString *agreeiratio;
@property (nonatomic, strong) NSString *agreeiw;
@property (nonatomic, strong) NSString *agreeiratiow;
@property (nonatomic, strong) NSString *ratio;

//关注
@property (nonatomic, strong) NSString *follower;
@property (nonatomic, strong) NSString *followee;
@property (nonatomic, strong) NSString *followeri;
@property (nonatomic, strong) NSString *followiratio;
@property (nonatomic, strong) NSString *followeriw;
@property (nonatomic, strong) NSString *followiratiow;

//感谢/收藏
@property (nonatomic, strong) NSString *thanks;
@property (nonatomic, strong) NSString *tratio;
@property (nonatomic, strong) NSString *fav;
@property (nonatomic, strong) NSString *fratio;
@property (nonatomic, strong) NSString *logs;

//高票答案数量
@property (nonatomic, strong) NSString *count10000;
@property (nonatomic, strong) NSString *count5000;
@property (nonatomic, strong) NSString *count2000;
@property (nonatomic, strong) NSString *count1000;
@property (nonatomic, strong) NSString *count500;
@property (nonatomic, strong) NSString *count200;
@property (nonatomic, strong) NSString *count100;

//高票答案占比
@property (nonatomic, strong) NSString *mostvote;
@property (nonatomic, strong) NSString *mostvotepercent;
@property (nonatomic, strong) NSString *mostvote5;
@property (nonatomic, strong) NSString *mostvote5percent;
@property (nonatomic, strong) NSString *mostvote10;
@property (nonatomic, strong) NSString *mostvote10percent;

//star
@property (nonatomic, strong) NSString *answerrank; //回答
@property (nonatomic, strong) NSString *agreerank; //赞同
@property (nonatomic, strong) NSString *ratiorank; //平均赞同
@property (nonatomic, strong) NSString *followerrank; //关注
@property (nonatomic, strong) NSString *favrank; //收藏
@property (nonatomic, strong) NSString *count1000rank; //千赞回答
@property (nonatomic, strong) NSString *count100rank; //百赞回答

@property (nonatomic, strong) NSMutableArray *trendArray;
@property (nonatomic, strong) NSMutableArray *topanswersArray;

@end

@interface Trend : NSObject

@property (nonatomic, strong) NSString *answer;
@property (nonatomic, strong) NSString *agree;
@property (nonatomic, strong) NSString *follower;
@property (nonatomic, strong) NSString *date;

@end

@interface Topanswers : NSObject

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *link;
@property (nonatomic, strong) NSString *agree;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *ispost;

@end
