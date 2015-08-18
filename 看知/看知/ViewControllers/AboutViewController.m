//
//  AboutViewController.m
//  看知
//
//  Created by qianfeng on 15/8/14.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    [self createNav];
    [self createContext];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    self.navigationItem.title = @"关于";
}

- (void)createContext{
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"看知精选集"];
    titleLabel.font = [UIFont systemFontOfSize:25];
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:titleLabel];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [UIColor lightGrayColor];
    lineView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:lineView];
    
    UILabel *descLabel = [[UILabel alloc] init];
    [descLabel setText:@"给你另一双眼睛"];
    descLabel.font = [UIFont systemFontOfSize:15];
    descLabel.textAlignment = NSTextAlignmentCenter;
    descLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:descLabel];
    
    NSDictionary *nameMap = @{@"titleLabel":titleLabel, @"lineView":lineView, @"descLabel":descLabel};
    
    NSArray *consTitleHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[titleLabel]-0-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:nameMap];
    [self.view addConstraints:consTitleHor];
    NSArray *consLineHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-15-[lineView]-15-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:nameMap];
    [self.view addConstraints:consLineHor];
    NSArray *consDescHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[descLabel]-0-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:nameMap];
    [self.view addConstraints:consDescHor];
    NSArray *consVor = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-70-[titleLabel(40)]-0-[lineView(1)]-0-[descLabel(30)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:nameMap];
    [self.view addConstraints:consVor];
}

@end
