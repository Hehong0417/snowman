//
//  HJOrderDetailVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderDetailVC.h"
#import "HJOrderDetailOrderNumCell.h"
#import "HJAdressListCell.h"
#import "HJOrderListCell.h"
#import "HJOrderInfoAPI.h"
#import "HJPayTypeModel.h"
#import "HJOrderDetailToolBar.h"
#import "HJGetPayChargeAPI.h"
#import "Pingpp.h"
#import "HJCancelIndentAPI.h"
#import "HJConfirmIndentAPI.h"
#import "HJGoodsCommentTVC.h"
#import "HJApplicationSaleTVC.h"
#import "HJDeleteIndentIdAPI.h"
#import "HJSaleResultVC.h"
#import "HJJudgeSepcialGoodsModel.h"

static NSString * const kPayTypeString = @"支付方式";
static NSString * const kDeliverTimeString = @"配送时间";
static NSString * const kSubmitOrderTimeString = @"下单时间";
static NSString * const kGoodsTotalPriceString = @"商品总价";
static NSString * const kScoreValueString = @"积分抵扣";
static NSString * const kActualFeeString = @"实付款";
static NSString * const kCertainTimeString = @"确认时间";
static NSString * const kPayTimeString = @"付款时间";
static NSString * const kGetScoreString = @"获得积分";

@interface HJOrderDetailVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HJOrderInfoModel *orderInfoModel;
@property (nonatomic, strong) HJRecieptAddressModel *addressModel;
@property (nonatomic, strong) HJOrderDetailToolBar *toolBar;

@end

@implementation HJOrderDetailVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolBar];
    
    self.toolBar.orderState = self.orderType;
    
    WEAK_SELF();
    self.toolBar.actionButtonHandler = ^(UIButton *actionButton) {
        
        if ([actionButton.titleLabel.text isEqualToString:kPayRightNowString]) {
            
            [weakSelf payRightNowAction];
        }
        
        if ([actionButton.titleLabel.text isEqualToString:kCancelOrderString]) {
            
            [weakSelf cancelOrderAction];
        }
        
        if ([actionButton.titleLabel.text isEqualToString:kSureRecieveGoods]) {
            
            [weakSelf sureOrderAction];
        }
        
        if ([actionButton.titleLabel.text isEqualToString:kCommentString]) {
            [weakSelf commentAction];
        }
        
        if ([actionButton.titleLabel.text isEqualToString:kDeleteOrderString]) {
            [weakSelf deleteOrderAction];
        }
        
    };
    
    
    [self orderInfoRequest];
}

#pragma mark - Actions

- (void)payRightNowAction {
    
    [self getPayChargeRequest_orderNo:self.orderInfoModel.orderNo.numberValue];
}

- (void)cancelOrderAction {
    
    [self cancelOrderRequest];
}

- (void)sureOrderAction {
    
    [self confirmIndentRequest_indentId:@(self.orderInfoModel.orderId)];
}

- (void)commentAction {
    HJGoodsCommentTVC *TVC = [[HJGoodsCommentTVC alloc] init];
    TVC.orderId = self.orderInfoModel.orderId;
    [self.navigationController lh_pushVC:TVC];
}

- (void)deleteOrderAction
{
    [self deleteOrderActionRequest:@(self.orderInfoModel.orderId)];
}

- (void)saleAfterAction:(UIButton *)button
{
    HJApplicationSaleTVC *applicationSaleTVC = [HJApplicationSaleTVC new];
    
    applicationSaleTVC.orderInfoGoodslistModel = self.orderInfoModel.goodsList[button.tag];
    applicationSaleTVC.orderNo = self.orderInfoModel.orderNo;
    
    applicationSaleTVC.orderId = self.orderInfoModel.orderId;
    
    [self.navigationController lh_pushVC:applicationSaleTVC];
}

