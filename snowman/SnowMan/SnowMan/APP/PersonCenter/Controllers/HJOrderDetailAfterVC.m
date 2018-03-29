//
//  HJOrderDetailAfterVC.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderDetailAfterVC.h"
#import "HJOrderDetailToolBar.h"
#import "HJAdressListCell.h"
#import "HJOrderListCell.h"
#import "HJAfterSalesInfoAPI.h"
#import "HJAfterContentCell.h"
#import "HJReceiptAdressAPI.h"
#import "HJPayTypeModel.h"
#import "HJDeleteIndentIdAPI.h"
#import "HJDeleteAfterOrderAPI.h"
#import "HJSaleResultVC.h"
#import "HJJudgeSepcialGoodsModel.h"

static NSString * const kOrderNoString = @"订单编号";
static NSString * const kDeliverTimeString = @"配送时间";
static NSString * const kSubmitOrderTimeString = @"下单时间";
static NSString * const kPayTimeString = @"付款时间";
static NSString * const kCertainTimeString = @"确认时间";
static NSString * const kReturnTimeString = @"退货时间";
static NSString * const kPayTypeString = @"支付方式";
static NSString * const kGoodsTotalPriceString = @"商品总价";



@interface HJOrderDetailAfterVC ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HJOrderDetailToolBar *toolBar;
@property (nonatomic, strong) HJAfterSalesInfoModel *afterSalesInfoModel;
@property (nonatomic, strong) HJRecieptAddressModel *addressModel;
@end

@implementation HJOrderDetailAfterVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"订单详情";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolBar];
    
    WEAK_SELF();
    self.toolBar.actionButtonHandler = ^(UIButton *actionButton) {
        
        if ([actionButton.titleLabel.text isEqualToString:kDeleteOrderString]) {
            [weakSelf deleteReturnOrderAction];
        }
    };
    
    
    [self AfterSalesInfoRequest];
}

#pragma mark - HJDataHandlerProtocol
- (void)netWorkRequestSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJAfterSalesInfoAPI class]]) {
        HJAfterSalesInfoAPI *api = responseObject;
        self.afterSalesInfoModel = api.data;
        self.toolBar.afterSalesInfoModel = api.data;
        [self setAddressModelInfo];
        [self.tableView reloadData];
    }
}

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJDeleteAfterOrderAPI class]]) {
        HJSaleResultVC *saleResultVC = [[HJSaleResultVC alloc] init];
        saleResultVC.resultType = HJResultTypeDelete;
        [self.navigationController lh_pushVC:saleResultVC];
    }
}

#pragma mark - Actions
- (void)deleteReturnOrderAction
{
    [self deleteOrderActionRequest:@(self.refundId)];
}

#pragma mark - method
- (void)setAddressModelInfo
{
    self.addressModel.userName = self.afterSalesInfoModel.consignee;
    self.addressModel.phone = self.afterSalesInfoModel.consigneePhone;
    self.addressModel.address = self.afterSalesInfoModel.receiptName;
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 4) {
        
        return 6;
    }
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HJAfterContentCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJAfterContentCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.afterSalesInfoModel = self.afterSalesInfoModel;
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
        cell.actionHandlerButton.tag = indexPath.row;
        cell.afterSalesInfoModel = self.afterSalesInfoModel;
        return cell;
    }
    
    if (indexPath.section == 3) {
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell className]];
        }
        
        cell.textLabel.font = kFont12;
        cell.textLabel.textColor = kFontBlackColor;
        cell.textLabel.text = kPayTypeString;
        cell.detailTextLabel.font = kFont12;
        cell.detailTextLabel.text = self.afterSalesInfoModel.orderNo?:kEmptySrting;
        
        if (self.afterSalesInfoModel.payType > 0) {
            
            cell.detailTextLabel.text = [HJPayTypeModel payTypeStringBaseOnThePayChannelType:self.afterSalesInfoModel.payType];
        }
        return cell;
        
    }
    
    if (indexPath.section == 4) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell className]];
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        cell.textLabel.font = kFont12;
        cell.textLabel.textColor = kFontBlackColor;
        
        cell.detailTextLabel.font = kFont12;
        
        if (indexPath.row == 0) {
            
            cell.textLabel.text = kOrderNoString;
            cell.detailTextLabel.text = self.afterSalesInfoModel.orderNo?:kEmptySrting;
        }
        if (indexPath.row == 1) {
            
            cell.textLabel.text = kDeliverTimeString;
            cell.detailTextLabel.text = self.afterSalesInfoModel.sendName?:kEmptySrting;
        }
        if (indexPath.row == 2) {
            cell.textLabel.text = kSubmitOrderTimeString;
            cell.detailTextLabel.text = self.afterSalesInfoModel.orderTime?:kEmptySrting;
        }
        if (indexPath.row == 3) {
            cell.textLabel.text = kPayTimeString;
            cell.detailTextLabel.text = self.afterSalesInfoModel.payTime?:kEmptySrting;
        }
        if (indexPath.row == 4) {
            cell.textLabel.text = kCertainTimeString;
            cell.detailTextLabel.text = self.afterSalesInfoModel.confirmTime?:kEmptySrting;
        }
        if (indexPath.row == 5) {
            cell.textLabel.text = kReturnTimeString;
            cell.detailTextLabel.text = self.afterSalesInfoModel.refundTime?:kEmptySrting;
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
        
        cell.detailTextLabel.font = kFont16;
        cell.detailTextLabel.textColor = APP_COMMON_COLOR;
        
        cell.textLabel.text = kGoodsTotalPriceString;
        
        if (self.afterSalesInfoModel.isSpecial) {
            cell.detailTextLabel.text = @"以线下结算为准";
            
        } else {
            cell.detailTextLabel.text = [NSString stringWithFormat:@"￥%.2f", self.afterSalesInfoModel.fee ? KIntToFloat([self.afterSalesInfoModel.fee floatValue]):0];
        }
        
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 140;
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

- (void)AfterSalesInfoRequest
{
    [[[HJAfterSalesInfoAPI afterSalesInfoRequestWithRefundId:@(self.refundId)] netWorkClient] postRequestInView:self.view networkRequestSuccessDataHandler:self];
}

- (void)deleteOrderActionRequest:(NSNumber *)refundId
{
    [[[HJDeleteAfterOrderAPI deleteAfterOrderWithRefundId:refundId] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [UITableView lh_tableViewWithFrame:CGRectMake(0, STATUS_NAV_HEIGHT, SCREEN_WIDTH, SCREEN_HEIGHT-STATUS_NAV_HEIGHT - TABBAR_HEIGHT) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [_tableView lh_registerNibFromCellClassName:[HJAfterContentCell className]];
        [_tableView lh_registerNibFromCellClassName:[HJAdressListCell className]];
        [_tableView lh_registerNibFromCellClassName:[HJOrderListCell className]];
        
    }
    return _tableView;
}

- (HJOrderDetailToolBar *)toolBar {
    
    
    if (!_toolBar) {
        
        _toolBar =  [HJOrderDetailToolBar lh_createByFrame:CGRectMake(0, kScreenHeight-TABBAR_HEIGHT, kScreenWidth, TABBAR_HEIGHT)];
        _toolBar.orderState = HJOrderStateDeleteAfter;
    }
    
    return _toolBar;
}

- (HJRecieptAddressModel *)addressModel
{
    if (!_addressModel) {
        _addressModel = [[HJRecieptAddressModel alloc] init];
    }
    return _addressModel;
}

@end
