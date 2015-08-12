//
//  HttpManager.m
//  看知
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

- (void)requestGet:(NSString *)url{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager GET:url
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             [_delegate success:operation response:responseObject];
         }
         failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             [_delegate failure:operation response:error];
         }];
}

- (void)requestPost:(NSString *)url parameters:(NSDictionary *)dic{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager POST:url
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              [_delegate success:operation response:responseObject];
          }
          failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              [_delegate failure:operation response:error];
          }];
}

@end
