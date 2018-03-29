//
//  HJShoppingCartDeleteBar.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJShoppingCartDeleteBar.h"

@implementation HJShoppingCartDeleteBar

- (void)awakeFromNib
{
    [self.deleteButton lh_setCornerRadius:3 borderWidth:1 borderColor:kRedColor];
}

- (void)setSelect:(BOOL)select
{
    _select = select;
    if (select) {
        [self.allSelectButton setImage:kImageNamed(@"ic_b15_xuanzhong_pre") forState:UIControlStateNormal];
    } else {
        [self.allSelectButton setImage:kImageNamed(@"ic_b15_xuanzhong") forState:UIControlStateNormal];
    }
}

- (IBAction)allSelectButtonClick:(id)sender {
    self.select = !self.select;
    [self.delegate shoppingCartDeleteBarClickAllSelectButton:self];
}

- (IBAction)deleteButtonClick:(id)sender {
}
@end
