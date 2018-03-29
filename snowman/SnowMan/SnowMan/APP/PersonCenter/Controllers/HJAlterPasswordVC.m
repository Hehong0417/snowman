//
//  HJAlterPasswordVC.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAlterPasswordVC.h"
#import "HJUpdatePwdAPI.h"

@interface HJAlterPasswordVC ()
@property (nonatomic, weak) UITextField *oldPwdTextField;
@property (nonatomic, weak) UITextField *NewPwdTextField;
@property (nonatomic, weak) UIButton *saveButton;
@end

@implementation HJAlterPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"修改密码";
    [self setupUI];
}

- (void)setupUI
{
    UITextField *oldPwdTextField = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:@"请输入旧密码" font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    oldPwdTextField.secureTextEntry = YES;
    oldPwdTextField.layer.cornerRadius = 3;
    [self.view addSubview:oldPwdTextField];
    self.oldPwdTextField = oldPwdTextField;
    
    UITextField *NewPwdTextField = [UITextField lh_textFieldWithFrame:CGRectZero placeholder:@"请输入新密码" font:FONT(14) textAlignment:NSTextAlignmentLeft backgroundColor:kWhiteColor];
    NewPwdTextField.secureTextEntry = YES;
    NewPwdTextField.layer.cornerRadius = 3;
    [self.view addSubview:NewPwdTextField];
    self.NewPwdTextField = NewPwdTextField;
    
    UIButton *saveButton = [UIButton lh_buttonWithFrame:CGRectZero target:self action:@selector(saveButtonClick) title:@"保存密码" titleColor:kWhiteColor font:FONT(14) backgroundColor:RGB(235, 118, 48)];
    saveButton.layer.cornerRadius = 3;
    [self.view addSubview:saveButton];
    self.saveButton = saveButton;
}

#pragma mark - LayoutSubViews
- (void)viewDidLayoutSubviews
{
    self.oldPwdTextField.frame = CGRectMake(15, CGRectGetMaxY(self.navigationController.navigationBar.frame) + 15, SCREEN_WIDTH - 30, 35);
    
    self.NewPwdTextField.frame = CGRectMake(self.oldPwdTextField.lh_left, CGRectGetMaxY(self.oldPwdTextField.frame) + 15, self.oldPwdTextField.lh_width, self.oldPwdTextField.lh_height);
    
    self.saveButton.frame = CGRectMake(self.NewPwdTextField.lh_left, CGRectGetMaxY(self.NewPwdTextField.frame) + 20, self.NewPwdTextField.lh_width, self.NewPwdTextField.lh_height);
}


#pragma mark - Actions
- (void)saveButtonClick
{
    [self.view endEditing:YES];
    
    NSString *validateMsg = [self validateAll];
    if (validateMsg) {
        [SVProgressHUD showErrorWithStatus:validateMsg];
        return;
    }
    [self updatePwdRequest];
    
}

#pragma mark - Methods
- (NSString *)validateAll {
    if (self.oldPwdTextField.text.lh_isEmpty) {
        return @"旧密码不能为空";
    }
    else if (self.NewPwdTextField.text.lh_isEmpty) {
        return @"新密码不能为空";
    }
    else if (self.NewPwdTextField.text.length < 6 || self.NewPwdTextField.text.length > 20) {
        return @"密码长度在6到20位之间";
    }
    return nil;
}


#pragma mark - HJDataHandlerProtocol
- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJUpdatePwdAPI class]]) {
        [SVProgressHUD showSuccessWithStatus:@"修改密码成功"];
        [self.navigationController lh_popVC];
    }
}


#pragma mark - NewWorking Request
- (void)updatePwdRequest
{
    NSString *md5OldPwd = self.oldPwdTextField.text.md5String;
    NSString *md5NewPwd = self.NewPwdTextField.text.md5String;
    [[[HJUpdatePwdAPI updatePwd_oldPwd:md5OldPwd newPwd:md5NewPwd] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

@end
