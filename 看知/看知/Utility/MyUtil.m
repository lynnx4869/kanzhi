//
//  MyUtil.m
//  看知
//
//  Created by qianfeng on 15/8/11.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "MyUtil.h"
#import "Const.h"


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

+ (void)warmNetCannotConnect{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"提示"
                                                        message:@"无网络连接"
                                                       delegate:self
                                              cancelButtonTitle:@"确认"
                                              otherButtonTitles:nil];
    [alertView show];
}

+ (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter dateFromString:dateString];
}

+ (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setTimeZone:[NSTimeZone localTimeZone]];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:date];
}

+ (NSString *)urlStringFromType:(NSString *)typeString{
    if([typeString isEqualToString:@"提问"]){
        return lAskUrl;
    }else if([typeString isEqualToString:@"回答"]){
        return lAnswerUrl;
    }else if([typeString isEqualToString:@"专栏"]){
        return lPostUrl;
    }else if([typeString isEqualToString:@"赞同数"]){
        return lAgreeUrl;
    }else if([typeString isEqualToString:@"1日增加"]){
        return lAgreeiUrl;
    }else if([typeString isEqualToString:@"1日增幅"]){
        return lAgreeiratioUrl;
    }else if([typeString isEqualToString:@"7日增加"]){
        return lAgreeiwUrl;
    }else if([typeString isEqualToString:@"7日增幅"]){
        return lAgreeiratiowUrl;
    }else if([typeString isEqualToString:@"平均赞同"]){
        return lRatioUrl;
    }else if([typeString isEqualToString:@"被关注数"]){
        return lFollowerUrl;
    }else if([typeString isEqualToString:@"关注数"]){
        return lFolloweeUrl;
    }else if([typeString isEqualToString:@"1日增加"]){
        return lFolloweriUrl;
    }else if([typeString isEqualToString:@"1日增幅"]){
        return lFollowiratioUrl;
    }else if([typeString isEqualToString:@"7日增加"]){
        return lFolloweriwUrl;
    }else if([typeString isEqualToString:@"7日增幅"]){
        return lFollowiratiowUrl;
    }else if([typeString isEqualToString:@"感谢数"]){
        return lThanksUrl;
    }else if([typeString isEqualToString:@"感谢/赞同比"]){
        return lTratioUrl;
    }else if([typeString isEqualToString:@"收藏数"]){
        return lFavUrl;
    }else if([typeString isEqualToString:@"收藏/赞同比"]){
        return lFratioUrl;
    }else if([typeString isEqualToString:@"公共编辑"]){
        return lLogsUrl;
    }else if([typeString isEqualToString:@">10000"]){
        return lCount10000Url;
    }else if([typeString isEqualToString:@">5000"]){
        return lCount5000Url;
    }else if([typeString isEqualToString:@">2000"]){
        return lCount2000Url;
    }else if([typeString isEqualToString:@">1000"]){
        return lCount1000Url;
    }else if([typeString isEqualToString:@">500"]){
        return lCount500Url;
    }else if([typeString isEqualToString:@">200"]){
        return lCount200Url;
    }else if([typeString isEqualToString:@">100"]){
        return lCount100Url;
    }else{
        return @"";
    }
}

+ (NSString *)countNumFromType:(NSString *)typeString person:(PersonModel *)model{
    if([typeString isEqualToString:@"提问"]){
        return [NSString stringWithFormat:@"%@", model.ask];
    }else if([typeString isEqualToString:@"回答"]){
        return [NSString stringWithFormat:@"%@", model.answer];
    }else if([typeString isEqualToString:@"专栏"]){
        return [NSString stringWithFormat:@"%@", model.post];
    }else if([typeString isEqualToString:@"赞同数"]){
        return [NSString stringWithFormat:@"%@", model.agree];
    }else if([typeString isEqualToString:@"1日增加"]){
        return [NSString stringWithFormat:@"%@", model.agreei];
    }else if([typeString isEqualToString:@"1日增幅"]){
        return model.agreeiratio;
    }else if([typeString isEqualToString:@"7日增加"]){
        return [NSString stringWithFormat:@"%@", model.agreeiw];
    }else if([typeString isEqualToString:@"7日增幅"]){
        return model.agreeiratiow;
    }else if([typeString isEqualToString:@"平均赞同"]){
        return [NSString stringWithFormat:@"%@", model.ratio];
    }else if([typeString isEqualToString:@"被关注数"]){
        return [NSString stringWithFormat:@"%@", model.follower];
    }else if([typeString isEqualToString:@"关注数"]){
        return [NSString stringWithFormat:@"%@", model.followee];
    }else if([typeString isEqualToString:@"1日增加"]){
        return [NSString stringWithFormat:@"%@", model.followeri];
    }else if([typeString isEqualToString:@"1日增幅"]){
        return model.followiratio;
    }else if([typeString isEqualToString:@"7日增加"]){
        return [NSString stringWithFormat:@"%@", model.followeriw];
    }else if([typeString isEqualToString:@"7日增幅"]){
        return model.followiratiow;
    }else if([typeString isEqualToString:@"感谢数"]){
        return [NSString stringWithFormat:@"%@", model.thanks];
    }else if([typeString isEqualToString:@"感谢/赞同比"]){
        return [NSString stringWithFormat:@"%@", model.tratio];
    }else if([typeString isEqualToString:@"收藏数"]){
        return [NSString stringWithFormat:@"%@", model.fav];
    }else if([typeString isEqualToString:@"收藏/赞同比"]){
        return [NSString stringWithFormat:@"%@", model.fratio];
    }else if([typeString isEqualToString:@"公共编辑"]){
        return [NSString stringWithFormat:@"%@", model.logs];
    }else if([typeString isEqualToString:@">10000"]){
        return [NSString stringWithFormat:@"%@", model.count10000];
    }else if([typeString isEqualToString:@">5000"]){
        return [NSString stringWithFormat:@"%@", model.count5000];
    }else if([typeString isEqualToString:@">2000"]){
        return [NSString stringWithFormat:@"%@", model.count2000];
    }else if([typeString isEqualToString:@">1000"]){
        return [NSString stringWithFormat:@"%@", model.count1000];
    }else if([typeString isEqualToString:@">500"]){
        return [NSString stringWithFormat:@"%@", model.count500];
    }else if([typeString isEqualToString:@">200"]){
        return [NSString stringWithFormat:@"%@", model.count200];
    }else if([typeString isEqualToString:@">100"]){
        return [NSString stringWithFormat:@"%@", model.count100];
    }else{
        return @"";
    }
}

@end
