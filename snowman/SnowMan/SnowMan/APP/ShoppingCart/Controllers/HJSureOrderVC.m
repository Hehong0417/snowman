//
//  HJSureOrderVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSureOrderVC.h"
#import "HJAdressListCell.h"
#import "HJShoppingCartListCell.h"
#import "HJSettlementAPI.h"
#import "HJDeliverTimeAPI.h"
#import "LHCenterTableAlertView.h"
#import "HJSubmitOrderAPI.h"
#import "HJRequestParameterIdModel.h"
#import "HJAddressManagerTVC.h"
#import "HJGetPayChargeAPI.h"
#import "HJgetPayChargeAPI.h"
#import "Pingpp.h"
#import "HJOrderListCell.h"
#import "HJShopCartBrandAPI.h"
#import "HJCartSubmitOrderAPI.h"
#import "HJSaleResultVC.h"
#import "HJJudgeSepcialGoodsModel.h"

static CGFloat kShoppingCartSettleBarHeight = 50;

@interface HJSureOrderVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *payTitles;
@property (nonatomic, strong) NSArray *payIcons;
@property (nonatomic, strong) NSArray *priceSectionTitles;
@property (nonatomic, strong) HJSettlementModel *settlementModel;
@property (nonatomic, strong) UIView *settleToolBar;
@property (nonatomic, assign) BOOL isUseScore;
@property (nonatomic, strong) HJDeliverTimeModel *selectedDeliverTimeModel;
@property (nonatomic, strong) NSMutableArray *selectedPayTypes;
@property (nonatomic, assign) HJPayChannelType payChannelType;
@property (nonatomic, strong) HJRecieptAddressModel *addressModel;
@property (nonatomic, strong) HJOrderGoodslistModel *goodsListModel;
@property (nonatomic, assign) CGFloat scoreValue;
@property (nonatomic, strong) UILabel *totalPriceLabel;

@end

