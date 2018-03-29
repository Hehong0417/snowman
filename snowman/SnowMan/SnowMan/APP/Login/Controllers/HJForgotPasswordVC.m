//
//  HJForgotPasswordVC.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/13.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJForgotPasswordVC.h"
#import "HJForgotPasswordAPI.h"
#import "HJCheckPhoneAPI.h"
#import "HJGetCaptchaAPI.h"

#define KTextFieldHeight 35

@interface HJForgotPasswordVC () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *certanButton;

@end

@implementation HJForgotPasswordVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"忘记密码";
    
    [self setupUI];
}


#pragma mark - HJDataHandlerProtocol
- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJCheckPhoneAPI class]]) {
        [self verifyCodeRequest];
    }
    
    if ([responseObject isKindOfClass:[HJForgotPasswordAPI class]]) {
        [SVProgressHUD showSuccessWithStatus:@"重置密码成功"];
        [self.navigationController lh_popVC];
    }
}

- (void)netWorkRequestSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJGetCaptchaAPI class]]) {
        
        HJGetCaptchaAPI *apiModel = responseObject;
        if (apiModel.code == NetworkCodeTypeSuccess) {
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
            
            [self.getVerifyCodeButton startWithTime:59 title:@"点击获取" countDownTitle:@"s" mainColor:KButtonColor countColor:kLineDeepColor];
        } else {
            
            [self.getVerifyCodeButton startWithTime:apiModel.data.time title:@"点击获取" countDownTitle:@"s" mainColor:KButtonColor countColor:kLineDeepColor];
        }
    }
}

#pragma mark - Actions
- (IBAction)getCodeClick:(id)sender {
    NSString *validateMsg = [self validatePhone];
    if (validateMsg) {
        [SVProgressHUD showErrorWithStatus:validateMsg];
        return;
    }
    [self checkPhoneRequest];
}

- (IBAction)certanClick:(id)sender {
    [self.view endEditing:YES];
    
    NSString *validateMsg = [self validateAll];
    if (validateMsg) {
        [SVProgressHUD showErrorWithStatus:validateMsg];
        return;
    }
    
    [self forgotPasswordRequest];
}


#pragma mark - Methods

- (void)setupUI
{
    self.phoneTextField.lh_height = KTextFieldHeight;
    self.phoneTextField.delegate = self;
    self.verifyCodeTextField.lh_height = KTextFieldHeight;
    self.pwdTextField.lh_height = KTextFieldHeight;
    self.getVerifyCodeButton.layer.cornerRadius = 3.0f;
    self.certanButton.layer.cornerRadius = 3.0f;
}

- (NSString *)validatePhone {
    if ([self.phoneTextField.text lh_isEmpty]) {
        return @"请输入手机号码";
    } else if (![self.phoneTextField.text lh_isValidateMobile]) {
        return @"请输入正确的手机号";
    }
    return nil;
}

- (NSString *)validateAll {
    
    NSString *phoneMsg = [self validatePhone];
    if (phoneMsg) {
        return phoneMsg;
    }
    else if (self.verifyCodeTextField.text.lh_isEmpty) {
        return @"验证码不能为空";
    }
    else if (self.pwdTextField.text.lh_isEmpty) {
        return @"密码不能为空";
    }
    else if (self.pwdTextField.text.length < 6 || self.pwdTextField.text.length > 20) {
        return @"密码长度在6到20位之间";
    }
    
    return nil;
}

#pragma mark - delegata method
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTextField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    return YES;
}

#pragma mark - Networking Request

- (void)checkPhoneRequest
{
    [[[HJCheckPhoneAPI checkPhone_phone:self.phoneTextField.text] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)verifyCodeRequest
{
    [[[HJGetCaptchaAPI getCaptcha_phone:self.phoneTextField.text]netWorkClient] postRequestInView:self.view networkRequestSuccessDataHandler:self];
}

- (void)forgotPasswordRequest
{
    NSString *md5Pwd = self.pwdTextField.text.md5String;
    [[[HJForgotPasswordAPI getBackPwdWithPhone:self.phoneTextField.text captcha:self.verifyCodeTextField.text pwd:md5Pwd] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}


@end
