//
//  HJRegisterTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/13.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJRegisterTVC.h"
#import "HJCheckPhoneAPI.h"
#import "HJGetCaptchaAPI.h"
#import "HJRegisterAPI.h"

#define KTextFieldHeight 35

@interface HJRegisterTVC () <HJDataHandlerProtocol, UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *footerView;
@property (weak, nonatomic) IBOutlet UITextField *phoneTexfField;
@property (weak, nonatomic) IBOutlet UITextField *verifyCodeTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UITextField *shopTextField;
@property (weak, nonatomic) IBOutlet UIButton *getVerifyCodeButton;
@property (weak, nonatomic) IBOutlet UIButton *registerButton;

@end

@implementation HJRegisterTVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"注册";
    
    [self setupUI];
    
}


#pragma mark - Actions

- (IBAction)getVerifyCodeAction:(id)sender {
    
    NSString *validateMsg = [self validatePhone];
    if (validateMsg) {
        [SVProgressHUD showErrorWithStatus:validateMsg];
        return;
    }
    [self checkPhoneRequest];
}

- (IBAction)registerAction:(id)sender {
    
    [self.view endEditing:YES];
    
    NSString *validateMsg = [self validateAll];
    if (validateMsg) {
        [SVProgressHUD showErrorWithStatus:validateMsg];
        return;
    }

    [self registerRequest];
}

#pragma mark - Methods

- (void)setupUI
{
    self.phoneTexfField.layer.cornerRadius = 3.0f;
    
    self.phoneTexfField.delegate = self;
    self.verifyCodeTextField.layer.cornerRadius = 3.0f;
    self.pwdTextField.layer.cornerRadius = 3.0f;
    self.shopTextField.layer.cornerRadius = 3.0f;
    self.getVerifyCodeButton.layer.cornerRadius = 3.0f;
    self.registerButton.layer.cornerRadius = 3.0f;
    
    self.phoneTexfField.lh_height = KTextFieldHeight;
    self.verifyCodeTextField.lh_height = KTextFieldHeight;
    self.pwdTextField.lh_height = KTextFieldHeight;
    self.shopTextField.lh_height = KTextFieldHeight;
    
}

- (NSString *)validatePhone {
    if ([self.phoneTexfField.text lh_isEmpty]) {
        return @"请输入手机号码";
    } else if (![self.phoneTexfField.text lh_isValidateMobile]) {
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


#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    
    //
    if ([responseObject isKindOfClass:[HJGetCaptchaAPI class]]) {
        
        HJGetCaptchaAPI *apiModel = responseObject;
        if (apiModel.code == NetworkCodeTypeSuccess) {
            
            [SVProgressHUD showSuccessWithStatus:@"验证码已发送"];
            
            [self.getVerifyCodeButton startWithTime:59 title:@"点击获取" countDownTitle:@"s" mainColor:KButtonColor countColor:kLineDeepColor];
        }
        else {
            
            [self.getVerifyCodeButton startWithTime:apiModel.data.time title:@"点击获取" countDownTitle:@"s" mainColor:KButtonColor countColor:kLineDeepColor];
        }
        
    }

}

- (void)netWorkRequestSuccessDealWithResponseObject:(id)responseObject {
    
    //
    if ([responseObject isKindOfClass:[HJCheckPhoneAPI class]]) {
        
        //code －－ 1，phone number only，continue register
        
        HJCheckPhoneAPI *apiModel = responseObject;
        
        if ([apiModel.msg isEqualToString:@"手机号码已存在"]) {
            
            //帐号已存在不可以继续注册
            [SVProgressHUD showInfoWithStatus:@"注册帐号已存在"];

        } else if ([apiModel.msg isEqualToString:@"账号不存在，请先注册！"]) {
            
            //帐号不存在，可以继续注册
            [self verifyCodeRequest];

        }
    }
    
    //
    if ([responseObject isKindOfClass:[HJRegisterAPI class]]) {
        
        [SVProgressHUD showSuccessWithStatus:@"注册成功"];
        [self.navigationController lh_popVC];
    }

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
    if (textField == self.phoneTexfField) {
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

- (void)checkPhoneRequest {
    
    [[[HJCheckPhoneAPI checkPhone_phone:self.phoneTexfField.text]netWorkClient] postRequestInView:self.view networkRequestSuccessDataHandler:self];
}

- (void)verifyCodeRequest {
    
    [[[HJGetCaptchaAPI getCaptcha_phone:self.phoneTexfField.text]netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)registerRequest {
    
    NSString *md5Pwd = self.pwdTextField.text.md5String;
    
    [[[HJRegisterAPI register_phone:self.phoneTexfField.text captcha:self.verifyCodeTextField.text pwd:md5Pwd shopName:self.shopTextField.text?:kEmptySrting]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
       
}

#pragma mark - Setter&Getter



@end