@implementation HJSureOrderVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"确认订单";
    //
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.settleToolBar];
    
    [self.tableView lh_registerNibFromCellClassName:[HJAdressListCell className]];
    [self.tableView lh_registerNibFromCellClassName:[HJOrderListCell className]];
    
    //
    
    if (self.selectedStandardModels) {
        
        //立即购买下单
        self.goodsListModel = [HJOrderGoodslistModel new];
        
        self.goodsListModel.goodsName = self.goodsIntroduceModel.goodsName;
        self.goodsListModel.goodsId = self.goodsIntroduceModel.goodsId;
        self.goodsListModel.goodsIco = self.goodsIntroduceModel.goodsIco;
        
        NSMutableArray *priceList = [NSMutableArray array];
        
        [self.selectedStandardModels enumerateObjectsUsingBlock:^(HJSelectStandardValueModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HJOrderPricelistModel *priceListModel = [HJOrderPricelistModel new];
            
            priceListModel.standardType = obj.standardType;
            priceListModel.currentPrice = obj.unitGoodsPrice;
            priceListModel.count = obj.goodsCount.integerValue;
            priceListModel.unitPrice = [obj.unitGoodsCount substringFromIndex:obj.unitGoodsCount.length-1];
            //特殊商品
            if (obj.unitGoodsName) {
                
                priceListModel.unitPrice = obj.unitGoodsName;
            }
            
            [priceList addObject:priceListModel];
            
        }];
        
        self.goodsListModel.priceList = priceList;

        [self.settleGoodsList addObject:self.goodsListModel];
        
    } else {
        
        //购物车下单
        [self.shopCartArray enumerateObjectsUsingBlock:^(HJGoodsListModell * _Nonnull goodsListModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HJOrderGoodslistModel *orderGoodsListModel = [HJOrderGoodslistModel new];
            
            orderGoodsListModel.goodsName = goodsListModel.goodsName;
            orderGoodsListModel.goodsId = goodsListModel.goodsId;
            orderGoodsListModel.goodsIco = goodsListModel.goodsIco;
            
            //
            orderGoodsListModel.isSpecial = goodsListModel.isSpecial;

            NSMutableArray *priceList = [NSMutableArray array];
            
            [goodsListModel.priceList enumerateObjectsUsingBlock:^(HJPriceListModel * _Nonnull priceListModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HJOrderPricelistModel *orderPriceListModel = [HJOrderPricelistModel new];
                
                orderPriceListModel.standardType = priceListModel.standardType;
                orderPriceListModel.currentPrice = priceListModel.currentPrice;
                orderPriceListModel.count = priceListModel.count;
//                orderPriceListModel.unitPrice = [obj.unitGoodsCount substringFromIndex:obj.unitGoodsCount.length-1];
                
                [priceList addObject:orderPriceListModel];

                
            }];
            
            orderGoodsListModel.priceList = priceList;
            
            [self.settleGoodsList addObject:orderGoodsListModel];
            
        }];
        
        //
        [self.boxArray enumerateObjectsUsingBlock:^(HJBoxListModel * _Nonnull boxListModel, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HJOrderGoodslistModel *orderGoodsListModel = [HJOrderGoodslistModel new];
            
            orderGoodsListModel.goodsName = boxListModel.goodsName;
            orderGoodsListModel.goodsId = boxListModel.goodsId;
            orderGoodsListModel.goodsIco = boxListModel.goodsIco;
            //
            orderGoodsListModel.isSpecial = boxListModel.isSpecial;
            
            NSMutableArray *priceList = [NSMutableArray array];
            
            [boxListModel.priceList enumerateObjectsUsingBlock:^(HJPriceListModel * _Nonnull priceListModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HJOrderPricelistModel *orderPriceListModel = [HJOrderPricelistModel new];
                
                orderPriceListModel.standardType = priceListModel.standardType;
                orderPriceListModel.currentPrice = priceListModel.currentPrice;
                orderPriceListModel.count = priceListModel.count;
                
                [priceList addObject:orderPriceListModel];
            }];
            
            orderGoodsListModel.priceList = priceList;
            
            [self.settleGoodsList addObject:orderGoodsListModel];

        }];
        
    }
    
    self.totalPriceLabel.text = self.goodsTotalPrice;
    
    [self settlementRequest];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    //
    if ([responseObject isKindOfClass:[HJSettlementAPI class]]) {
        
        HJSettlementAPI *apiModel = responseObject;
        self.settlementModel = apiModel.data;
        
        HJRecieptAddressModel *addressModel = [HJRecieptAddressModel new];
        addressModel.userName = self.settlementModel.userName;
        addressModel.phone = self.settlementModel.phone;
        addressModel.areaName = self.settlementModel.areaName;
        addressModel.receiptId = self.settlementModel.receiptId.numberValue;
        addressModel.type = self.settlementModel.type;
        addressModel.address = self.settlementModel.address;
        
        self.addressModel = addressModel;
        
        //积分抵扣
        self.scoreValue = self.settlementModel.score.floatValue*self.settlementModel.scoreUseRatio/100.0;
        
        //如果么有地址，选择地址
        if (!apiModel.data.address) {
            
            UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"你还未设置默认地址，请选择收货地址" message:nil delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
            WEAK_SELF();
            [alertView bk_setDidDismissBlock:^(UIAlertView *alert, NSInteger index) {
                
                [weakSelf goToAddressVCAction];
                
            }];
            
            [alertView show];
            
        }
        
        [self.tableView reloadData];
    }
    
    //
    if ([responseObject isKindOfClass:[HJDeliverTimeAPI class]]) {
        
        //
        HJDeliverTimeAPI *api = responseObject;
        
        NSMutableArray *deliverTimeArray = [NSMutableArray arrayWithObjects:@"请选择送货时间", nil];
        [api.data enumerateObjectsUsingBlock:^(HJDeliverTimeModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [deliverTimeArray addObject:obj.sendName];
        }];
        
        LHCenterTableAlertView *alertView = [LHCenterTableAlertView new];
        alertView.dataSource = deliverTimeArray;
        alertView.selectedRowHandler = ^(NSUInteger selectedRow, LHCenterTableAlertView *alertView) {
            
            if (selectedRow > 0) {
                
                self.selectedDeliverTimeModel = api.data[selectedRow-1];
                [self.tableView reloadData];
            }
            
        };
        [alertView showFromCenterAnimated:YES];

    }
    
    //
    if ([responseObject isKindOfClass:[HJSubmitOrderAPI class]]) {
        
        //
        HJSubmitOrderAPI *apiModel = responseObject;
        
        //调起支付
        if (self.payChannelType != HJPayChannelTypeOffLine) {
            
            [self getPayChargeRequest_orderNo:apiModel.data.orderNo.numberValue];

        }else {
            
#warning 货到付款下单成功
            NSString *orderNo = apiModel.data.orderNo;
            HJSaleResultVC *vc = [[HJSaleResultVC alloc] init];
            vc.orderNo = orderNo;
            vc.resultType = HJResultTypePurchase;
            [self.navigationController lh_pushVC:vc];
        }
    }
    
    //
    if ([responseObject isKindOfClass:[HJCartSubmitOrderAPI class]]) {
        
        //
        HJCartSubmitOrderAPI *apiModel = responseObject;
        
        //调起支付
        if (self.payChannelType != HJPayChannelTypeOffLine) {
            
            [self getPayChargeRequest_orderNo:apiModel.data.orderNo.numberValue];
            
        }else {
            
#warning 货到付款下单成功
            NSString *orderNo = apiModel.data.orderNo;
            HJSaleResultVC *vc = [[HJSaleResultVC alloc] init];
            vc.orderNo = orderNo;
            vc.resultType = HJResultTypePurchase;
            [self.navigationController lh_pushVC:vc];
        }
    }

    
    //
    if ([responseObject isKindOfClass:[HJGetPayChargeAPI class]]) {
        
        //
        HJGetPayChargeAPI *apiModel = responseObject;
        
        WEAK_SELF();
        
        /**
         *  支付宝支付
         */
        if (self.payChannelType == HJPayChannelTypeAliPay) {
            
            //支付宝支付
            [Pingpp createPayment:apiModel.data viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                
                //
                NSLog(@"completion block: %@", result);
                //
                if (error == nil) {
                    
                NSLog(@"PingppError is nil");
#warning 支付宝下单成功
                    NSString *orderNo = [apiModel.data objectForKey:@"orderNo"];
                    HJSaleResultVC *vc = [[HJSaleResultVC alloc] init];
                    vc.orderNo = orderNo;
                    vc.resultType = HJResultTypePurchase;
                    [weakSelf.navigationController pushViewController:vc animated:NO];
                    
                } else {
                    
                    NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                    [SVProgressHUD showInfoWithStatus:@"支付失败"];
                }
            }];
            
            /**
             *  微信支付
             */
            if (self.payChannelType == HJPayChannelTypeWx) {
                
                //支付宝支付
                [Pingpp createPayment:apiModel.data viewController:weakSelf appURLScheme:kUrlScheme withCompletion:^(NSString *result, PingppError *error) {
                    
                    //
                    NSLog(@"completion block: %@", result);
                    //
                    if (error == nil) {
                        
                        NSLog(@"PingppError is nil");
#warning 微信下单成功
                        NSString *orderNo = [apiModel.data objectForKey:@"orderNo"];
                        HJSaleResultVC *vc = [[HJSaleResultVC alloc] init];
                        vc.orderNo = orderNo;
                        vc.resultType = HJResultTypePurchase;
                        [self.navigationController lh_pushVC:vc];
                        
                    } else {
                        
                        NSLog(@"PingppError: code=%lu msg=%@", (unsigned  long)error.code, [error getMsg]);
                        [SVProgressHUD showInfoWithStatus:@"支付失败"];
                    }
                }];
            }

        }
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return self.settleGoodsList.count;
    }
    //
    if (section == 3) {
        
        if ([self settleGoodsListHaveSpecialGoods]) {
            
            return 1;
        }
        
        return self.payTitles.count;
    }
    
    if (section == 5) {
        
        if (self.goodsIntroduceModel.isSpecial || [HJJudgeSepcialGoodsModel judgeSpecialGoodsWithOrderGoodsListModels:self.settleGoodsList]) {
            
            return 1;
        }
        
        return 3;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        HJAdressListCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[HJAdressListCell className]];
        cell.addressModel = self.addressModel;
        cell.showMarginView = YES;
        cell.selectionStyle = UITableViewCellSelectionStyleNone;

        return cell;
    }
    
    if (indexPath.section == 1) {
        
        HJOrderListCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[HJOrderListCell className]];
        cell.orderGoodsListModel = self.settleGoodsList[indexPath.row];
        
        return cell;
    }
    
    if (indexPath.section >= 2) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
        
        if (!cell) {
            
            cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:[UITableViewCell className]];
        }
        
    if (indexPath.section == 2) {
        
        cell.textLabel.text = @"配送时间";
        cell.detailTextLabel.text = self.selectedDeliverTimeModel.sendName;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
        return cell;
    }
    
    if (indexPath.section == 3) {
        
        //支付section
        NSNumber *selectedPayType = self.selectedPayTypes[indexPath.row];
        if (selectedPayType.boolValue) {
            
            cell.accessoryView = [UIImageView lh_imageViewWithFrame:CGRectMake(0, 0, 13, 13) image:[UIImage imageNamed:@"ic_b3_01"]];
        } else {
            
            cell.accessoryView = nil;
        }
        
        [cell lh_setSeparatorInsetZero];
        
        UIImage *image = [UIImage imageNamed:[self.payIcons objectAtIndex:indexPath.row]];
        image = [image lh_scaleImageWithSize:CGSizeMake(21.5, 21.5)];
        
        cell.imageView.image = image ;
        
        cell.textLabel.text = [self.payTitles objectAtIndex:indexPath.row];
        
        if ([self settleGoodsListHaveSpecialGoods]) {
            
        UIImage *image = [UIImage imageNamed:[self.payIcons lastObject]];
        image = [image lh_scaleImageWithSize:CGSizeMake(21.5, 21.5)];
            
        cell.imageView.image = image ;

        cell.textLabel.text = [self.payTitles lastObject];
        }
        
        return cell;
    }
    
    if (indexPath.section == 4) {
        
        cell.textLabel.text = [NSString stringWithFormat:@"积分抵扣（可用积分%@）",self.settlementModel.score?:@"0"];
        
        //积分按钮
        UISwitch *switchButton = [UISwitch new];
        cell.accessoryView = switchButton;
        [switchButton bk_addEventHandler:^(UISwitch *sender) {
            
//            //货到付款不可使用积分
//            if ([self settleGoodsListHaveSpecialGoods]) {
//                
//                [SVProgressHUD showInfoWithStatus:@"货到付款不可使用积分"];
//                sender.on = NO;
//                
//                return ;
//            }
            
            if (self.payChannelType == HJPayChannelTypeOffLine) {
              
                if (self.scoreValue < 1.0) {
                    
                    [SVProgressHUD showInfoWithStatus:@"您的积分未达到使用要求，请看积分使用规则！"];
                    sender.on = NO;

                    return
                    ;
                } else {
                    
                    self.scoreValue = floorf(self.scoreValue);
                }
                
                //特殊商品只有货到付款使用积分
                if ([self settleGoodsListHaveSpecialGoods]) {
                    
                    
                    self.scoreValue = floorf(self.scoreValue);
                }
            }
            
            self.isUseScore = !self.isUseScore;

            [self.tableView reloadData];
            
        } forControlEvents:UIControlEventValueChanged];
        //积分开关
        switchButton.on = self.isUseScore;
        
        //积分值为0开关不可以使用
        if (self.scoreValue <= 0) {
            
            switchButton.enabled = NO;
        }
        
        if (self.isUseScore) {
            
            if (self.payChannelType == HJPayChannelTypeOffLine) {
                
                //线下货到付款
                self.scoreValue = floorf(self.scoreValue);

            } else {
                //线上付款
                self.scoreValue = self.settlementModel.score.floatValue*self.settlementModel.scoreUseRatio/100.0;

            }
            
        }
        
        return cell;
    }
    
    if (indexPath.section == 5) {
        
        cell.textLabel.text = self.priceSectionTitles[indexPath.row];
        cell.accessoryView = nil;
        
        if (indexPath.row == 0) {
            
            cell.detailTextLabel.textColor = APP_COMMON_COLOR;
            cell.detailTextLabel.text = self.goodsTotalPrice;
        }
        
        if (indexPath.row == 1) {
            
            cell.detailTextLabel.textColor = kGrayColor;
            cell.detailTextLabel.text = [NSString stringWithFormat:@"-¥%.2f",self.isUseScore?self.scoreValue:0];
        }
        
        if (indexPath.row == 2) {
            
            cell.detailTextLabel.textColor = APP_COMMON_COLOR;
            NSString *priceString = [self.goodsTotalPrice substringFromIndex:1];
            CGFloat actualFee = (priceString.floatValue - (self.isUseScore?self.scoreValue:0))?:0;
            cell.detailTextLabel.text = actualFee>0?[NSString stringWithFormat:@"¥%.2f",actualFee]:@"0.01";
            
            //settleBar总价
            self.totalPriceLabel.text = [self settleGoodsListHaveSpecialGoods]?@"以线下结算为准":cell.detailTextLabel.text;
        }

        return cell;
    }
        
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
        return 120;
    }
    
    if (indexPath.section == 1) {
        
        return 105;
    }
    
    if (indexPath.section >= 2 || indexPath.section <= 4) {
        
        return 44;
    }
    
    if (indexPath.section == 5) {
        
        return 30;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 0) {
        
        return 0.1;
    }
    
    if (section == 3) {
        
        return 40;
    }
    
    return 10;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 3) {
    
    UIView *payHeaderView = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, 40) backColor:kWhiteColor];
    
    UILabel *payLabel = [UILabel lh_labelWithFrame:CGRectMake(15, 0, 200, 40) text:@"选择支付方式" textColor:kFontBlackColor font:FontNormalSize textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    [payHeaderView addSubview:payLabel];
    
    return payHeaderView;
    }
    
    return nil;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    if (section == 2) {
        
        return 10;
    }
    
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        
        [self goToAddressVCAction];
    }
    
    if (indexPath.section == 2) {
        
        //配送时间弹框
        [self deliverTimeRequest];
        
    }
    
    if (indexPath.section == 3) {
        
        NSNumber *selectedPayType = self.selectedPayTypes[indexPath.row];
        if (selectedPayType.boolValue == NO) {
            
            [self.selectedPayTypes replaceObjectAtIndex:indexPath.row withObject:@(!selectedPayType.boolValue)];
            NSMutableArray *selectedPayTypes = [NSMutableArray array];
            [self.selectedPayTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (idx == indexPath.row) {
                    
                    [selectedPayTypes addObject:@YES];
                } else {
                    
                    [selectedPayTypes addObject:@NO];
                }
            }];
            
            self.selectedPayTypes = selectedPayTypes;
            
            //支付类型
            __block NSUInteger payType;
            
            [self.selectedPayTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                NSNumber *selectedPayType = obj;
                if (selectedPayType.boolValue == YES) {
                    
                    payType =  idx == 1 ? 3 :idx + 1;//提交订单支付类型，第二个是货到付款
                }
            }];
            
            if ([self settleGoodsListHaveSpecialGoods]) {
                
                payType = HJPayChannelTypeOffLine;
            }
            
            self.payChannelType = payType;

        }
        
        [self.tableView reloadData];
    }
    
}