#pragma mark - Methods

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    //
    if ([responseObject isKindOfClass:[HJOrderInfoAPI class]]) {
        
        //
        HJOrderInfoAPI *apiModel = responseObject;
        
        self.toolBar.orderInfoModel = apiModel.data;
        self.orderInfoModel = apiModel.data;
        HJRecieptAddressModel *addressModel = [HJRecieptAddressModel new];
        addressModel.userName = self.orderInfoModel.consignee;
        addressModel.phone = self.orderInfoModel.consigneePhone;
        addressModel.address = self.orderInfoModel.receiptName;
        
        self.addressModel = addressModel;
        
        [self.tableView reloadData];
    }
    
    //
    if ([responseObject isKindOfClass:[HJGetPayChargeAPI class]]) {
        
        //
        HJGetPayChargeAPI *apiModel = responseObject;
        
        WEAK_SELF();
        
        /**
         *  支付宝支付
         */
        if (self.orderInfoModel.payType == HJPayChannelTypeAliPay) {
            
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
                    //
                    
                } else {
                    
                    NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                    [SVProgressHUD showInfoWithStatus:@"支付失败"];
                }
            }];
            
            /**
             *  微信支付
             */
            if (self.orderInfoModel.payType == HJPayChannelTypeWx) {
                
                [Pingpp createPayment:apiModel.data viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                    
                    //
                    NSLog(@"completion block: %@", result);
                    //
                    if (error == nil) {
                        
                        NSLog(@"PingppError is nil");
                        
                        //
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
    if ([responseObject isKindOfClass:[HJCancelIndentAPI class]]) {
        
        //
        [SVProgressHUD showSuccessWithStatus:@"取消订单成功"];
        [self.navigationController lh_popVC];
    }
    
    //
    if ([responseObject isKindOfClass:[HJConfirmIndentAPI class]]) {
        
        HJConfirmIndentAPI *api = responseObject;
        HJSaleResultVC *saleResultVC = [[HJSaleResultVC alloc] init];
        saleResultVC.resultType = HJResultTypeCertain;
        
        saleResultVC.score = api.data.score;
        saleResultVC.orderNo = self.orderInfoModel.orderNo;
        [self.navigationController lh_pushVC:saleResultVC];
    }
    
    if ([responseObject isKindOfClass:[HJDeleteIndentIdAPI class]]) {
        HJSaleResultVC *saleResultVC = [[HJSaleResultVC alloc] init];
        saleResultVC.resultType = HJResultTypeDelete;
        [self.navigationController lh_pushVC:saleResultVC];
    }
    
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 4) {
        
        if (self.orderType == HJOrderStateWaitPaid) {
            return 2;
        }
        
        if (self.orderType == HJOrderStateSureRecieveGoods) {
            if (self.orderInfoModel.payType == HJPayChannelTypeOffLine) {
                return 2;
            }
            return 3;
        }
        
        if (self.orderType == HJOrderStateFinished) {
            return 4;
        }
        
        if (self.orderType == HJOrderStateWaitRecieveGoods) {
            
            if (self.orderInfoModel.isSpecial || self.orderInfoModel.payType == HJPayChannelTypeOffLine) {
                
                return 2;
            }
            return 3;
        }
        
        return 4;
    }
    
    if (section == 5) {
        
        if (self.orderInfoModel.isSpecial) {
            
            return 2;
        }
        
        if (self.orderInfoModel.state == HJOrderStateSureRecieveGoods || self.orderInfoModel.state == HJOrderStateWaitRecieveGoods || self.orderInfoModel.state == HJOrderStateWaitPaid) {
            return 3;
        }
        
        return 4;
    }
    
    if (section == 2) {
        
        return self.orderInfoModel.goodsList.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    if (indexPath.section == 0) {
        
        HJOrderDetailOrderNumCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJOrderDetailOrderNumCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.orderNo = self.orderInfoModel.orderNo?:kEmptySrting;

        return cell;
    }
    
    if (indexPath.section == 1) {
        
        HJAdressListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJAdressListCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.addressModel = self.addressModel;
        return cell;
    }
    
    if (indexPath.section == 2) {
        
        HJOrderListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJOrderListCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        cell.actionHandlerButton.tag = indexPath.row;
        [cell.actionHandlerButton addTarget:self action:@selector(saleAfterAction:) forControlEvents:UIControlEventTouchUpInside];
        if (self.orderType == HJOrderStateFinished) {
            
            cell.haveHandler = YES;
        } else {
            
            cell.haveHandler = NO;
        }
        
        cell.orderInfoGoodslistModel = [self.orderInfoModel.goodsList objectAtIndex:indexPath.row];

        return cell;
    }
    
    if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell className]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = kFont12;
        cell.textLabel.textColor = kFontBlackColor;
        
        cell.detailTextLabel.font = kFont12;
        cell.textLabel.text = kPayTypeString;
        
        if (self.orderInfoModel.payType > 0) {
            
            cell.detailTextLabel.text = [HJPayTypeModel payTypeStringBaseOnThePayChannelType:self.orderInfoModel.payType];
        }
        return cell;
    }
    
    if (indexPath.section == 4) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell className]];
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.textLabel.font = kFont12;
        cell.textLabel.textColor = kFontBlackColor;
        
        cell.detailTextLabel.font = kFont12;
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = kDeliverTimeString;
            cell.detailTextLabel.text = self.orderInfoModel.sendName?:kEmptySrting;
        }
        if (indexPath.row == 1) {
            
            cell.textLabel.text = kSubmitOrderTimeString;
            cell.detailTextLabel.text = self.orderInfoModel.orderTime?:kEmptySrting;
        }
        if (indexPath.row == 2) {
            
            cell.textLabel.text = kPayTimeString;
            cell.detailTextLabel.text = self.orderInfoModel.payTime?:kEmptySrting;
        }
        if (indexPath.row == 3) {
            
            cell.textLabel.text = kCertainTimeString;
            cell.detailTextLabel.text = self.orderInfoModel.confirmTime?:kEmptySrting;
        }
        
        return cell;
    }
    
    if (indexPath.section == 5) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell className]];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.detailTextLabel.lh_headBaseString = @"¥";

        cell.textLabel.font = kFont16;
        cell.textLabel.textColor = kFontGrayColor;
        cell.detailTextLabel.font = kFont18;
        cell.detailTextLabel.textColor = APP_COMMON_COLOR;
        
        
        if (self.orderInfoModel.isSpecial) {
            
            if (indexPath.row == 0) {
                cell.textLabel.text = kGoodsTotalPriceString;
                cell.detailTextLabel.text = @"以线下结算为准";
                cell.detailTextLabel.font = kFont15;
            }
            
            if (indexPath.row == 1) {
                //积分
                cell.detailTextLabel.textColor = kFontGrayColor;
                cell.detailTextLabel.lh_headBaseString = @"-¥";
                cell.textLabel.text = kScoreValueString;
                NSString *preferentialMoney = self.orderInfoModel.preferentialMoney?:@"0.0";
                if ([self.orderInfoModel.preferentialMoney isEqualToString:@"0"]) {
                    preferentialMoney = @"0.0";
                }
                [cell.detailTextLabel lh_headBaseStringAddString:preferentialMoney];
            }
            
            
        } else {
            
            if (self.orderInfoModel.state == HJOrderStateSureRecieveGoods || self.orderInfoModel.state == HJOrderStateWaitRecieveGoods || self.orderInfoModel.state == HJOrderStateWaitPaid) {
                //待收货，确认收货,待支付
                if (indexPath.row == 0) {
                    //商品总价
                    cell.textLabel.text = kGoodsTotalPriceString;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f", self.orderInfoModel.fee? KIntToFloat([self.orderInfoModel.fee floatValue]):0];
                }
                
                if (indexPath.row == 1) {
                    //积分
                    cell.detailTextLabel.textColor = kFontGrayColor;
                    cell.detailTextLabel.lh_headBaseString = @"-¥";
                    cell.textLabel.text = kScoreValueString;
                    NSString *preferentialMoney = self.orderInfoModel.preferentialMoney?:@"0.0";
                    if ([self.orderInfoModel.preferentialMoney isEqualToString:@"0"]) {
                        preferentialMoney = @"0.0";
                    }
                    [cell.detailTextLabel lh_headBaseStringAddString:preferentialMoney];
                }
                if (indexPath.row == 2) {
                    //实际价格
                    cell.textLabel.text = kActualFeeString;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f", self.orderInfoModel.actualFee? KIntToFloat([self.orderInfoModel.actualFee floatValue]):0];
                    
                    //底部bar商品总价
                    self.toolBar.totalPriceLabel.text = cell.detailTextLabel.text;
                }
                
            } else {
                
                if (indexPath.row == 0) {
                    //获得积分
                    cell.textLabel.text = kGetScoreString;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@", self.orderInfoModel.getScore?:@"0"];
                }
                
                if (indexPath.row == 1) {
                    //商品总价
                    cell.textLabel.text = kGoodsTotalPriceString;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f", self.orderInfoModel.fee? KIntToFloat([self.orderInfoModel.fee floatValue]):0];
                }
                
                if (indexPath.row == 2) {
                    //积分使用
                    cell.detailTextLabel.textColor = kFontGrayColor;
                    cell.detailTextLabel.lh_headBaseString = @"-¥";
                    cell.textLabel.text = kScoreValueString;
                    NSString *preferentialMoney = self.orderInfoModel.preferentialMoney?:@"0.0";
                    if ([self.orderInfoModel.preferentialMoney isEqualToString:@"0"]) {
                        preferentialMoney = @"0.0";
                    }
                    [cell.detailTextLabel lh_headBaseStringAddString:preferentialMoney];
                }
                
                if (indexPath.row == 3) {
                    //商品实际价格
                    cell.textLabel.text = kActualFeeString;
                    cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f", self.orderInfoModel.actualFee? KIntToFloat([self.orderInfoModel.actualFee floatValue]):0];

                    //底部bar商品总价
                    self.toolBar.totalPriceLabel.text = cell.detailTextLabel.text;
                }
            }
        }
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 30;
    }
    
    if (indexPath.section == 1) {
        
        return 120;
    }
    
    if (indexPath.section == 2) {
        
        return 84;
    }
    
    if (indexPath.section == 3) {
        return 40;
    }
    
    if (indexPath.section == 4) {
        
        return 30;
    }
    
    if (indexPath.section == 5) {
        
        return 40;
    }
    
    return 0;
}


- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (section == 3) {
        return 1;
    } else {
        return 10;
    }
}

#pragma mark - Networking Request

- (void)orderInfoRequest {
    
    [[[HJOrderInfoAPI orderInfo_orderId:self.orderId]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)getPayChargeRequest_orderNo:(NSNumber *)orderNo {
    
    [[[HJGetPayChargeAPI getPayCharge_orderNo:self.orderInfoModel.orderNo.numberValue]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)cancelOrderRequest {
    
    [[[HJCancelIndentAPI cancelIndent_orderId:@(self.orderInfoModel.orderId)]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)deleteOrderActionRequest:(NSNumber *)orderId
{
    [[[HJDeleteIndentIdAPI deleteOrderWithOrderId:orderId] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)confirmIndentRequest_indentId:(NSNumber *)indentId {
    
    [[[HJConfirmIndentAPI confirmIndent_orderId:indentId]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}


#pragma mark - Setter&Getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [UITableView lh_tableViewWithFrame:CGRectMake(0, STATUS_NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-TABBAR_HEIGHT-STATUS_NAV_HEIGHT) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView lh_registerNibFromCellClassName:[HJOrderDetailOrderNumCell className]];
        [_tableView lh_registerNibFromCellClassName:[HJAdressListCell className]];
        [_tableView lh_registerNibFromCellClassName:[HJOrderListCell className]];

    }
    
    return _tableView;
}

- (HJOrderDetailToolBar *)toolBar {
    
    
    if (!_toolBar) {
        
        _toolBar =  [HJOrderDetailToolBar lh_createByFrame:CGRectMake(0, kScreenHeight-TABBAR_HEIGHT, kScreenWidth, TABBAR_HEIGHT)];
    }
    
    return _toolBar;
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
