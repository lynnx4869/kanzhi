//
//  QuestionViewController.m
//  看知
//
//  Created by qianfeng on 15/8/14.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "QuestionViewController.h"
#import "MyUtil.h"
#import "Const.h"
#import "HttpManager.h"
#import "QuestionCell.h"
#import "QuestionModel.h"

@interface QuestionViewController () <UITableViewDelegate, UITableViewDataSource, HttpManagerDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation QuestionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    
    [self createNav];
    [self createtableView];
    [self downloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    self.navigationItem.title = @"常见问题";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navBack"]
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = backItem;
}

- (void)createtableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)
                  style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)downloadData{
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:lFaqUrl];;
}

#pragma mark - HttpManagerDelegate
- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Home:%@", error);
    [MyUtil warmNetCannotConnect];
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    if([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = result;
        NSArray *questionsArray = dic[@"faq"];
        for(NSDictionary *questionDic in questionsArray){
            QuestionModel *model = [[QuestionModel alloc] init];
            [model setValuesForKeysWithDictionary:questionDic];
            [_dataArray addObject:model];
        }
    }
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [[[QuestionCell alloc] init] heightForRow:_dataArray[indexPath.row]];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    QuestionCell *cell = [tableView dequeueReusableCellWithIdentifier:@"QuestionCellId"];
    if(cell == nil){
        cell = [[QuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuestionCellId"];
    }
    QuestionModel *model = _dataArray[indexPath.row];
    [cell config:model];
    return cell;
}

@end
