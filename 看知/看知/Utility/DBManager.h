//
//  DBManager.h
//  看知
//
//  Created by qianfeng on 15/8/17.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PostDetailModel.h"

@interface DBManager : NSObject

+ (DBManager *)shareManager;

- (BOOL)isHadCollected:(PostDetailModel *)model;
- (void)collectPost:(PostDetailModel *)model;
- (NSArray *)queryAllCollects;
- (void)deleteCollect:(PostDetailModel *)model;

@end
