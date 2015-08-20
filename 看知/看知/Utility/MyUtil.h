//
//  MyUtil.h
//  看知
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "PersonModel.h"
#import "PersonDetailModel.h"

@interface MyUtil : NSObject

+ (NSString *)transNameForZh:(NSString *)name;
+ (UIColor *)transNameForColor:(NSString *)name;
+ (UIButton *)createNavBtn:(NSString *)title target:(id)target action:(SEL)action;
+ (void)warmNetCannotConnect;
+ (NSDate *)dateFromString:(NSString *)dateString;
+ (NSString *)stringFromDate:(NSDate *)date;
+ (NSString *)urlStringFromType:(NSString *)typeString;
+ (NSString *)countNumFromType:(NSString *)typeString person:(PersonModel *)model;
+ (NSString *)countNumFromType:(NSString *)typeString personDetail:(PersonDetailModel *)model;

@end
