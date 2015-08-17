//
//  SettingViewController.m
//  看知
//
//  Created by qianfeng on 15/8/10.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "SettingViewController.h"
#import "SuggestionViewController.h"
#import "QuestionViewController.h"
#import "AboutViewController.h"

@interface SettingViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    _dataArray = [NSMutableArray array];
    
    [self createNav];
    [self createtableView];
    [self createData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    self.navigationItem.title = @"设置";
    
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
                  initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-113)
                  style:UITableViewStyleGrouped];
    _tableView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
}

- (void)createData{
    NSArray *array1 = @[@"意见反馈", @"常见问题", @"关于"];
    NSArray *array2 = @[@"发送通知", @"夜间模式", @"本地收藏", @"清理缓存"];
    [_dataArray addObjectsFromArray:@[array1, array2]];
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSArray *array = _dataArray[section];
    return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellId"];
    }
    if(indexPath.section == 0){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if(indexPath.section == 1 && indexPath.row == 2){
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }else if((indexPath.section == 1 && indexPath.row == 0) || (indexPath.section == 1 && indexPath.row == 1)){
        UISwitch *switcher = [[UISwitch alloc] init];
        cell.accessoryView = switcher;
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = _dataArray[indexPath.section][indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(indexPath.section == 0 && indexPath.row == 0){
        SuggestionViewController *svc = [[SuggestionViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:svc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(indexPath.section == 0 && indexPath.row == 1){
        QuestionViewController *qvc = [[QuestionViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:qvc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }else if(indexPath.section == 0 && indexPath.row == 2){
        AboutViewController *avc = [[AboutViewController alloc] init];
        self.hidesBottomBarWhenPushed = YES;
        [self.navigationController pushViewController:avc animated:YES];
        self.hidesBottomBarWhenPushed = NO;
    }
}

@end
