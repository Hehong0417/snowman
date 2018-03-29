//
//  HJShoppingCartListHeaderView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJShoppingCartListHeaderView.h"

@implementation HJShoppingCartListHeaderView

- (void)awakeFromNib
{
    
}

- (void)setSelect:(BOOL)select
{
    _select = select;
    if (select) {
        [self.selectButton setImage:kImageNamed(@"ic_b15_xuanzhong_pre") forState:UIControlStateNormal];
    } else {
        [self.selectButton setImage:kImageNamed(@"ic_b15_xuanzhong") forState:UIControlStateNormal];
    }
    
}

- (IBAction)selectButtonClick:(id)sender {
    self.select = !self.select;
    
    [self.delegate ShoppingCartListHeaderViewClickAllSelectButton:self];
}

@end
