//
//  PersonDetailViewController.m
//  看知
//
//  Created by qianfeng on 15/8/17.
//  Copyright (c) 2015年 lyning. All rights reserved.
//

#import "PersonDetailViewController.h"
#import "Const.h"
#import "MyUtil.h"
#import "DBManager.h"
#import "HttpManager.h"
#import "PersonDetailModel.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "PersonPostsCell.h"

@interface PersonDetailViewController ()
    <HttpManagerDelegate, UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) PersonDetailModel *person;

@property (nonatomic, strong) UIBarButtonItem *rightItem;

@property (nonatomic, strong) UIImageView *headerImageView;
@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *typeLabel;
@property (nonatomic, strong) UILabel *countLabel;
@property (nonatomic, strong) UISegmentedControl *segCtrl;

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *detailMeansArray;

@end

@implementation PersonDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithRed:224/255.0 green:224/255.0 blue:224/255.0 alpha:1.0];
    _detailMeansArray = [NSMutableArray array];
    
    [self createNav];
    [self createTopInfo];
    [self createTableView];
    [self getPersonDetailInfo];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - createViews
- (void)createNav{
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    
    if([[DBManager shareManager] isHadFollowed:_personHash]){
        _rightItem = [[UIBarButtonItem alloc]
                                      initWithImage:[[UIImage imageNamed:@"FavoriteFilled"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                      style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(followPerson)];
    }else{
        _rightItem = [[UIBarButtonItem alloc]
                                      initWithImage:[[UIImage imageNamed:@"Favorite"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal]
                                      style:UIBarButtonItemStyleDone
                                      target:self
                                      action:@selector(followPerson)];
    }
    [_rightItem setEnabled:NO];
    self.navigationItem.rightBarButtonItem = _rightItem;
}

- (void)createTopInfo{
    UIView *personBgView = [[UIView alloc] init];
    personBgView.backgroundColor = [UIColor clearColor];
    personBgView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:personBgView];
    
    __weak UIView *weakSelf = self.view;
    [personBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(weakSelf.mas_top).with.offset(64);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.equalTo(@80);
    }];
    
    _headerImageView = [[UIImageView alloc] init];
    _headerImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _headerImageView.layer.masksToBounds = YES;
    _headerImageView.layer.cornerRadius = 25;
    [personBgView addSubview:_headerImageView];
    
    UIScrollView *descriptionScrollView = [[UIScrollView alloc] init];
    descriptionScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    descriptionScrollView.backgroundColor = [UIColor clearColor];
    [personBgView addSubview:descriptionScrollView];
    
    UIView *typeBgView = [[UIView alloc] init];
    typeBgView.translatesAutoresizingMaskIntoConstraints = NO;
    typeBgView.backgroundColor = [UIColor whiteColor];
    typeBgView.layer.masksToBounds = YES;
    typeBgView.layer.cornerRadius = 10;
    [typeBgView.layer setBorderWidth:1.0];
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGColorRef colorref = CGColorCreate(colorSpace,(CGFloat[]){ 25/255.0, 153/255.0, 255/255.0, 1 });
    [typeBgView.layer setBorderColor:colorref];
    [personBgView addSubview:typeBgView];
    
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personBgView.mas_top).with.offset(15);
        make.bottom.equalTo(personBgView.mas_bottom).with.offset(-15);
        make.left.equalTo(personBgView.mas_left).with.offset(15);
        make.width.equalTo(@50);
    }];
    
    [descriptionScrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personBgView.mas_top).with.offset(5);
        make.bottom.equalTo(personBgView.mas_bottom).with.offset(-5);
        make.left.equalTo(_headerImageView.mas_right).with.offset(10);
        make.right.equalTo(typeBgView.mas_left).with.offset(-10);
    }];
    
    [typeBgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personBgView.mas_top).with.offset(15);
        make.bottom.equalTo(personBgView.mas_bottom).with.offset(-15);
        make.right.equalTo(personBgView.mas_right).with.offset(-15);
        make.width.equalTo(@50);
    }];
    
    _descriptionLabel = [[UILabel alloc] init];
    _descriptionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _descriptionLabel.backgroundColor = [UIColor clearColor];
    _descriptionLabel.numberOfLines = 0;
    _descriptionLabel.font = [UIFont systemFontOfSize:12];
    [descriptionScrollView addSubview:_descriptionLabel];
    
    [_descriptionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(descriptionScrollView.mas_top).with.offset(0);
        make.bottom.equalTo(descriptionScrollView.mas_bottom).with.offset(0);
        make.left.equalTo(descriptionScrollView.mas_left).with.offset(0);
        make.right.equalTo(descriptionScrollView.mas_right).with.offset(0);
        make.width.equalTo(descriptionScrollView);
    }];
    
    _typeLabel = [[UILabel alloc] init];
    _typeLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _typeLabel.font = [UIFont systemFontOfSize:10];
    _typeLabel.textAlignment = 1;
    _typeLabel.textColor = [UIColor whiteColor];
    _typeLabel.backgroundColor = [UIColor colorWithRed:25/255.0 green:153/255.0 blue:255/255.0 alpha:1.0];
    _typeLabel.text = _typeLabelString;
    [typeBgView addSubview:_typeLabel];
    
    _countLabel = [[UILabel alloc] init];
    _countLabel.translatesAutoresizingMaskIntoConstraints = NO;
    _countLabel.font = [UIFont systemFontOfSize:10];
    _countLabel.textAlignment = 1;
    _countLabel.backgroundColor = [UIColor whiteColor];
    _countLabel.text = _countLabelString;
    [typeBgView addSubview:_countLabel];
    
    [_typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(typeBgView.mas_top).with.offset(0);
        make.bottom.equalTo(_countLabel.mas_top).with.offset(0);
        make.left.equalTo(typeBgView.mas_left).with.offset(0);
        make.right.equalTo(typeBgView.mas_right).with.offset(0);
        make.height.equalTo(_countLabel);
    }];
    
    [_countLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_typeLabel.mas_bottom).with.offset(0);
        make.bottom.equalTo(typeBgView.mas_bottom).with.offset(0);
        make.left.equalTo(typeBgView.mas_left).with.offset(0);
        make.right.equalTo(typeBgView.mas_right).with.offset(0);
        make.height.equalTo(_typeLabel);
    }];
    
    NSArray *items = @[@"Top10回答", @"七星阵", @"近30天曲线", @"详细资料"];
    _segCtrl = [[UISegmentedControl alloc] initWithItems:items];
    _segCtrl.translatesAutoresizingMaskIntoConstraints = NO;
    _segCtrl.selectedSegmentIndex = 0;
    [_segCtrl addTarget:self action:@selector(segmentedCtrlClick:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:_segCtrl];
    
    [_segCtrl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(personBgView.mas_bottom).with.offset(0);
        make.left.equalTo(weakSelf.mas_left).with.offset(0);
        make.right.equalTo(weakSelf.mas_right).with.offset(0);
        make.height.equalTo(@29);
    }];
}

