//
//  HJSegmentCotrollVC.m
//  Bsh
//
//  Created by zhipeng-mac on 15/12/17.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "HJSegmentCotrollVC.h"

@interface HJSegmentCotrollVC () 

@property (strong, nonatomic) MJRefreshNormalHeader *refreshHeader;
@property (nonatomic, strong) UIView *headView;

@end

@implementation HJSegmentCotrollVC

#define kHeadViewHegiht 50.0f

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self .view addSubview:self.headView];
    [self.view addSubview:self.tableView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - PublicMethods

- (void)loadNewData {
    
    _pageNo = 1;
    [self getDataList];
}

- (void)loadMoreData {
    
    _pageNo ++;
    [self getDataList];
}

- (void)getDataList {
    
    
}

- (void)refreshSegmentTitles {
    
    [self.segmentControll AddSegumentArray:[self segmentTitles]];
}

#pragma mark - LjjUISegmentedControlDelegate

-(void)uisegumentSelectionChange:(NSInteger)selection{
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSources.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    
    if (section == 0) {
        
        return 0;
    }
    
    return 0;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    // Prevent the cell from inheriting the Table View's margin settings
    if (iOS8) {
        
        [cell setPreservesSuperviewLayoutMargins:NO];
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - Setter_Getter

- (MJRefreshHeader *)refreshHeader{
    
    if (!_refreshHeader) {
        
        WS(weakSelf);
        _refreshHeader = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
            [weakSelf loadNewData];
        }];
        _refreshHeader.lastUpdatedTimeLabel.hidden = YES;
    }
    
    return _refreshHeader;
}

-(LjjUISegmentedControl *)segmentControll {
    
    if (!_segmentControll) {
        
        _segmentControll = [[LjjUISegmentedControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeadViewHegiht)];
        _segmentControll.delegate = self;
        [_segmentControll setBackgroundColor:[UIColor clearColor]];
        [_segmentControll setTitleColor:[UIColor blackColor]];
        [_segmentControll setSelectColor:APP_COMMON_COLOR];
        [_segmentControll setLineColor:APP_COMMON_COLOR];
        [_segmentControll setTitleFont:[UIFont systemFontOfSize:14]];
        [_segmentControll AddSegumentArray:[self segmentTitles]];
        
    }
    
    return _segmentControll;
}

- (UIView *)headView {
    
    if (!_headView) {
       
        _headView = [[UIView alloc]initWithFrame:CGRectMake(0, STATUS_NAV_HEIGHT, SCREEN_WIDTH, kHeadViewHegiht)];
        [_headView setBackgroundColor:RGB(242, 242, 242)];
        [_headView addSubview:self.segmentControll];
    }
    
    return _headView;
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, self.headView.lh_bottom, SCREEN_WIDTH, self.view.lh_height-self.headView.lh_bottom) style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.tableFooterView = [UIView new];
        
    }
    
    return _tableView;
}


@end
