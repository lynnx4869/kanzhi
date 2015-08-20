//
//  UserDynamicViewController.m
//  看知
//
//  Created by qianfeng on 15/8/10.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "UserDynamicViewController.h"
#import "HttpManager.h"
#import "Const.h"
#import "MyUtil.h"
#import "MJRefresh.h"
#import "PersonModel.h"
#import "PersonCell.h"
#import "PersonDetailViewController.h"
#import "SearchViewController.h"
#import "DBManager.h"
#import "SearchCell.h"

@interface UserDynamicViewController ()
    <HttpManagerDelegate, UITableViewDelegate, UITableViewDataSource, MJRefreshBaseViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *followArray;

@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, assign) NSInteger curPage;
@property (nonatomic, strong) MJRefreshHeaderView *headerView;
@property (nonatomic, strong) MJRefreshFooterView *footerView;

@property (nonatomic, strong) UIButton *rightBtn;
@property (nonatomic, strong) UISegmentedControl *segCtrl;
@property (nonatomic, strong) NSString *urlString;

@property (nonatomic, strong) UIVisualEffectView *effectView;

@property (nonatomic, strong) NSMutableArray *pickLeftArray;
@property (nonatomic, strong) NSMutableArray *pickRightArray;

@end

@implementation UserDynamicViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    
    _dataArray = [NSMutableArray array];
    _followArray = [NSMutableArray array];
    _curPage = 1;
    _isLoading = NO;
    _urlString = lAgreeUrl;
    
    [self createNav];
    [self createtableView];
    [self createPicker];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    
    NSArray *items = @[@"排行榜", @"已关注"];
    _segCtrl = [[UISegmentedControl alloc] initWithItems:items];
    _segCtrl.selectedSegmentIndex = 0;
    _segCtrl.tintColor = [UIColor whiteColor];
    [_segCtrl addTarget:self action:@selector(segmentedCtrlClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segCtrl];
    self.navigationItem.titleView = _segCtrl;
    
    UIButton *leftBtn = [MyUtil createNavBtn:@"用户搜索" target:self action:@selector(gotoSearch:)];
    leftBtn.frame = CGRectMake(0, 0, 60, 25);
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    self.navigationItem.leftBarButtonItem = leftItem;
    
    _rightBtn = [MyUtil createNavBtn:@"赞同数" target:self action:@selector(handoverOrder)];
    _rightBtn.frame = CGRectMake(0, 0, 60, 25);
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:_rightBtn];
    self.navigationItem.rightBarButtonItem = rightItem;
    
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

- (void)createPicker{
    UIBlurEffect *blurEffect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    _effectView = [[UIVisualEffectView alloc] initWithEffect:blurEffect];
    _effectView.frame = CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64);
    _effectView.alpha = 1.0;
    _effectView.hidden = YES;
    [self.view addSubview:_effectView];
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 216)];
    pickerView.tag = 400;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    pickerView.backgroundColor = [UIColor whiteColor];
    pickerView.tintColor = [UIColor whiteColor];
    [_effectView addSubview:pickerView];
    
    UIView *btnBgView = [[UIView alloc] initWithFrame:CGRectMake(0, 216, self.view.frame.size.width, 50)];
    btnBgView.backgroundColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    
    UIButton *cancelBtn = [MyUtil createNavBtn:@"取消" target:self action:@selector(cancelSelectOrder:)];
    cancelBtn.frame = CGRectMake(10, 10, 75, 30);
    cancelBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnBgView addSubview:cancelBtn];
    
    UIButton *sureBtn = [MyUtil createNavBtn:@"确认" target:self action:@selector(sureSelectOrder:)];
    sureBtn.frame = CGRectMake(self.view.frame.size.width-85, 10, 75, 30);
    sureBtn.titleLabel.font = [UIFont systemFontOfSize:16];
    [btnBgView addSubview:sureBtn];
    
    [_effectView addSubview:btnBgView];
    
    [self initPickerData];
}

- (void)downloadData{
    _isLoading = YES;
    
    NSString *url = [NSString stringWithFormat:_urlString, _curPage];
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:url];
}

- (void)initPickerData{
    _pickLeftArray = [NSMutableArray array];
    [_pickLeftArray addObjectsFromArray:@[@"发表", @"赞同", @"关注", @"感谢/收藏", @"高票答案数量"]];
    
    _pickRightArray = [NSMutableArray array];
    [_pickRightArray addObjectsFromArray:@[@[@"提问", @"回答", @"专栏"],
                                           @[@"赞同数", @"1日增加", @"1日增幅", @"7日增加", @"7日增幅", @"平均赞同"],
                                           @[@"被关注数", @"关注数", @"1日增加", @"1日增幅", @"7日增加", @"7日增幅"],
                                           @[@"感谢数", @"感谢/赞同比", @"收藏数", @"收藏/赞同比", @"公共编辑"],
                                           @[@">10000", @">5000", @">2000", @">1000", @">500", @">200", @">100"]]];
}

