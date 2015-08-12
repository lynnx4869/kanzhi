//
//  PostsModel.h
//  看知
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PostsModel : NSObject

@property (nonatomic, strong, setter=setId:) NSString *postId;
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *date;
@property (nonatomic, strong) NSString *pic;
@property (nonatomic, strong) NSString *publishtime;
@property (nonatomic, strong) NSString *count;
@property (nonatomic, strong) NSString *excerpt;

@end
