//
//  ZhihuInterfaceViewController.h
//  看知
//
//  Created by qianfeng on 15/8/12.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PostDetailModel.h"

@interface ZhihuInterfaceViewController : UIViewController

@property (nonatomic, assign) NSInteger curIndex;
@property (nonatomic, strong) NSArray *modelArray;

@property (nonatomic, assign) BOOL isOnlyOne;

@end
