//
//  HJStandardValueAlertHeaderView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJStandardValueAlertHeaderView.h"

@implementation HJStandardValueAlertHeaderView

- (IBAction)closeViewClick:(id)sender {
    !self.closeViewBlock?:self.closeViewBlock();
}

@end
