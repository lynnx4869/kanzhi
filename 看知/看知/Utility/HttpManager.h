//
//  HttpManager.h
//  看知
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"

@protocol HttpManagerDelegate <NSObject>

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject;
- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error;

@end

@interface HttpManager : NSObject

@property (nonatomic, weak) id<HttpManagerDelegate> delegate;

- (void)requestGet:(NSString *)url;
- (void)requestPost:(NSString *)url parameters:(NSDictionary *)dic;

@end
