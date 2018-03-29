//
//  HJMyIntegralVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMyIntegralVC.h"
#import "HJScoreAPI.h"
#import "HJIntegralDetailCell.h"
#import "HJMyIntegralHeaderView.h"
#import "HJIntegralRuleVC.h"

@interface HJMyIntegralVC () <UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) HJScoreModel *scoreModel;
@property (nonatomic, strong) UITableView *integralTableView;
@property (nonatomic, weak) HJMyIntegralHeaderView *integralHeaderView;
@end

@implementation HJMyIntegralVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我的积分";
    
    self.integralTableView.delegate = self;
    self.integralTableView.dataSource = self;
    [self.view addSubview:self.integralTableView];
    
    [self setupHeaderViwAndRightButton];
    
    [self getMyIntegralRequest];
    
    // 解决分隔线右移
    if ([self.integralTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        [self.integralTableView setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([self.integralTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        [self.integralTableView setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Actions
- (void)integralRuleAction
{
    HJIntegralRuleVC *integralRuleVC = [[HJIntegralRuleVC alloc] init];
    [self.navigationController lh_pushVC:integralRuleVC];
}


#pragma mark - Methods

- (void)setupHeaderViwAndRightButton
{
    HJMyIntegralHeaderView *headerView = [HJMyIntegralHeaderView myIntegralHeaderView];
    self.integralTableView.tableHeaderView = headerView;
    self.integralHeaderView = headerView;
    
    UIButton *rightButton = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 60, 30) target:self action:@selector(integralRuleAction) title:@"积分规则" titleColor:kWhiteColor font:FONT(14) backgroundColor:kClearColor];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:rightButton];
}

- (void)setHeaderViewData
{
    self.integralHeaderView.scorceModel = self.scoreModel;
}



#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.scoreModel.scoreList.count ? :0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJScoreListModel *scoreListModel = self.scoreModel.scoreList[indexPath.row];
    HJIntegralDetailCell *cell = [HJIntegralDetailCell cellWithTableView:tableView];
    cell.scoreListModel = scoreListModel;
    return cell;
}

/**
 *  解决分隔线右移
 */
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - HJDataHandlerProtocol
- (void)netWorkRequestSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJScoreAPI class]]) {
        HJScoreAPI *api = responseObject;
        self.scoreModel = api.data;
        [self setHeaderViewData];
        [self.integralTableView reloadData];
    }
}

#pragma mark - NewWorking Request
- (void)getMyIntegralRequest
{
    [[[HJScoreAPI score_page:@1 rows:@20] netWorkClient] postRequestInView:self.view networkRequestSuccessDataHandler:self];
}

#pragma mark - 
- (UITableView *)integralTableView
{
    if (_integralTableView == nil) {
        _integralTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    }
    return _integralTableView;
}


@end
