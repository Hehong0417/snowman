//
//  HJGoodsCommentTVC.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGoodsCommentTVC.h"
#import "HJOrderCommentCell.h"
#import "HJCommentPagAPI.h"
#import "HJCommentAPI.h"

@interface HJGoodsCommentTVC ()<HJOrderCommentCellDelegate, UITableViewRefreshHandlerDelegate>
@property (nonatomic, strong) NSArray *goodsCommentArray;
@end

@implementation HJGoodsCommentTVC

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.automaticallyAdjustsScrollViewInsets = NO;
    self.title = @"发表评价";
    self.tableView.rowHeight = 186;
    
    [self.tableView lh_addHeaderHandleEvent:self beginRefreshing:YES];
//    [self.tableView lh_addFooterHandleEvent:self];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

#pragma mark - Actions



#pragma mark - Methods


#pragma mark - HJDataHandlerProtocol
- (void)netWorkRequestSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJCommentPagAPI class]]) {
        HJCommentPagAPI *api = responseObject;
        [self.tableView lh_setRefreshDataSource:api.data];
    }
}

#pragma mark - UITableViewRefreshHandlerDelegate
- (void)tableViewRefreshDataHandle:(UITableView *)tableView {
    
    [self commentPagRequest];
}

#pragma mark UITableViewDataSoucre

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return tableView.refreshDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJOrderCommentCell *cell = [HJOrderCommentCell cellWithTableView:tableView];
    cell.orderCommentModel = tableView.refreshDataSource[indexPath.section];
    cell.delegate = self;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

#pragma mark - HJOrderCommentCellDelegate
- (void)orderCommentCellClickComment:(HJOrderCommentCell *)orderCommentCell goodId:(NSInteger)goodId icoArrayData:(NSArray *)icoArrayData contentText:(NSString *)contentText
{
    [self commentRequestWithGoodId:goodId icoArrayData:icoArrayData contentText:contentText];
}

#pragma mark - Networking Request
- (void)commentPagRequest
{
    [[[HJCommentPagAPI commentPag_orderId:@(self.orderId)] netWorkClient] postRequestInView:self.view networkRequestSuccessDataHandler:self];
}

- (void)commentRequestWithGoodId:(NSInteger)goodId icoArrayData:(NSArray *)icoArrayData contentText:(NSString *)contentText{
    [[[HJCommentAPI commentId:@(goodId) content:contentText ico:icoArrayData] netWorkClient] uploadFileInView:self.view successBlock:^(id responseObject) {
        HJCommentAPI *api = responseObject;
        if (api.code == 1) {
            [SVProgressHUD showSuccessWithStatus:@"评价成功"];
            [self commentPagRequest];
        }
    }];
}

#pragma mark - Setter&Getter

- (NSArray *)goodsCommentArray
{
    if (!_goodsCommentArray) {
        _goodsCommentArray = [NSArray array];
    }
    return _goodsCommentArray;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