#pragma mark - Actions

- (void)submitOrderAction {
    
    //
    if (self.addressModel == nil) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择收货地址"];
        
        return;
    }
    
    if (self.goodsListModel) {
        
        [self submitOrderRequest];
  
    } else {
        
        [self cartSubmitOrderRequest];
    }
    
}

- (void)goToAddressVCAction {
    
    HJAddressManagerTVC *addressManagerTVC = [HJAddressManagerTVC new];
    //
    addressManagerTVC.selectedAddressHandler = ^(HJRecieptAddressModel *addressModel) {
        
        self.addressModel = addressModel;
        
        [self.tableView reloadData];
    };
    
    [self.navigationController lh_pushVC:addressManagerTVC];
}

#pragma mark - Methods

- (BOOL)settleGoodsListHaveSpecialGoods {
    
    return self.goodsIntroduceModel.isSpecial || [HJJudgeSepcialGoodsModel judgeSpecialGoodsWithOrderGoodsListModels:self.settleGoodsList];
}


#pragma mark - Networking Request

- (void)settlementRequest {
    
    [[[HJSettlementAPI settlement]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)deliverTimeRequest {
    
    [[[HJDeliverTimeAPI deliverTime]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)cartSubmitOrderRequest {
    
    __block NSUInteger payType;
    
    [self.selectedPayTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *selectedPayType = obj;
        if (selectedPayType.boolValue == YES) {
            
            payType =  idx == 1 ? 3 :idx + 1;//提交订单支付类型，第二个是货到付款
        }
    }];
    
    NSUInteger selectedOrderType;
    if (payType == HJPayChannelTypeOffLine) {
        
        selectedOrderType = 1;//货到付款
    } else {
        
        selectedOrderType = 0;//线上
    }
    //
    if (!self.selectedDeliverTimeModel) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择配送时间"];
        
        return;
    }
    
    if ([self settleGoodsListHaveSpecialGoods]) {
        
        //特殊商品
        payType = HJPayChannelTypeOffLine;
        selectedOrderType = 1;//货到付款
    }
    
//    //
//    if (payType == HJPayChannelTypeOffLine && self.isUseScore == YES) {
//        
//        [SVProgressHUD showInfoWithStatus:@"货到付款不可使用积分"];
//        
//        return;
//    }
    
    self.payChannelType = payType;
    
    //下单时间判断提示
    if (![self isBetweenFromHour:7 toHour:19]) {
        
        [SVProgressHUD showInfoWithStatus:@"当前是休息时间，您的订单将在上班时间尽快送达！"];
        
    }
    
    NSMutableArray *shopCartArrayParameters = [NSMutableArray array];
    
    [self.shopCartArray enumerateObjectsUsingBlock:^(HJGoodsListModell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [shopCartArrayParameters addObject:@(obj.shopCartId)];
        
    }];
    
    NSMutableArray *boxArrayParameters = [NSMutableArray array];
    
    [self.boxArray enumerateObjectsUsingBlock:^(HJBoxListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        [boxArrayParameters addObject:@(obj.boxId)];
    }];
    
    self.payChannelType = payType;

    [[[HJCartSubmitOrderAPI  cartSubmitOrder_receiptName:[self.addressModel.areaName stringByAppendingString:self.addressModel.address] sendId:@(self.selectedDeliverTimeModel.sendId) shopCartArray:shopCartArrayParameters.jsonStringEncoded boxArray:boxArrayParameters.jsonStringEncoded isUseScore:@(self.isUseScore) payType:@(payType) orderType:@(selectedOrderType) consignee:self.addressModel.userName consigneePhone:self.addressModel.phone isSpecial:@([self settleGoodsListHaveSpecialGoods])]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

/**
 * @brief 判断当前时间是否在fromHour和toHour之间。如，fromHour=8，toHour=23时，即为判断当前时间是否在8:00-23:00之间
 */
- (BOOL)isBetweenFromHour:(NSInteger)fromHour toHour:(NSInteger)toHour
{
    NSDate *dateFrom = [self getCustomDateWithHour:fromHour];
    NSDate *dateTo = [self getCustomDateWithHour:toHour];
    
    NSDate *currentDate = [NSDate date];
    
    if ([currentDate compare:dateFrom]==NSOrderedDescending && [currentDate compare:dateTo]==NSOrderedAscending)
    {
        NSLog(@"该时间在 %ld:00-%ld:00 之间！", (long)fromHour, (long)toHour);
        return YES;
    }
    return NO;
}

/**
 * @brief 生成当天的某个点（返回的是伦敦时间，可直接与当前时间[NSDate date]比较）
 * @param hour 如hour为“8”，就是上午8:00（本地时间）
 */
- (NSDate *)getCustomDateWithHour:(NSInteger)hour
{
    //获取当前时间
    NSDate *currentDate = [NSDate date];
    NSCalendar *currentCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDateComponents *currentComps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
    
    currentComps = [currentCalendar components:unitFlags fromDate:currentDate];
    
    //设置当天的某个点
    NSDateComponents *resultComps = [[NSDateComponents alloc] init];
    [resultComps setYear:[currentComps year]];
    [resultComps setMonth:[currentComps month]];
    [resultComps setDay:[currentComps day]];
    [resultComps setHour:hour];
    
    NSCalendar *resultCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    return [resultCalendar dateFromComponents:resultComps];
}

- (void)submitOrderRequest {
    
    __block NSUInteger payType;
    
    [self.selectedPayTypes enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        NSNumber *selectedPayType = obj;
        if (selectedPayType.boolValue == YES) {
            
            payType =  idx == 1 ? 3 :idx + 1;//提交订单支付类型，第二个是货到付款
        }
    }];
    
    NSUInteger selectedOrderType;
    if (payType == HJPayChannelTypeOffLine) {
        
        selectedOrderType = 1;//货到付款
    } else {
        
        selectedOrderType = 0;//线上
    }
    //
    if (!self.selectedDeliverTimeModel) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择配送时间"];
        
        return;
    }
    
    if (self.goodsIntroduceModel.isSpecial) {
        
        //特殊商品
        payType = HJPayChannelTypeOffLine;
        selectedOrderType = 1;//货到付款
    }
    
    //
//    if (payType == HJPayChannelTypeOffLine && self.isUseScore == YES) {
//        
//        [SVProgressHUD showInfoWithStatus:@"货到付款不可使用积分"];
//        
//        return;
//    }
    
    self.payChannelType = payType;
    
    //下单时间判断提示
    if (![self isBetweenFromHour:7 toHour:19]) {
        
        [SVProgressHUD showInfoWithStatus:@"当前是休息时间，您的订单将在上班时间尽快送达！"];
        
    }

    [[[HJSubmitOrderAPI submitOrder_receiptName:[self.addressModel.areaName stringByAppendingString:self.addressModel.address] sendId:@(self.selectedDeliverTimeModel.sendId) goodsId:@(self.goodsIntroduceModel.goodsId) parameterList:[HJRequestParameterIdModel parameterListStringFromStandardValueModelArray:self.selectedStandardModels] isUseScore:@(self.isUseScore) payType:@(self.payChannelType) orderType:@(selectedOrderType) consignee:self.addressModel.userName consigneePhone:self.addressModel.phone isSpecial:@([self settleGoodsListHaveSpecialGoods])]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)getPayChargeRequest_orderNo:(NSNumber *)orderNo {
    
    [[[HJGetPayChargeAPI getPayCharge_orderNo:orderNo]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [UITableView lh_tableViewWithFrame:CGRectMake(0, STATUS_NAV_HEIGHT, kScreenWidth, kScreenHeight - STATUS_NAV_HEIGHT - kShoppingCartSettleBarHeight) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    }
    
    return _tableView;
}

- (NSArray *)payTitles {
    
    if (!_payTitles) {
        _payTitles = @[
                       @"支付宝支付",
                       @"货到付款"];
    }
    return _payTitles;
}

- (NSArray *)payIcons {
    
    if (!_payIcons) {
        _payIcons = @[
                       @"支付宝支付",
                       @"ic_b12_huodao"];
    }
    
    return _payIcons;
}

- (NSArray *)priceSectionTitles {
    
    if (!_priceSectionTitles) {
        
        _priceSectionTitles = @[@"商品总价",
                      @"积分抵扣",
                      @"实付款"];
 
    }
    
    return _priceSectionTitles;
}

- (UIView *)settleToolBar {
    
    if (!_settleToolBar) {
        
        _settleToolBar = [UIView lh_viewWithFrame:CGRectMake(0, kScreenHeight-kShoppingCartSettleBarHeight, kScreenWidth, kShoppingCartSettleBarHeight) backColor:kWhiteColor];
        
        UILabel *pricePrefixLabel = [UILabel lh_labelWithFrame:CGRectMake(10, 10, 45, 29) text:@"合计：" textColor:kBlackColor font:FontNormalSize textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
        [_settleToolBar addSubview:pricePrefixLabel];
        
        UILabel *totalPriceLabel = [UILabel lh_labelWithFrame:CGRectMake(pricePrefixLabel.lh_right, 10,200, 29) text:@"" textColor:APP_COMMON_COLOR font:FontNormalSize textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
        [_settleToolBar addSubview:totalPriceLabel];
        self.totalPriceLabel = totalPriceLabel;

        
        UIButton *submitOrderButton = [UIButton lh_buttonWithFrame:CGRectMake(_settleToolBar.lh_width-150, 0, 150, _settleToolBar.lh_height) target:self action:@selector(submitOrderAction) title:@"提交订单" titleColor:kWhiteColor font:FontNormalSize backgroundColor:APP_COMMON_COLOR];
        [_settleToolBar addSubview:submitOrderButton];
    }
    
    return _settleToolBar;
}

- (NSMutableArray *)selectedPayTypes {
    
    if (!_selectedPayTypes) {
        
        _selectedPayTypes = [NSMutableArray array];
        
        for (int i = 0; i<3; i++) {
            
            [_selectedPayTypes addObject:i==0? @YES : @NO];
        }
    }
    
    return _selectedPayTypes;
}

- (NSMutableArray *)settleGoodsList {
    
    if (!_settleGoodsList) {
        
        _settleGoodsList = [NSMutableArray array];
    }
    
    return _settleGoodsList;
}

@end
