//
//  PersonDetailModel.m
//  看知
//
//  Created by qianfeng on 15/8/18.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "PersonDetailModel.h"

@implementation PersonDetailModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _trendArray = [NSMutableArray array];
        _topanswersArray = [NSMutableArray array];
    }
    return self;
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

@implementation Trend

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end

@implementation Topanswers

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    
}

@end
