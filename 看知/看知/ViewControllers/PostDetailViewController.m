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
#import "ZhihuInterfaceViewController.h"

@interface PostDetailViewController ()
    <HttpManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) UIButton *rightBtn;

@end

@implementation PostDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    
    _dataArray = [NSMutableArray array];
    
    [self createNav];
    [self createtableView];
    [self createDatePicker];
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
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithTitle:@""
                                                                 style:UIBarButtonItemStylePlain
                                                                target:nil
                                                                action:nil];
    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"navBack"]
                                  forState:UIControlStateNormal
                                barMetrics:UIBarMetricsDefault];
    self.navigationItem.backBarButtonItem = backItem;
    
    _rightBtn = [MyUtil createNavBtn:_date target:self action:@selector(handoverDate)];
    _rightBtn.frame = CGRectMake(0, 0, 75, 25);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    rightItem.tag = 200;
    self.navigationItem.rightBarButtonItem = rightItem;
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

- (void)createDatePicker{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _effectView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    _effectView.alpha = 0.85;
    _effectView.hidden = YES;
    [self.view addSubview:_effectView];
    
    UIDatePicker *datePicker = [[UIDatePicker alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];
    datePicker.tag = 300;
    datePicker.backgroundColor = [UIColor whiteColor];
    datePicker.tintColor = [UIColor whiteColor];
    datePicker.datePickerMode = UIDatePickerModeDate;
    datePicker.minimumDate = [MyUtil dateFromString:@"2012-01-01"];
    datePicker.maximumDate = [NSDate date];
    [_effectView addSubview:datePicker];
    
    UIView *btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 216, self.view.frame.size.width, 50)];
    btnBgView.backgroundColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    
    UIButton *cancelBtn = [MyUtil createNavBtn:@"取消" target:self action:@selector(cancelSelectDate:)];
    cancelBtn.frame = CGRectMake(10, 10, 75, 30);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnBgView addSubview:cancelBtn];
    
    UIButton *sureBtn = [MyUtil createNavBtn:@"确认" target:self action:@selector(sureSelectDate:)];
    sureBtn.frame = CGRectMake(self.view.frame.size.width-85, 10, 75, 30);
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnBgView addSubview:sureBtn];
    
    [_effectView addSubview:btnBgView];
}

- (void)downloadData{
    if(_dataArray){
        [_dataArray removeAllObjects];
    }
    
    NSArray *dateArray = [_date componentsSeparatedByString:@"-"];
    NSString *url = [NSString stringWithFormat:lDetailUrl,
                     [NSString stringWithFormat:@"%@%@%@", dateArray[0], dateArray[1], dateArray[2]], _name];
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:url];;
}

#pragma mark - BottonClickAction
- (void)handoverDate{
    UIDatePicker *datePicker = (UIDatePicker *)[self.view viewWithTag:300];
    datePicker.date = [MyUtil dateFromString:_date];
    
    if(_effectView.hidden){
        _effectView.hidden = NO;
    }
}

- (void)cancelSelectDate:(UIButton *)btn{
    if(!_effectView.hidden){
        _effectView.hidden = YES;
    }
}

- (void)sureSelectDate:(UIButton *)btn{
    UIDatePicker *datePicker = (UIDatePicker *)[self.view viewWithTag:300];
    _date = [MyUtil stringFromDate:datePicker.date];
    [_rightBtn setTitle:_date forState:UIControlStateNormal];
    [self downloadData];
    if(!_effectView.hidden){
        _effectView.hidden = YES;
    }
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
    ZhihuInterfaceViewController *zvc = [[ZhihuInterfaceViewController alloc] init];
    zvc.curIndex = indexPath.row;
    zvc.modelArray = _dataArray;
    zvc.isOnlyOne = NO;
    
    self.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:zvc animated:YES];
}

@end
