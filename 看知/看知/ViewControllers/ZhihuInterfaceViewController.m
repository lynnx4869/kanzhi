//
//  ZhihuInterfaceViewController.m
//  看知
//
//  Created by qianfeng on 15/8/12.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "ZhihuInterfaceViewController.h"
#import "MyUtil.h"
#import "Const.h"
#import "DBManager.h"

@interface ZhihuInterfaceViewController () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation ZhihuInterfaceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createNav];
    [self createWebView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    [self.navigationController setToolbarHidden:NO animated:YES];
    
    if([[DBManager shareManager] isHadCollected:_modelArray[_curIndex]]){
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                      initWithImage:[[UIImage imageNamed:@"FavoriteFilled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                      style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(attentionPost)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }else{
        UIBarButtonItem *rightItem = [[UIBarButtonItem alloc]
                                      initWithImage:[[UIImage imageNamed:@"Favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                      style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(attentionPost)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    
    if(_isOnlyOne){
        PostDetailModel *model = _modelArray[_curIndex];
        self.navigationItem.title = model.title;
    }else{
        UIStepper *stepper = [[UIStepper alloc] init];
        stepper.value = _curIndex + 1;
        stepper.minimumValue = 1;
        stepper.maximumValue = _modelArray.count;
        stepper.stepValue = 1;
        stepper.tintColor = [UIColor whiteColor];
        [stepper addTarget:self action:@selector(stepperValueChange:) forControlEvents:UIControlEventValueChanged];
        self.navigationItem.titleView = stepper;
    }
    
    UIBarButtonItem *retreatItem = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage imageNamed:@"left_arrow"]
                                    style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(webRetreat:)];
    UIBarButtonItem *forwardItem = [[UIBarButtonItem alloc]
                                    initWithImage:[UIImage imageNamed:@"right_arrow"]
                                    style:UIBarButtonItemStyleDone
                                    target:self
                                    action:@selector(webForward:)];
    UIBarButtonItem *refreshItem = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
                                    target:self
                                    action:@selector(webRefresh:)];
    UIBarButtonItem *shareItem = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemAction
                                    target:self
                                    action:@selector(webShare:)];
    UIBarButtonItem *flexItem = [[UIBarButtonItem alloc]
                                    initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace
                                    target:nil
                                    action:nil];
    [self setToolbarItems:@[retreatItem, flexItem, forwardItem, flexItem, refreshItem, flexItem, shareItem]];
    self.navigationController.toolbar.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
}

- (void)createWebView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _webView = [[UIWebView alloc] initWithFrame:
                          CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-108)];
    _webView.delegate = self;
    [self.view addSubview:_webView];
    
    PostDetailModel *model = _modelArray[_curIndex];
    [self loadNet:model.questionid answer:model.answerid];
}

- (void)loadNet:(NSString *)questionId answer:(NSString *)answerId{
    NSString *urlString = [NSString stringWithFormat:lZhihuUrl, questionId, answerId];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:[NSURL URLWithString:urlString]];
    [_webView loadRequest:request];
}

#pragma mark - BottonClickAction
- (void)attentionPost{
    if([[DBManager shareManager] isHadCollected:_modelArray[_curIndex]]){
        [[DBManager shareManager] deleteCollect:_modelArray[_curIndex]];
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"Favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        [[DBManager shareManager] collectPost:_modelArray[_curIndex]];
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"FavoriteFilled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
}

- (void)stepperValueChange:(UIStepper *)stepper{
    _curIndex = stepper.value-1;
    PostDetailModel *model = _modelArray[_curIndex];
    if([[DBManager shareManager] isHadCollected:model]){
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"FavoriteFilled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }else{
        self.navigationItem.rightBarButtonItem.image = [[UIImage imageNamed:@"Favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    }
    [self loadNet:model.questionid answer:model.answerid];
}

- (void)webRetreat:(UIBarButtonItem *)item{
    [_webView goBack];
}

- (void)webForward:(UIBarButtonItem *)item{
    [_webView goForward];
}

- (void)webRefresh:(UIBarButtonItem *)item{
    [_webView reload];
}

- (void)webShare:(UIBarButtonItem *)item{
    PostDetailModel *model = _modelArray[_curIndex];
    NSString *title = model.title;
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:lZhihuUrl, model.questionid, model.answerid]];
    
    UIActivityViewController *avc = [[UIActivityViewController alloc] initWithActivityItems:@[title, url]
                                                                      applicationActivities:nil];
    [self presentViewController:avc animated:YES completion:nil];
}

- (void)viewWillDisappear:(BOOL)animated{
    self.navigationController.toolbarHidden = YES;
}

@end
