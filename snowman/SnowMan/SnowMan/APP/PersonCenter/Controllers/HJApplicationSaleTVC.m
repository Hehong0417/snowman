//
//  HJApplicationSaleTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJApplicationSaleTVC.h"
#import "HJOrderListCell.h"
#import "HJOrderInfoAPI.h"
#import "HJOrderListSectionHeaderView.h"
#import "HJAppliactionSaleFooterView.h"
#import "HJApplicationSaleAPI.h"
#import "HJSaleResultVC.h"

#define KKeyBoardHeight 216

@interface HJApplicationSaleTVC () <HJAppliactionSaleFooterViewDelegate, UITextViewDelegate>

@property (nonatomic, strong) HJAppliactionSaleFooterView *footerView;

@end

@implementation HJApplicationSaleTVC

#pragma mark - LifeCycle

- (instancetype)init {
    
    return [self initWithStyle:UITableViewStyleGrouped];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"申请售后";
    
    self.tableView.backgroundColor = kWhiteColor;
    [self.tableView lh_registerNibFromCellClassName:[HJOrderListCell className]];
    
    self.tableView.tableFooterView = self.footerView;
    self.footerView.contentTextView.delegate = self;
}


#pragma mark - HJDataHandlerProtocol
- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJApplicationSaleAPI class]]) {
        HJSaleResultVC *saleResultVC = [[HJSaleResultVC alloc] init];
        saleResultVC.orderNo = self.orderNo;
        saleResultVC.resultType = HJResultTypeSale;
        [self.navigationController lh_pushVC:saleResultVC];
    }
}


#pragma mark - Actions


#pragma mark - Methods

#pragma mark -Delegate Methods
- (void)saleFooterViewDidClickSubmitButton:(HJAppliactionSaleFooterView *)saleFooterView phone:(NSString *)phone saleType:(NSInteger)saleType content:(NSString *)content
{
    if ([phone lh_isEmpty]){
        [SVProgressHUD showInfoWithStatus:@"请填写手机号码"];
        return;
    } else if (![phone lh_isValidateMobile]) {
        [SVProgressHUD showInfoWithStatus:@"请输入正确的手机号"];
        return;
    }
    
    [self.footerView.contentTextView resignFirstResponder];

    
    if (!self.footerView.selectedApplicationReason) {
        
        [SVProgressHUD showInfoWithStatus:@"请选择售后类型"];
        return;
    }
    
    [self applicationSaleAPIWithPhone:phone saleType:saleType content:content];
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    [UIView animateWithDuration:KAnimationTime animations:^{
        self.view.lh_top = self.view.lh_top - KKeyBoardHeight;
    }];
}

- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:KAnimationTime animations:^{
        self.view.lh_top = self.view.lh_top + KKeyBoardHeight;
    }];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJOrderListCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[HJOrderListCell className]];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.salegoodsListModel) {
        cell.orderGoodsListModel = self.salegoodsListModel;
    } else if (self.orderInfoGoodslistModel) {
        cell.orderInfoGoodslistModel = self.orderInfoGoodslistModel;
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 84;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 40;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *headerView = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, 40) backColor:kVCBackGroundColor];
    UILabel *orderNoLabel = [UILabel lh_labelWithFrame:CGRectMake(15, 0, 200, headerView.lh_height) text:@"" textColor:kGrayColor font:FontSmallSize textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
    orderNoLabel.text = [NSString stringWithFormat:@"订单编号：%@", self.orderNo];
    
    [headerView addSubview:orderNoLabel];
    
    return headerView;
}

#pragma mark - delegate method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}


#pragma mark - NetWorking Request




- (void)applicationSaleAPIWithPhone:(NSString *)phone saleType:(HJSaleType)saleType content:(NSString *)content
{
    NSNumber *ID = [[NSNumber alloc] init];
    if (self.salegoodsListModel.ID) {
        ID = @(self.salegoodsListModel.ID);
        
    } else if (self.orderInfoGoodslistModel.ID) {
        ID = @(self.orderInfoGoodslistModel.ID);
    }
    
    [[[HJApplicationSaleAPI applicationSale_orderId:@(self.orderId) ID:ID type:@(saleType) phone:phone cause:content] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

- (HJAppliactionSaleFooterView *)footerView {
    
    if (!_footerView) {
        
        _footerView = [HJAppliactionSaleFooterView lh_createByFrame:CGRectMake(0, 0, kScreenWidth, 320)];
        _footerView.delegate = self;
    }
    
    return _footerView;
}


@end
