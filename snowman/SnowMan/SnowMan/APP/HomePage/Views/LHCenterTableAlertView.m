//
//  LHCenterTableAlertView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "LHCenterTableAlertView.h"

@implementation LHCenterTableAlertView

- (UIView *)alertViewContentView {
    
    UITableView * tableView = [UITableView lh_tableViewWithFrame:CGRectMake(0, 0, 240, kScreenHeight-168) tableViewStyle:UITableViewStylePlain delegate:self dataSourec:self];
    self.tableView = tableView;
    
    return tableView;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[UITableViewCell className]];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell className]];
        
    }
    
    cell.textLabel.text = self.dataSource[indexPath.row];
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self hideWithCompletion:NULL];
    
    !self.selectedRowHandler?:self.selectedRowHandler(indexPath.row,self);
}

#pragma mark - Setter&Getter

- (void)setDataSource:(NSArray *)dataSource {
    
    _dataSource = dataSource;
    
    //frame适配数据源
    self.tableView.lh_height = dataSource.count * 44;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
