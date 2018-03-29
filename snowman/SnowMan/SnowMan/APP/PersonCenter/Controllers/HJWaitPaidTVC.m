//
//  HJWaitPaidTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJWaitPaidTVC.h"
#import "HJOrderListCell.h"
#import "HJOrderListSectionHeaderView.h"
#import "HJOrderListSectionFooterView.h"
#import "HJOrderDetailVC.h"
#import "HJOrderListAPI.h"
#import "HJConfirmIndentAPI.h"
#import "HJApplicationSaleTVC.h"
#import "HJGetPayChargeAPI.h"
#import "Pingpp.h"
#import "HJAfterSalesListAPI.h"
#import "HJOrderDetailAfterVC.h"
#import "HJDeleteIndentIdAPI.h"
#import "HJDeleteAfterOrderAPI.h"
#import "HJSaleResultVC.h"


@interface HJWaitPaidTVC () <HJDataHandlerProtocol,UITableViewRefreshHandlerDelegate>

@property (nonatomic, assign) HJPayChannelType payType;

@property (nonatomic, strong) HJOrderListModel *orderListModel;

@end

@implementation HJWaitPaidTVC


#pragma mark - LifeCycle

- (instancetype)init{
    // 设置tableView的分组样式为Group样式
    return [self initWithStyle:UITableViewStyleGrouped];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    [self.tableView lh_registerNibFromCellClassName:[HJOrderListCell className]];
    
    [self.tableView lh_addHeaderHandleEvent:self beginRefreshing:NO];
    [self.tableView lh_addFooterHandleEvent:self];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    if ([responseObject isKindOfClass:[HJConfirmIndentAPI class]]) {
        
        [self.tableView.refreshHeader beginRefreshing];
        
//        //发送通知跳转订单状态
//        [[NSNotificationCenter defaultCenter]postNotificationName:kNotification_ChangeMyOrderListSelectedOrderState object:@(HJOrderStateFinished)];
        HJConfirmIndentAPI *api = responseObject;
        HJSaleResultVC *saleResultVC = [[HJSaleResultVC alloc] init];
        saleResultVC.resultType = HJResultTypeCertain;
        if ([api.data respondsToSelector:@selector(score)]) {
            
            saleResultVC.score = api.data.score;
        }
        saleResultVC.orderNo = self.orderListModel.orderNo;
        [self.navigationController lh_pushVC:saleResultVC];
    }
    
    if ([responseObject isKindOfClass:[HJDeleteIndentIdAPI class]]) {
        HJSaleResultVC *saleResultVC = [[HJSaleResultVC alloc] init];
        saleResultVC.resultType = HJResultTypeDelete;
        [self.navigationController lh_pushVC:saleResultVC];
    }
    
    if ([responseObject isKindOfClass:[HJDeleteAfterOrderAPI class]]) {
        HJSaleResultVC *saleResultVC = [[HJSaleResultVC alloc] init];
        saleResultVC.resultType = HJResultTypeDelete;
        [self.navigationController lh_pushVC:saleResultVC];
    }
    
    //
    if ([responseObject isKindOfClass:[HJGetPayChargeAPI class]]) {
        
        //
        HJGetPayChargeAPI *apiModel = responseObject;
        
        WEAK_SELF();
        
        /**
         *  支付宝支付
         */
        if (self.payType == HJPayChannelTypeAliPay) {
            
            //支付宝支付
            [Pingpp createPayment:apiModel.data viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                
                //
                NSLog(@"completion block: %@", result);
                //
                if (error == nil) {
                    
                    NSLog(@"PingppError is nil");

                    NSString *orderNo = [apiModel.data objectForKey:@"orderNo"];
                    HJSaleResultVC *vc = [[HJSaleResultVC alloc] init];
                    vc.resultType = HJResultTypePaySuccess;
                    vc.orderNo = orderNo;
                    [weakSelf.navigationController lh_pushVC:vc];

                    
                } else {
                    
                    NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                    [SVProgressHUD showInfoWithStatus:@"支付失败"];
                }
            }];
            
            /**
             *  微信支付
             */
            if (self.payType == HJPayChannelTypeWx) {
                
                //支付宝支付
                [Pingpp createPayment:apiModel.data viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                    
                    //
                    NSLog(@"completion block: %@", result);
                    //
                    if (error == nil) {
                        
                        NSLog(@"PingppError is nil");

                        NSString *orderNo = [apiModel.data objectForKey:@"orderNo"];
                        HJSaleResultVC *vc = [[HJSaleResultVC alloc] init];
                        vc.resultType = HJResultTypePaySuccess;
                        vc.orderNo = orderNo;
                        [weakSelf.navigationController lh_pushVC:vc];

                    } else {
                        
                        NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                        [SVProgressHUD showInfoWithStatus:@"支付失败"];
                    }
                }];
            }
            //
        }
        
    }
    
    //
    if ([responseObject isKindOfClass:[HJAfterSalesListAPI class]]) {
        
        HJAfterSalesListAPI *apiModel = responseObject;
        
        [self.tableView lh_setRefreshDataSource:apiModel.data];
        
    }
    
}

