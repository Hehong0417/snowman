//
//  HJWebViewTCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/12.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJWebViewTCell.h"

@implementation HJWebViewTCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setUrlStr:(NSString *)urlStr {
    
    if (urlStr) {
        
        _urlStr = urlStr;
        
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]];
        [self.webView loadRequest:request];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
