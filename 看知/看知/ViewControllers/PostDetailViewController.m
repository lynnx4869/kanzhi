//
//  PostDetailViewController.m
//  看知
//
//  Created by qianfeng on 15/8/12.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "PostDetailViewController.h"
#import "HttpManager.h"
#import "Const.h"
#import "MyUtil.h"
#import "PostDetailModel.h"
#import "PostDetailCell.h"

@interface PostDetailViewController ()
    <HttpManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;

@end

@implementation PostDetailViewController

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
    self.navigationItem.title = [MyUtil transNameForZh:_name];
    
    UIBarButtonItem *item = [[UIBarButtonItem alloc]
                             initWithImage:[[UIImage imageNamed:@"navBack"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                              style:UIBarButtonItemStyleDone
                             target:self
                             action:@selector(goBack)];
    self.navigationItem.leftBarButtonItem = item;
}

- (void)createtableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc]
                  initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64)
                  style:UITableViewStylePlain];
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"PostDetailCell" bundle:nil] forCellReuseIdentifier:@"PostDetailCellId"];
    [self.view addSubview:_tableView];
}

- (void)goBack{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)downloadData{
    NSString *url = [NSString stringWithFormat:lDetailUrl, _date, _name];
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:url];;
}

#pragma mark - HttpManagerDelegate
- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"Home:%@", error);
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    if([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = result;
        NSArray *postsArray = dic[@"answers"];
        for(NSDictionary *postDetailDic in postsArray){
            PostDetailModel *model = [[PostDetailModel alloc] init];
            [model setValuesForKeysWithDictionary:postDetailDic];
            [_dataArray addObject:model];
        }
    }
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 200;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    PostDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PostDetailCellId"];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    PostDetailModel *model = _dataArray[indexPath.row];
    [cell config:model];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
