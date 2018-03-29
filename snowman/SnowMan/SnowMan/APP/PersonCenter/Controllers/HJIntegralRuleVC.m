//
//  HJIntegralRuleVC.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJIntegralRuleVC.h"
#import "HJIntegralRuleAPI.h"

@interface HJIntegralRuleVC ()

@property (nonatomic, strong) UIWebView *webView;

@end

@implementation HJIntegralRuleVC

#pragma mark - LifeCycle


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"积分规则";
    
    [self webViewRequest];
}

#pragma mark - Actions

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

#pragma mark - Setter&Getter

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT)];
        [self.view addSubview:_webView];
    }
    return _webView;
}

@end
