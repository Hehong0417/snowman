//
//  HJBaseLoginVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/13.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseLoginVC.h"
#import "HJRegisterTVC.h"
#import "HJTabBarController.h"
#import "HJLoginAPI.h"
#import "HJUser.h"
#import "HJForgotPasswordVC.h"

@interface HJBaseLoginVC () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet UITextField *pwdTextField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;


@end

@implementation HJBaseLoginVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"登录";
    
    self.phoneTextField.delegate = self;
    self.pwdTextField.returnKeyType = UIReturnKeyDone;
    self.pwdTextField.secureTextEntry = YES;
    self.loginButton.layer.cornerRadius = kSmallCornerRadius;
    
    WEAK_SELF();
    [self lh_setRightNavigationItemWithTitle:@"注册" actionBlock:^{
        
        UIViewController *registerTVC = [UIViewController lh_createFromStoryboardName:SB_LOGIN WithIdentifier:@"HJRegisterTVC"];
        [weakSelf.navigationController pushViewController:registerTVC animated:YES];
    }];
    
    [self.view bk_whenTapped:^{
        
        [weakSelf.view endEditing:YES];
    }];
    
    [self.pwdTextField setBk_shouldReturnBlock:^BOOL(UITextField *textField) {
        
        [weakSelf loginAction:nil];
        
        return YES;
    }];
}

#pragma mark - Actions

- (IBAction)loginAction:(id)sender {
    
    NSString *validateMsg = [self validateAll];
    if (validateMsg) {
        [SVProgressHUD showInfoWithStatus:validateMsg];
        return;
    }

    
    [self loginRequest];
}

- (IBAction)forgotPasswordAction:(id)sender {
    
    HJForgotPasswordVC *vc = [HJForgotPasswordVC lh_createFromStoryboardName:@"Login" WithIdentifier:@"HJForgotPasswordVC"];
    
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - Methods

- (NSString *)validateAll {
    if (self.phoneTextField.text.lh_isEmpty) {
        return @"用户名/手机号不能为空";
    }
    else if (self.pwdTextField.text.lh_isEmpty) {
        return @"密码不能为空";
    }
    else if (self.pwdTextField.text.length < 6 || self.pwdTextField.text.length > 20) {
        return @"密码长度在6到20位之间";
    }else if (![self.phoneTextField.text lh_isValidateMobile]){
        return @"账号或手机号不存在，请重新输入";
    }
    return nil;
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    //
    if ([responseObject isKindOfClass:[HJLoginAPI class]]) {
        
        HJLoginAPI *apiModel = responseObject;
        
        HJUser *shareUser = [HJUser sharedUser];
        shareUser.isLogin = YES;
        
        shareUser.loginModel = apiModel.data;
        
        [shareUser write];
        
        HJTabBarController *tabBarVC = [HJTabBarController new];
        kKeyWindow.rootViewController = tabBarVC;

    }
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

#pragma mark - Network Request

- (void)loginRequest {
    NSString *md5Pwd = self.pwdTextField.text.md5String;
    [[[HJLoginAPI login_phone:self.phoneTextField.text?:kEmptySrting pwd:md5Pwd?:kEmptySrting type:@(HJUserLoginTypeNormal)]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