- (void)createTableView{
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, 0, 0) style:UITableViewStylePlain];
    _tableView.translatesAutoresizingMaskIntoConstraints = NO;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_tableView];
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_segCtrl.mas_bottom).with.offset(2);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(0);
        make.left.equalTo(self.view.mas_left).with.offset(0);
        make.right.equalTo(self.view.mas_right).with.offset(0);
    }];
}

#pragma mark - NetWork
- (void)getPersonDetailInfo{
    HttpManager *manager = [[HttpManager alloc] init];
    manager.delegate = self;
    [manager requestGet:[NSString stringWithFormat:lUserdetailUrl, _personHash]];
}

#pragma mark - ClickAction
- (void)followPerson{
    
}

- (void)segmentedCtrlClick:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            _tableView.hidden = NO;
            [_tableView reloadData];
            break;
        case 1:
            _tableView.hidden = YES;
            break;
        case 2:
            _tableView.hidden = NO;
            [_tableView reloadData];
            break;
        case 3:
            _tableView.hidden = NO;
            [_tableView reloadData];
            break;
        default:
            break;
    }
}

#pragma mark - HttpManagerDelegate
- (void)failure:(AFHTTPRequestOperation *)operation response:(NSError *)error{
    NSLog(@"PersonDetail:%@", error);
}

