//
//  LHCenterTableAlertView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "LHAlertView.h"

@class LHCenterTableAlertView;
typedef void(^SelectedRowHandler)(NSUInteger selectedRow,LHCenterTableAlertView *alertView);

@interface LHCenterTableAlertView : LHAlertView <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) NSArray *dataSource;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, copy) SelectedRowHandler selectedRowHandler;

@end
