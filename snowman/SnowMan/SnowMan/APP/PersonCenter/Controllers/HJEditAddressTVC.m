//
//  HJEditAddressTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJEditAddressTVC.h"
#import "HJTextFieldCell.h"
#import "HJProvinceTVC.h"
#import "HJEditAdressAPI.h"
#import "HJAreaListAPI.h"
#import "HJReceiptAdressAPI.h"

@interface HJEditAddressTVC ()

@property (nonatomic, strong) UIButton *saveButton;
@property (nonatomic, strong) HJAreaListModel *areaListModel;

@end

@implementation HJEditAddressTVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"编辑地址";
    
    [self.view addSubview:self.saveButton];

    [self.tableView lh_registerClassFromCellClassName:[HJTextFieldCell className]];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    //注册收货地区改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recieveNotificationChangeRecieveGoodsArea:) name:kNotification_ChangeRecieveGoodsAearCity object:nil];
    
    [self recieveNotificationChangeRecieveGoodsArea:nil];
}


#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    if ([responseObject isKindOfClass:[HJEditAdressAPI class]]) {
        if (self.addressManagerType == HJAddressManagerTypeEdit) {
            [SVProgressHUD showSuccessWithStatus:@"修改地址成功"];
        } else {
            [SVProgressHUD showSuccessWithStatus:@"添加地址成功"];
        }
        [self.navigationController lh_popVC];
    }
}

#pragma mark - Table view data Source

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 2) {
         return [super tableView:tableView cellForRowAtIndexPath:indexPath];
    }
    
    HJTextFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJTextFieldCell className]];
    cell.settingItem = [self settingItemInIndexPath:indexPath];
    if (self.addressManagerType == HJAddressManagerTypeEdit) {
        if (indexPath.row == 0) {
            cell.detailTextField.text = self.addressModel.userName;
            cell.settingItem.inputString = self.addressModel.userName;
        } else if (indexPath.row == 1) {
            cell.TextFieldCellType = HJTextFieldCellTypePhone;
            cell.detailTextField.text = self.addressModel.phone;
            cell.settingItem.inputString = self.addressModel.phone;
        } else if (indexPath.row == 3) {
            cell.detailTextField.text = self.addressModel.address;
            cell.settingItem.inputString = self.addressModel.address;
        }
    }
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.row == 2) {
        
        HJProvinceTVC *proviceTVC = [HJProvinceTVC new];
        proviceTVC.areaChooseType = HJAreaChooseTypeProvince;
        proviceTVC.untilChooseType =HJAreaChooseTypeDistrict;
        [self.navigationController lh_pushVC:proviceTVC];
    }
}

#pragma mark - Actions

- (void)saveAction {
    
    //
    NSArray *settingItems = [self allSettingItems];
    
    HJSettingItem *receiptPersonItem = settingItems[0];
    if (receiptPersonItem.inputString <= 0){
        
        [SVProgressHUD showInfoWithStatus:@"请填写收货人"];
        return;
        
    }
    
    HJSettingItem *phoneItem = settingItems[1];
    if (phoneItem.inputString <= 0){
        
        [SVProgressHUD showInfoWithStatus:@"请填写手机号码"];
        return;
        
    }
    if (![phoneItem.inputString lh_isValidateMobile]) {
        [SVProgressHUD showInfoWithStatus:@"请填写正确的手机号码"];
        return;
    }
    
    HJSettingItem *areaItem = settingItems[2];
    if (areaItem.inputString <= 0){
        
        [SVProgressHUD showInfoWithStatus:@"请填写收货地址"];
        return;
        
    }

    HJSettingItem *detailAddressItem = settingItems[3];
    if (detailAddressItem.inputString <= 0){
        
        [SVProgressHUD showInfoWithStatus:@"请填写详细地址"];
        return;
    }

    NSNumber *receiptId = (self.addressManagerType == HJAddressManagerTypeEdit) ? self.addressModel.receiptId : nil;
    NSNumber *areaId = self.areaListModel.areaId ? :nil;
    [self editAddressRequestWithReceiptId:receiptId  userName:receiptPersonItem.inputString phone:phoneItem.inputString areaId:areaId adress:detailAddressItem.inputString];
    
}

#pragma mark - Methods

- (void)recieveNotificationChangeRecieveGoodsArea:(NSNotification *)notification {
    
    //
    HJSettingItem *areaItem = [self settingItemInIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
    if (notification) {
        self.areaListModel = notification.object;
        areaItem.inputString = self.areaListModel.areaName;
        areaItem.title = [@"收货地址：" stringByAppendingString:self.areaListModel.areaName];
        [self.tableView reloadData];
    } else if (self.addressManagerType == HJAddressManagerTypeEdit) {
        areaItem.inputString = self.addressModel.areaName;
        areaItem.title = [@"收货地址：" stringByAppendingString:self.addressModel.areaName];
    }
    
}

#pragma mark - Networking Reuqest 

- (void)editAddressRequestWithReceiptId:(NSNumber *)receiptId userName:(NSString *)userName phone:(NSString *)phone areaId:(NSNumber *)areaId adress:(NSString *)adress {
    
    [[[HJEditAdressAPI editAdress_receiptId:receiptId userName:userName phone:phone areaId:areaId address:adress]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

- (NSArray *)groupTitles {
    
    return @ [@[@"收货人：",
                @"手机号码：",
                @"收货地址：",
                @"详细地址："]];
}

- (UIButton *)saveButton {
    
    if (!_saveButton) {
        
        CGFloat kButtonMargin = 30;
        
        _saveButton = [UIButton lh_buttonWithFrame:CGRectMake(kButtonMargin, 10 + 50*4, kScreenWidth - 2*kButtonMargin, 30) target:self action:@selector(saveAction) title:@"保存" titleColor:kWhiteColor font:FontNormalSize backgroundColor:APP_COMMON_COLOR];
    }
    
    return _saveButton;
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