#pragma mark - UITableViewRefreshHandlerDelegate

- (void)tableViewRefreshDataHandle:(UITableView *)tableView {
    
    if (self.orderType  == HJOrderStateReturnOfGoods) {
        
        [self afterSalesRequest];
        
    } else {
        
        [self orderListRequest];
        
    }
}

#pragma mark - Action

- (void)payAction:(UIButton *)button {
    
    HJOrderListModel *orderListModel = [self.tableView.refreshDataSource objectAtIndex:button.tag];
    self.orderListModel = orderListModel;
    self.payType = orderListModel.payType;
    [self getPayChargeRequest_orderNo:orderListModel.orderNo.numberValue];
}

- (void)sureRecieveGoodsAction:(UIButton *)button {
    
    HJOrderListModel *orderListModel = [self.tableView.refreshDataSource objectAtIndex:button.tag];
    self.orderListModel = orderListModel;
    [self confirmIndentRequest_indentId:orderListModel.orderId.numberValue];
}

- (void)deleteAction:(UIButton *)button
{
    HJAfterSaleListModel *afterSaleListModel = self.tableView.refreshDataSource[button.tag];
    
    HJOrderListModel *orderListModel = self.tableView.refreshDataSource[button.tag];

    if (self.orderType == HJOrderStateFinished) {
        [self deleteOrderRequestWithOrderId:[orderListModel.orderId numberValue]];
    }
    
    if (self.orderType == HJOrderStateReturnOfGoods) {
        
        [self deleteRefundOrderRequestWithRefundId:@(afterSaleListModel.refundId)];
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return self.tableView.refreshDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.orderType == HJOrderStateReturnOfGoods) {
        
        return 1;
    }
    
    HJOrderListModel *orderListModel = self.tableView.refreshDataSource[section];
    
    return orderListModel.goodsList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    HJOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJOrderListCell className] forIndexPath:indexPath];
    
    [cell lh_setSeparatorInsetZero];
    // Configure the cell...
    if (self.orderType == HJOrderStateFinished) {
        
        cell.haveHandler = YES;
    } else {
        
        cell.haveHandler = NO;
    }
    
    //
    if (self.orderType == HJOrderStateReturnOfGoods) {
        
        HJAfterSaleListModel *afterSaleListModel = self.tableView.refreshDataSource[indexPath.section];
        cell.afterSaleListModel = afterSaleListModel;
        
    } else {
        
        HJOrderListModel *orderListModel = tableView.refreshDataSource[indexPath.section];
        HJOrderGoodslistModel *goodsListModel = orderListModel.goodsList[indexPath.row];
        
        //
        cell.orderGoodsListModel = goodsListModel;
        //
        [cell.actionHandlerButton bk_removeEventHandlersForControlEvents:UIControlEventTouchUpInside];
        WEAK_SELF();
        if ([cell.actionHandlerButton.titleLabel.text isEqualToString:@"申请售后"]) {
            
            //
            [cell.actionHandlerButton bk_addEventHandler:^(id sender) {
                
                //跳转去申请售后页面
                HJApplicationSaleTVC *applicationSaleTVC = [HJApplicationSaleTVC new];
                applicationSaleTVC.salegoodsListModel = goodsListModel;
                applicationSaleTVC.orderNo = orderListModel.orderNo;
                applicationSaleTVC.orderId = orderListModel.orderId.integerValue;
                [weakSelf.navigationController lh_pushVC:applicationSaleTVC];
                
            } forControlEvents:UIControlEventTouchUpInside];
            
        }
        
    }
    
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.orderType == HJOrderStateReturnOfGoods) {
        
        HJAfterSaleListModel *afterSaleListModel = self.tableView.refreshDataSource[indexPath.section];
        HJOrderDetailAfterVC *OrderDetailAfterVC = [[HJOrderDetailAfterVC alloc] init];
        OrderDetailAfterVC.refundId =  afterSaleListModel.refundId;
        [self.navigationController lh_pushVC:OrderDetailAfterVC];
        
    } else {
        HJOrderListModel *orderLsitModel = self.tableView.refreshDataSource[indexPath.section];
        
        HJOrderDetailVC *orderDetailVC = [HJOrderDetailVC new];
        orderDetailVC.orderType = orderLsitModel.state;
        orderDetailVC.orderId = orderLsitModel.orderId.numberValue;
        [self.navigationController lh_pushVC:orderDetailVC];
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 45;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 48;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HJOrderListSectionHeaderView *headerView = [HJOrderListSectionHeaderView lh_createByFrame:CGRectMake(0, 0, SCREEN_WIDTH, 45)];
    HJOrderListModel *orderListModel = self.tableView.refreshDataSource[section];
    headerView.orderType = self.orderType;
    
    if (self.orderType == HJOrderStateReturnOfGoods) {
        
       //
        HJAfterSaleListModel *afterSaleListModel = self.tableView.refreshDataSource[section];
        headerView.afterSaleListModel = afterSaleListModel;
        
    } else {
        
        headerView.orderListModel = orderListModel;
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    
    HJOrderListSectionFooterView *footerView = [HJOrderListSectionFooterView lh_createByFrame:CGRectMake(0, 0, SCREEN_WIDTH, 48)];
    HJOrderListModel *orderListModel = self.tableView.refreshDataSource[section];

    if (self.orderType == HJOrderStateReturnOfGoods) {
        
        HJAfterSaleListModel *afterSaleListModel = self.tableView.refreshDataSource[section];
        footerView.afterSaleListModel = afterSaleListModel;
        footerView.orderType = HJOrderStateDeleteAfter;
        
    } else {
        
        footerView.orderListModel = orderListModel;
    }

    
    footerView.sectionHanlerButton.tag = section;
    
    if ([footerView.sectionHanlerButton.titleLabel.text isEqualToString:@"确认收货"]) {
        
        [footerView.sectionHanlerButton addTarget:self action:@selector(sureRecieveGoodsAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //订单支付
    if ([footerView.sectionHanlerButton.titleLabel.text isEqualToString:@"立即支付"]) {
        
        //
        [footerView.sectionHanlerButton addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if ([footerView.sectionHanlerButton.titleLabel.text isEqualToString:@"删除订单"]) {
        [footerView.sectionHanlerButton addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return footerView;
}

#pragma mark - Networking Request

- (void)orderListRequest {
    //刷新请求不进统一代理方法
    [[[HJOrderListAPI orderList_state:self.orderType page:@(self.tableView.pageNo) rows:@(self.tableView.pageSize)]netWorkClient]postRequestInView:self.view finishedBlock:^(id responseObject, NSError *error) {
        
        [self.tableView endRefreshing];
        //
        HJOrderListAPI *apiModel = responseObject;
        if (apiModel.code
             == NetworkCodeTypeSuccess) {
            
            HJOrderListAPI *apiModel = responseObject;
            
            [self.tableView lh_setRefreshDataSource:apiModel.data];
        }
    }];;
}

- (void)confirmIndentRequest_indentId:(NSNumber *)indentId {
    
    [[[HJConfirmIndentAPI confirmIndent_orderId:indentId]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)getPayChargeRequest_orderNo:(NSNumber *)orderNo {
    
    [[[HJGetPayChargeAPI getPayCharge_orderNo:orderNo]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)afterSalesRequest {
    
    [[[HJAfterSalesListAPI afterSalesList_page:@(self.tableView.pageNo) rows:@(self.tableView.pageSize)]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)deleteOrderRequestWithOrderId:(NSNumber *)orderId
{
    [[[HJDeleteIndentIdAPI deleteOrderWithOrderId:orderId] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)deleteRefundOrderRequestWithRefundId:(NSNumber *)refundId
{
    [[[HJDeleteAfterOrderAPI deleteAfterOrderWithRefundId:refundId] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

@end
