//
//  HJMemberSignInVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMemberSignInVC.h"
#import "HJSignAlertView.h"
#import "HJGetCheckinAPI.h"
#import "HJCheckinAPI.h"
#import "HJIntegralRuleAPI.h"

@interface HJMemberSignInVC ()

@property (weak, nonatomic) IBOutlet UIView *signInView;
@property (weak, nonatomic) IBOutlet UIButton *signInButton;
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;
@property (weak, nonatomic) IBOutlet UILabel *commonIssueLabel;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@end

@implementation HJMemberSignInVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"会员签到";
    
    [self getCheckinRequest];
    
    [self webViewRequest];
}


#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    //
    if ([responseObject isKindOfClass:[HJGetCheckinAPI class]]) {
        
        HJGetCheckinAPI *apiModel = responseObject;
        
        self.integralLabel.text = apiModel.data.score;
        
        if (!apiModel.data.isCheckin) return;
        
        [self.signInButton setImage:kImageNamed(@"ic_b4_01_pre") forState:UIControlStateNormal];
    }
    
    //
    if ([responseObject isKindOfClass:[HJCheckinAPI class]]) {
        
        HJCheckinAPI *apiModel = responseObject;
        
        
        HJSignAlertView *alertView = [HJSignAlertView new];
        alertView.score = apiModel.data.dayScore;
        
        [alertView show];
        [self getCheckinRequest];
    }
}


#pragma mark - Actions

- (IBAction)signInAction:(id)sender {
    
    [self checkinRequest];
    
}

#pragma mark - Methods

- (void)webViewRequest
{
    NSString *webString = [HJIntegralRuleAPI integralRuleRequest].appendedUrlString;
    [self webViewLoadRequestWithUrlStr:webString];
}

- (void)webViewLoadRequestWithUrlStr:(NSString *)urlStr {
    
    NSLog(@"urlStr-%@",urlStr);
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    
    [self.webView loadRequest:request];
    
}

#pragma mark -Delegate Methods



#pragma mark - NetWorking Request

- (void)getCheckinRequest {
    
    [[[HJGetCheckinAPI getCheckin]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)checkinRequest {
    
    [[[HJCheckinAPI checkin]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

@end