#pragma mark - BottonClickAction
- (void)gotoSearch:(UIButton *)btn{
    SearchViewController *svc = [[SearchViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:svc];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)handoverOrder{
    UIPickerView *pickerView = (UIPickerView *)[self.view viewWithTag:400];
    
    for(NSInteger i = 0; i < _pickRightArray.count; i++){
        NSArray *array = _pickRightArray[i];
        for(NSInteger j = 0; j < array.count; j++){
            if([_rightBtn.currentTitle isEqual:array[j]]){
                [pickerView selectRow:i inComponent:0 animated:YES];
                [pickerView reloadComponent:1];
                [pickerView selectRow:j inComponent:1 animated:YES];
            }
        }
    }
    
    if(_effectView.hidden){
        _effectView.hidden = NO;
    }
}

- (void)cancelSelectOrder:(UIButton *)btn{
    if(!_effectView.hidden){
        _effectView.hidden = YES;
    }
}

- (void)sureSelectOrder:(UIButton *)btn{
    UIPickerView *pickerView = (UIPickerView *)[self.view viewWithTag:400];
    
    NSInteger section = [pickerView selectedRowInComponent:0];
    NSInteger row = [pickerView selectedRowInComponent:1];
    [_rightBtn setTitle:_pickRightArray[section][row] forState:UIControlStateNormal];
    
    _urlString = [MyUtil urlStringFromType:_pickRightArray[section][row]];
    _curPage = 1;
    [_headerView beginRefreshing];
    
    if(!_effectView.hidden){
        _effectView.hidden = YES;
    }
}

- (void)segmentedCtrlClick:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            _rightBtn.hidden = NO;
            _headerView.hidden = NO;
            _footerView.hidden = NO;
            _headerView.scrollView = _tableView;
            _footerView.scrollView = _tableView;
            _tableView.contentOffset = CGPointMake(0, 0);
            [_tableView reloadData];
            break;
        case 1:
            [_followArray removeAllObjects];
            [_followArray addObjectsFromArray:[[DBManager shareManager] queryAllFollows]];
            
            _rightBtn.hidden = YES;
            _headerView.hidden = YES;
            _footerView.hidden = YES;
            _headerView.scrollView = nil;
            _footerView.scrollView = nil;
            _tableView.contentOffset = CGPointMake(0, 0);
            [_tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - HttpManagerDelegate
- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"UserDynamic:%@", error);
    [MyUtil warmNetCannotConnect];
    _isLoading = NO;
    [_headerView endRefreshing];
    [_footerView endRefreshing];
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    if(_curPage == 1){
        [_dataArray removeAllObjects];
    }
    
    id result = [NSJSONSerialization JSONObjectWithData:responseObject options:0 error:nil];
    if([result isKindOfClass:[NSDictionary class]]){
        NSDictionary *dic = result;
        NSArray *personsArray = dic[@"topuser"];
        for(NSDictionary *personDic in personsArray){
            PersonModel *model = [[PersonModel alloc] init];
            [model setValuesForKeysWithDictionary:personDic];
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
    return 90;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_segCtrl.selectedSegmentIndex == 0){
        return _dataArray.count;
    }else{
        return _followArray.count;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_segCtrl.selectedSegmentIndex == 0){
        PersonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonCellId"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PersonModel *model = _dataArray[indexPath.row];
        [cell config:model order:[NSString stringWithFormat:@"%d", indexPath.row+1] type:_rightBtn.currentTitle];
        return cell;
    }else{
        SearchCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SearchCellId"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"SearchCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        PersonDetailModel *model = _followArray[indexPath.row];
        [cell configDetail:model];
        return cell;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    PersonDetailViewController *pdvc = [[PersonDetailViewController alloc] init];
    if(_segCtrl.selectedSegmentIndex == 0){
        PersonModel *model = _dataArray[indexPath.row];
        pdvc.personHash = model.personHash;
        pdvc.typeLabelString = _rightBtn.currentTitle;
    }else{
        PersonDetailModel *model = _followArray[indexPath.row];
        pdvc.personHash = model.personHash;
        pdvc.typeLabelString = @"赞同数";
    }
    
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
        _curPage = 1;
        [self downloadData];
    }else if(refreshView == _footerView){
        _curPage++;
        [self downloadData];
    }
}

- (void)dealloc{
    _headerView = nil;
    _footerView = nil;
}

#pragma mark - UIPickerViewDelegate, UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return _pickLeftArray.count;
    }else{
        NSInteger index = [pickerView selectedRowInComponent:0];
        NSArray *array = _pickRightArray[index];
        return array.count;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return _pickLeftArray[row];
    }else{
        NSInteger index = [pickerView selectedRowInComponent:0];
        NSArray *array = _pickRightArray[index];
        return array[row];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
}

@end
