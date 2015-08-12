//
//  MyUtil.m
//  看知
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "MyUtil.h"


@implementation MyUtil

+ (NSString *)transNameForZh:(NSString *)name{
    if([name isEqualToString:@"archive"]){
        return @"历史精华";
    }else if([name isEqualToString:@"recent"]){
        return @"近期热门";
    } if([name isEqualToString:@"yesterday"]){
        return @"昨日最新";
    }
    return @"";
}

+ (UIColor *)transNameForColor:(NSString *)name{
    if([name isEqualToString:@"archive"]){
        return [UIColor colorWithRed:30/255.0 green:169/255.0 blue:134/255.0 alpha:1];
    }else if([name isEqualToString:@"recent"]){
        return [UIColor colorWithRed:60/255.0 green:145/255.0 blue:215/255.0 alpha:1];
    } if([name isEqualToString:@"yesterday"]){
        return [UIColor colorWithRed:249/255.0 green:98/255.0 blue:88/255.0 alpha:1];
    }
    return [UIColor whiteColor];
}

+ (UIButton *)createNavBtn:(NSString *)title target:(id)target action:(SEL)action{
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(0, 0, 70, 25);
    
    if(title){
        [btn setTitle:title forState:UIControlStateNormal];
    }
    
    btn.titleLabel.font = [UIFont systemFontOfSize:13];
    btn.backgroundColor = [UIColor clearColor];
    
    if(target && action){
        [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    }
    
    [btn.layer setMasksToBounds:YES];
    [btn.layer setCornerRadius:5.0];
    [btn.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 1, 1, 1, 1 });
    [btn.layer setBorderColor:colorref];
    
    return btn;
}

@end
