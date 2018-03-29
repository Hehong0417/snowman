//
//  HJWebViewTCell.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/12.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJWebViewTCell : UITableViewCell

@property (nonatomic, strong) NSString *urlStr;
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@end
