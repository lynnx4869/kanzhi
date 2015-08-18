//
//  HomeViewController.m
//  看知
//
//  Created by qianfeng on 15/8/10.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "HomeViewController.h"
#import "HttpManager.h"
#import "Const.h"
#import "MyUtil.h"
#import "MJRefresh.h"
#import "PostsModel.h"
#import "PostsCell.h"
#import "PostsPicCell.h"
#import "PostDetailViewController.h"

@interface HomeViewController ()
    <HttpManagerDelegate, UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@property (nonatomic, assign) BOOL isRefresh;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, strong) MJRefreshFooterView *footerView;

@property (nonatomic, assign) BOOL isWordVer;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    _dataArray = [NSMutableArray array];
    _isRefresh = NO;
    _isLoading = NO;
    _isWordVer = YES;
    
    [self createNav];
    [self createtableView];
    //NSLog(@"%@", NSHomeDirectory());
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    self.navigationItem.title = @"最新文章";
    
    NSString *title = @"";
    if(_isWordVer){
        title = @"头像墙首页";
    }else{
        title = @"文字版首页";
    }
    UIButton *leftBtn = [MyUtil createNavBtn:title target:self action:@selector(gotoOtherDisplay:)];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = item;
    
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
                          style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    
    _headerView = [MJRefreshHeaderView header];
    _headerView.scrollView = _tableView;
    _headerView.delegate = self;
    
    _footerView = [MJRefreshFooterView footer];
    _footerView.scrollView = _tableView;
    _footerView.delegate = self;
    
    [_headerView beginRefreshing];
}

- (void)downloadData{
    _isLoading = YES;
    
    NSString *url = @"";
    if(_isRefresh){
        url = [NSString stringWithFormat:lMainUrl, [NSString stringWithFormat:@"%0.0f", [[NSDate date] timeIntervalSince1970]]];
    }else{
        PostsModel *model = [_dataArray lastObject];
        url = [NSString stringWithFormat:lMainUrl, model.publishtime];
    }
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:url];
}

#pragma mark - BottonClickAction
- (void)gotoOtherDisplay:(UIButton *)btn{
    if(_isWordVer){
        _isWordVer = NO;
        [btn setTitle:@"文字版首页" forState:UIControlStateNormal];
    }else{
        _isWordVer = YES;
        [btn setTitle:@"头像墙首页" forState:UIControlStateNormal];
    }
    [_tableView reloadData];
}

#pragma mark - HttpManagerDelegate
- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Home:%@", error);
    [MyUtil warmNetCannotConnect];
    _isLoading = NO;
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    if(_isRefresh){
        [_dataArray removeAllObjects];
    }
    
    id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    if([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = result;
        NSArray *postsArray = dic[@"posts"];
        for(NSDictionary *postDic in postsArray){
            PostsModel *model = [[PostsModel alloc] init];
            [model setValuesForKeysWithDictionary:postDic];
            [_dataArray addObject:model];
        }
    }
    [_tableView reloadData];
    _isLoading = NO;
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_isWordVer){
        return 240;
    }else{
        return 180;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_isWordVer){
        PostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsCellId"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PostsCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PostsModel *model = _dataArray[indexPath.row];
        [cell config:model];
        return cell;
    }else{
        PostsPicCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostsPicCellId"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PostsPicCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PostsModel *model = _dataArray[indexPath.row];
        [cell config:model];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PostsModel *model = _dataArray[indexPath.row];
    PostDetailViewController *pdvc = [[PostDetailViewController alloc] init];
    pdvc.date = model.date;
    pdvc.name = model.name;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:pdvc animated:YES];
    self.hidesBottomBarWhenPushed = NO;
}

#pragma mark - MJRefreshBaseViewDelegate
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView{
    if(_isLoading){
        return ;
    }
    
    if(refreshView == _headerView){
        _isRefresh = YES;
        [self downloadData];
    }else if(refreshView == _footerView){
        _isRefresh = NO;
        [self downloadData];
    }
}

- (void)dealloc{
    _headerView = nil;
    _footerView = nil;
}

@end
