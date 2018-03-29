//
//  HJRefreshTableVC.m
//  Apws
//
//  Created by zhipeng-mac on 15/12/26.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "HJRefreshTableVC.h"

NSUInteger const kPageSize = 10;

@interface HJRefreshTableVC ()

@property (strong, nonatomic) MJRefreshNormalHeader *refreshHeader;

@end


@implementation HJRefreshTableVC


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    //集成刷新控件
    self.tableView.mj_header = self.refreshHeader;
    WS(weakSelf);
    self.tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.refreshHeader beginRefreshing];
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

- (void)refreshControlEndRefresh {
    
    //结束刷新状态
    [self.refreshHeader endRefreshing];
    [self.tableView.mj_footer endRefreshing];
}

- (void)reloadTableViewAfterRequestSuccessGetDataList:(NSArray *)dataList {
    
    if (_pageNo == 1) {
        
        self.dataSource = [dataList mutableCopy];
    }else{
        
        [self.dataSource addObjectsFromArray:dataList];
    }
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return nil;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Prevent the cell from inheriting the Table View's margin settings
    [cell lh_setSeparatorInsetZero];
}

#pragma mark - Setter&Getter

- (void)setCanRefresh:(BOOL)canRefresh {
    
    _canRefresh = canRefresh;
    
    self.tableView.mj_header = canRefresh?self.refreshHeader:nil;
    WS(weakSelf);
    self.tableView.mj_footer = canRefresh?[MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        [weakSelf loadMoreData];
    }]:nil;
}
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

@end
