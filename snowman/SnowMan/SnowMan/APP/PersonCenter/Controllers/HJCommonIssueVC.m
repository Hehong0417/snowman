//
//  HJCommonIssueVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCommonIssueVC.h"
#import "HJCommonProblemAPI.h"

@interface HJCommonIssueVC ()

@property (nonatomic, strong) UIWebView *webView;
@end

@implementation HJCommonIssueVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"常见问题";
    
    [self webViewRequest];
}

#pragma mark - Actions



#pragma mark - Methods
- (void)webViewRequest
{
    NSString *webString = [HJCommonProblemAPI commonProblemRequest].appendedUrlString;
    [self webViewLoadRequestWithUrlStr:webString];
}

- (void)webViewLoadRequestWithUrlStr:(NSString *)urlStr {
    
    NSLog(@"urlStr-%@",urlStr);
    
    NSURLRequest *request = [[NSURLRequest alloc]initWithURL:[NSURL URLWithString:urlStr]];
    
    [self.webView loadRequest:request];
    
}


#pragma mark - HJDataHandlerProtocol



#pragma mark - Setter&Getter

- (UIWebView *)webView
{
    if (!_webView) {
        _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, SCREEN_HEIGHT)];
        [self.view addSubview:_webView];
    }
    return _webView;
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
