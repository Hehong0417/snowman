//
//  HJAddressManagerTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAddressManagerTVC.h"
#import "HJAdressListCell.h"
#import "HJEditAddressTVC.h"
#import "HJReceiptAdressAPI.h"
#import "HJDefaultAdressAPI.h"
#import "HJDeleteAdressAPI.h"
#import "HJExitLoginView.h"

static CGFloat kAddAddressBarHeight = 60;

@interface HJAddressManagerTVC () <UITableViewRefreshHandlerDelegate, UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, weak) HJExitLoginView *deleteAddressWarnView;
@property (nonatomic, strong) UIView *addAddressBar;
@property (nonatomic, strong) UITableView *tableView;
@end

@implementation HJAddressManagerTVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"收货地址管理";
    
    
//    UIButton *navRightButton = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 44, 44) target:self action:@selector(addAddressAction:) title:@"新增" titleColor:kWhiteColor font:FontNormalSize backgroundColor:kClearColor];
    
//    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:navRightButton];
    
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.addAddressBar];
    [self.tableView lh_registerNibFromCellClassName:[HJAdressListCell className]];
    self.tableView.rowHeight = 160;
    
    [self.tableView lh_addHeaderHandleEvent:self beginRefreshing:YES];
    [self.tableView lh_addFooterHandleEvent:self];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self recieptAddressRequest];
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    if ([responseObject isKindOfClass:[HJReceiptAdressAPI class]]) {
        
        HJReceiptAdressAPI *apiModel = responseObject;
        
        [self.tableView lh_setRefreshDataSource:apiModel.data];
    }
    
    //
    if ([responseObject isKindOfClass:[HJDefaultAdressAPI class]]) {
        
        [SVProgressHUD showSuccessWithStatus:@"设置默认地址成功"];
        [self recieptAddressRequest];
        
    }
    
    if ([responseObject isKindOfClass:[HJDeleteAdressAPI class]]) {
        [SVProgressHUD showSuccessWithStatus:@"删除地址成功"];
        [self.tableView.refreshHeader beginRefreshing];
    }
}

#pragma mark - UITableViewRefreshHandlerDelegate
- (void)tableViewRefreshDataHandle:(UITableView *)tableView {
    
    [self recieptAddressRequest];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return tableView.refreshDataSource.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJAdressListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJAdressListCell className]];
    cell.canEdit = YES;
    //
    HJRecieptAddressModel *addressModel = self.tableView.refreshDataSource[indexPath.section];
    cell.addressModel = addressModel;
    cell.showDefault = NO;
    cell.deleteAddressButton.tag = indexPath.section;
    cell.editAddressButton.tag = indexPath.section;
    cell.defaultAddressButton.tag = indexPath.section;
    
    //设置默认地址时确定哪个地址模型
    [cell.deleteAddressButton addTarget:self action:@selector(deleteAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.editAddressButton addTarget:self action:@selector(editAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    [cell.defaultAddressButton addTarget:self action:@selector(defaultAddressAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 5;
}

#pragma mark - Table view delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    //
    if (self.selectedAddressHandler) {
        
    HJRecieptAddressModel *addressModel = self.tableView.refreshDataSource[indexPath.section];
    self.selectedAddressHandler(addressModel);
    
    [self.navigationController lh_popVC];
    }
}

#pragma mark - Actions

- (void)addAddressAction:(UIButton *)button
{
    HJEditAddressTVC *editAddressTVC = [HJEditAddressTVC new];
    [self.navigationController lh_pushVC:editAddressTVC];
}

- (void)editAddressAction:(UIButton *)button {
    HJRecieptAddressModel *addressModel = self.tableView.refreshDataSource[button.tag];
    HJEditAddressTVC *editAddressTVC = [HJEditAddressTVC new];
    editAddressTVC.addressModel = addressModel;
    editAddressTVC.addressManagerType = HJAddressManagerTypeEdit;
    [self.navigationController lh_pushVC:editAddressTVC];
}

- (void)deleteAddressAction:(UIButton *)button {
    HJExitLoginView *deleteAddressWarnView = [HJExitLoginView exitLoginViewWithWarnTitle:@"您确定删除地址吗？"];
    [self.view addSubview:deleteAddressWarnView];
    self.deleteAddressWarnView = deleteAddressWarnView;
    WEAK_SELF();
    deleteAddressWarnView.certanBlock = ^{
        [weakSelf.deleteAddressWarnView removeFromSuperview];
        HJRecieptAddressModel *addressModel = weakSelf.tableView.refreshDataSource[button.tag];
        [weakSelf deleteAddressRequestWithReceiptId:addressModel.receiptId];
    };
    
}

- (void)defaultAddressAction:(UIButton *)button {
    
    HJRecieptAddressModel *addressModel = self.tableView.refreshDataSource[button.tag];
    
    [self defaultAddressRequest:addressModel.receiptId];

}

#pragma mark - Methods



#pragma mark - Networking Request

- (void)recieptAddressRequest {
    
    [[[HJReceiptAdressAPI receiptAdress_page:@(self.tableView.pageNo) rows:@(self.tableView.pageSize)]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)defaultAddressRequest:(NSNumber *)receiptId {
    
    [[[HJDefaultAdressAPI defaultAdress_receiptId:receiptId]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)deleteAddressRequestWithReceiptId:(NSNumber *)receiptId
{
    [[[HJDeleteAdressAPI deleteAdress_receiptId:receiptId] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [UITableView lh_tableViewWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight - kAddAddressBarHeight ) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    }
    return _tableView;
}

- (UIView *)addAddressBar
{
    if (!_addAddressBar) {
        _addAddressBar = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight - kAddAddressBarHeight, kScreenWidth, kAddAddressBarHeight)];
        UIButton *addAddressBtn = [UIButton lh_buttonWithFrame:CGRectMake(50, 10, SCREEN_WIDTH - 100, 40) target:self action:@selector(addAddressAction:) title:@"新增收货地址" titleColor:kWhiteColor font:FONT(17) backgroundColor:APP_COMMON_COLOR];
        addAddressBtn.layer.cornerRadius = kSmallCornerRadius;
        addAddressBtn.layer.masksToBounds = YES;
        [_addAddressBar addSubview:addAddressBtn];
    }
    return _addAddressBar;
}

@end
