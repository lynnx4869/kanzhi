//
//  MainTabBarViewController.m
//  看知
//
//  Created by qianfeng on 15/8/10.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "MainTabBarViewController.h"
#import "HomeViewController.h"
#import "UserDynamicViewController.h"
#import "SettingViewController.h"

@interface MainTabBarViewController ()

@end

@implementation MainTabBarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSArray *ctrlArray = @[@"HomeViewController", @"UserDynamicViewController", @"SettingViewController"];
    NSArray *titleArray = @[@"首页", @"用户动态", @"设置"];
    NSArray *imageArray = @[@"Homepage", @"UserInfo", @"Settings"];
    NSArray *selectedArray = @[@"HomeFilled", @"UserInfoFilled", @"SettingsFilled"];
    NSMutableArray *navArray = [NSMutableArray array];
    
    for(int i = 0; i < ctrlArray.count; i++){
        Class cls = NSClassFromString(ctrlArray[i]);
        UIViewController *vc = [[cls alloc] init];
        vc.tabBarItem.title = titleArray[i];
        vc.tabBarItem.image = [[UIImage imageNamed:imageArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        vc.tabBarItem.selectedImage = [[UIImage imageNamed:selectedArray[i]] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
        UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:vc];
        [navArray addObject:nav];
    }
    
    self.viewControllers = [NSArray arrayWithArray:navArray];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
