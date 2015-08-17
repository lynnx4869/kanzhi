//
//  SuggestionViewController.m
//  看知
//
//  Created by qianfeng on 15/8/14.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "SuggestionViewController.h"

@interface SuggestionViewController ()

@property (nonatomic, strong) UIView *bgView;

@end

@implementation SuggestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    [self createNav];
    [self createViews];
    [self createBgView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    self.navigationItem.title = @"意见反馈";
    
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc]
//                                 initWithImage:[[UIImage imageNamed:@"navBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
//                                 style:UIBarButtonItemStyleDone
//                                 target:self
//                                 action:@selector(goBack)];
//    self.navigationItem.backBarButtonItem = backItem;
}

- (void)createViews{
    _bgView = [[UIView alloc] init];
    _bgView.backgroundColor = [UIColor whiteColor];
    _bgView.layer.masksToBounds = YES;
    _bgView.layer.cornerRadius = 10;
    _bgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_bgView];
    
    UIButton *submitBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [submitBtn setBackgroundColor:[UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0]];
    [submitBtn setTitle:@"提交" forState:UIControlStateNormal];
    [submitBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    submitBtn.layer.masksToBounds = YES;
    submitBtn.layer.cornerRadius = 8;
    submitBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:submitBtn];
    
    NSDictionary *nameDic = @{@"bgView" : _bgView,
                              @"submitBtn" : submitBtn};
    NSArray *consBgViewHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-30-[bgView]-30-|"
                                                                   options:NSLayoutFormatAlignmentMask
                                                                   metrics:nil
                                                                     views:nameDic];
    [self.view addConstraints:consBgViewHor];
    NSArray *consSubmitBtnHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-100-[submitBtn]-100-|"
                                                                     options:NSLayoutFormatAlignmentMask
                                                                     metrics:nil
                                                                       views:nameDic];
    [self.view addConstraints:consSubmitBtnHor];
    NSArray *consViewVor = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-84-[bgView(240)]-30-[submitBtn(40)]"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:nameDic];
    [self.view addConstraints:consViewVor];
}

- (void)createBgView{
    UILabel *titleLabel = [[UILabel alloc] init];
    [titleLabel setText:@"您的意见将帮助我们更好地改进产品和服务"];
    titleLabel.font = [UIFont systemFontOfSize:12];
    titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:titleLabel];
    
    UIView *lineView1 = [[UIView alloc] init];
    lineView1.backgroundColor = [UIColor grayColor];
    lineView1.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:lineView1];
    
    UITextView *contextField = [[UITextView alloc] init];
    contextField.font = [UIFont systemFontOfSize:12];
    contextField.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:contextField];
    
    UIView *lineView2 = [[UIView alloc] init];
    lineView2.backgroundColor = [UIColor grayColor];
    lineView2.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:lineView2];
    
    UILabel *nameLabel = [[UILabel alloc] init];
    [nameLabel setText:@"联系人"];
    nameLabel.font = [UIFont systemFontOfSize:12];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:nameLabel];
    
    UITextField *nameField = [[UITextField alloc] init];
    nameField.placeholder = @"请填写联系人";
    nameField.font = [UIFont systemFontOfSize:12];
    nameField.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:nameField];
    
    UIView *lineView3 = [[UIView alloc] init];
    lineView3.backgroundColor = [UIColor grayColor];
    lineView3.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:lineView3];
    
    UILabel *phoneLabel = [[UILabel alloc] init];
    [phoneLabel setText:@"联系方式"];
    phoneLabel.font = [UIFont systemFontOfSize:12];
    phoneLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:phoneLabel];
    
    UITextField *phoneField = [[UITextField alloc] init];
    phoneField.placeholder = @"请填写联系方式";
    phoneField.font = [UIFont systemFontOfSize:12];
    phoneField.translatesAutoresizingMaskIntoConstraints = NO;
    [_bgView addSubview:phoneField];
    
    NSDictionary *nameMap = @{@"titleLabel" : titleLabel, @"lineView1" : lineView1, @"contextField" : contextField, @"lineView2" : lineView2, @"nameLabel" : nameLabel, @"nameField" : nameField, @"lineView3" : lineView3, @"phoneLabel" : phoneLabel, @"phoneField" :phoneField};
    
    NSArray *consTitleHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-3-[titleLabel]-3-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
    [_bgView addConstraints:consTitleHor];
    NSArray *consLineView1Hor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[lineView1]-0-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
    [_bgView addConstraints:consLineView1Hor];
    NSArray *consContextHor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-5-[contextField]-5-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
    [_bgView addConstraints:consContextHor];
    NSArray *consLineView2Hor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[lineView2]-0-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
    [_bgView addConstraints:consLineView2Hor];
    NSArray *consNameHor = [NSLayoutConstraint constraintsWithVisualFormat:
                                                    @"H:|-5-[nameLabel(50)]-5-[nameField]-5-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
    [_bgView addConstraints:consNameHor];
    NSArray *consLineView3Hor = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-0-[lineView3]-0-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
    [_bgView addConstraints:consLineView3Hor];
    NSArray *consPhoneHor = [NSLayoutConstraint constraintsWithVisualFormat:
                                                    @"H:|-5-[phoneLabel(50)]-5-[phoneField]-5-|"
                                                                         options:0
                                                                         metrics:nil
                                                                           views:nameMap];
    [_bgView addConstraints:consPhoneHor];
    NSArray *consLeftVor = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLabel(20)]-5-[lineView1(1)]-5-[contextField]-5-[lineView2(1)]-5-[nameLabel(20)]-5-[lineView3(1)]-5-[phoneLabel(20)]-5-|"
                                                                    options:0
                                                                    metrics:nil
                                                                      views:nameMap];
    [_bgView addConstraints:consLeftVor];
    NSArray *consRightVor = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-5-[titleLabel(20)]-5-[lineView1(1)]-5-[contextField]-5-[lineView2(1)]-5-[nameField(20)]-5-[lineView3(1)]-5-[phoneField(20)]-5-|"
                                                                   options:0
                                                                   metrics:nil
                                                                     views:nameMap];
    [_bgView addConstraints:consRightVor];
}

@end
