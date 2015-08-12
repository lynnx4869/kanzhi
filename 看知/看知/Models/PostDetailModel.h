//
//  PostDetailModel.h
//  看知
//
//  Created by qianfeng on 15/8/12.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostDetailModel : NSObject
/*
 "title": "怎么看「周立波被批道德绑架，逼从小被抛弃的姑娘认亲」这件事？",
 "time": "2015-08-09 14:59:56",
 "summary": "这是当事人姑娘写的微博（微博里的图片）节目组和周立波在没有调查清楚的情况下强行安排这一出母女相认的戏码，真的是一点也没有考虑当事人和养父母的心情。以及，上面有个回答说姑娘和养父母也自私的，我只想说：呵呵",
 "questionid": "34347281",
 "answerid": "58418108",
 "authorname": "甫嫣",
 "authorhash": "9a9b71605b228104e8cdc9085fd291f1",
 "avatar": "http://pic1.zhimg.com/aafea53849e223bf04888ab91b9077c0_l.jpg",
 "vote": "3228"
 */
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *summary;
@property (nonatomic, strong) NSString *questionid;
@property (nonatomic, strong) NSString *answerid;
@property (nonatomic, strong) NSString *authorname;
@property (nonatomic, strong) NSString *authorhash;
@property (nonatomic, strong) NSString *avatar;
@property (nonatomic, strong) NSString *vote;

@end
