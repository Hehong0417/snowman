//
//  UIWebView+LH.h
//  YDT
//
//  Created by lh on 15/6/1.
//  Copyright (c) 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^WebViewContentFrameBlock)(CGRect frame,UIWebView *webView);

@interface UIWebView (LH) <UIWebViewDelegate>

/**
 *  调用 javascript，即时执行
 *
 *  @param jsString js代码
 */
- (void)lh_evaluatingJavaScript:(NSString *)jsString;

- (void)lh_setFrameAdaptWebViewContent:(WebViewContentFrameBlock)webViewContentFrameBlcok;

@end