- (void)success:(AFHTTPRequestOperation *)operation response:(id)responseObject{
    NSDictionary *rootDic = [NSJSONSerialization JSONObjectWithData:responseObject options:NSJSONReadingMutableContainers error:nil];
    _person = [[PersonDetailModel alloc] init];
    
    [_person setValuesForKeysWithDictionary:rootDic];
    NSDictionary *detailDic = rootDic[@"detail"];
    [_person setValuesForKeysWithDictionary:detailDic];
    NSDictionary *starDic = rootDic[@"star"];
    [_person setValuesForKeysWithDictionary:starDic];
    
    for(NSDictionary *trendDic in rootDic[@"trend"]){
        Trend *trend = [[Trend alloc] init];
        [trend setValuesForKeysWithDictionary:trendDic];
        [_person.trendArray addObject:trend];
    }

    for(NSDictionary *topanswerDic in rootDic[@"topanswers"]){
        Topanswers *topanswer = [[Topanswers alloc] init];
        [topanswer setValuesForKeysWithDictionary:topanswerDic];
        [_person.topanswersArray addObject:topanswer];
    }
    
    _rightItem.enabled = YES;
    
    self.navigationItem.title = _person.name;
    [_headerImageView sd_setImageWithURL:[NSURL URLWithString:_person.avatar]];
    _descriptionLabel.text = _person.personDescription;
    
    _detailMeansArray = [NSMutableArray array];
    [_detailMeansArray addObject:@[@[@[@"提问", _person.ask], @[@"回答", _person.answer], @[@"专栏", _person.post]],
                                   @[@[@"赞同数", _person.agree], @[@"1日增加", _person.agreei], @[@"1日增幅", _person.agreeiratio], @[@"7日增加", _person.agreeiw], @[@"7日增幅", _person.agreeiratiow], @[@"平均赞同", _person.ratio]],
                                   @[@[@"关注数", _person.followee], @[@"被关注数", _person.follower], @[@"1日增加", _person.followeri], @[@"1日增幅", _person.followiratio], @[@"7日增加", _person.followeriw], @[@"7日增幅", _person.followiratiow]],
                                   @[@[@"感谢数", _person.thanks], @[@"感谢/赞同比", _person.tratio], @[@"收藏数", _person.fav], @[@"收藏/赞同比", _person.fratio], @[@"公共编辑", _person.logs]],
                                   @[@[@">10000", _person.count10000], @[@">5000", _person.count5000], @[@">2000", _person.count2000], @[@">1000", _person.count1000], @[@">500", _person.count500], @[@">200", _person.count200], @[@">100", _person.count100]],
                                   @[@[@"最高赞同", _person.mostvote], @[@"最高占比", _person.mostvotepercent], @[@"前5赞同", _person.mostvote5], @[@"前5占比", _person.mostvote5percent], @[@"前10赞同", _person.mostvote10], @[@"前10占比", _person.mostvote10percent]]]];
    
    [_tableView reloadData];
}

#pragma mark - UITableViewDelegate, UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    if(_segCtrl.selectedSegmentIndex == 0){
        return 1;
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if(_segCtrl.selectedSegmentIndex == 0){
        return 0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_segCtrl.selectedSegmentIndex == 0){
        return 66;
    }
    return 44;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_segCtrl.selectedSegmentIndex == 0){
        return _person.topanswersArray.count;
    }
    return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UILabel *label = [[UILabel alloc] init];
    label.backgroundColor = [UIColor redColor];
    label.text = @"123";
    return label;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if(_segCtrl.selectedSegmentIndex == 0){
        PersonPostsCell *cell = [tableView dequeueReusableCellWithIdentifier:@"PersonPostsCellId"];
        if(cell == nil){
            cell = [[[NSBundle mainBundle] loadNibNamed:@"PersonPostsCell" owner:nil options:nil] lastObject];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        Topanswers *topanswer = _person.topanswersArray[indexPath.row];
        [cell config:topanswer index:indexPath.row+1];
        return cell;
    }
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
