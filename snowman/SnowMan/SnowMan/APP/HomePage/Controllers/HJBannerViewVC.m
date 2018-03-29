//
//  HJBannerViewVC.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBannerViewVC.h"

@interface HJBannerViewVC () <UIWebViewDelegate>

@property (nonatomic, strong) UIWebView *bannerView;
@end

@implementation HJBannerViewVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self openRequest];
}


#pragma mark - method
- (void)openRequest
{
    NSURL *url = [NSURL URLWithString:self.urlString];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.bannerView loadRequest:request];
}

#pragma mark - delegate method
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}

#pragma mark - setting && getting
- (UIWebView *)bannerView
{
    if (!_bannerView) {
        _bannerView = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT)];
        _bannerView.delegate = self;
        [self.view addSubview:_bannerView];
    }
    return _bannerView;
}

@end
