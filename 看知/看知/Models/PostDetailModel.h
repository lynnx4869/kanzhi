//
//  PostDetailModel.h
//  看知
//
//  Created by qianfeng on 15/8/12.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostDetailModel : NSObject

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
