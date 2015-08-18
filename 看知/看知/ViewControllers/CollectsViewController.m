//
//  CollectsViewController.m
//  看知
//
//  Created by qianfeng on 15/8/17.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "CollectsViewController.h"
#import "DBManager.h"
#import "PostDetailModel.h"
#import "ZhihuInterfaceViewController.h"

@interface CollectsViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation CollectsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    _dataArray = [NSMutableArray array];
    
    [self createNav];
    [self createtableView];
    [self queryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [self queryData];
}

- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    self.navigationItem.title = @"本地收藏";
    
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

- (void)queryData{
    [_dataArray removeAllObjects];
    [_dataArray addObjectsFromArray:[[DBManager shareManager] queryAllCollects]];
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostDetailModel *model = _dataArray[indexPath.row];
    NSString *titleString = [NSString stringWithFormat:@"%@ - %@的回答 - 知乎", model.title, model.authorname];
    NSDictionary *dict = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
    CGRect frame = [titleString boundingRectWithSize:CGSizeMake(self.view.frame.size.width-50, CGFLOAT_MAX)
                                              options:NSStringDrawingUsesLineFragmentOrigin
                                           attributes:dict
                                              context:nil];
    return frame.size.height+10;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CellId"];
    if(cell == nil){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CellId"];
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    PostDetailModel *model = _dataArray[indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@的回答 - 知乎", model.title, model.authorname];
    cell.textLabel.numberOfLines = 0;
    cell.textLabel.font = [UIFont systemFontOfSize:12];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZhihuInterfaceViewController *zvc = [[ZhihuInterfaceViewController alloc] init];
    zvc.isOnlyOne = YES;
    zvc.modelArray = @[_dataArray[indexPath.row]];
    zvc.curIndex = 0;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zvc animated:YES];
}

@end
