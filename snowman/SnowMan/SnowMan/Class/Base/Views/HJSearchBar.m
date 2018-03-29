//
//  HJSearchBar.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSearchBar.h"

@implementation HJSearchBar

- (void)awakeFromNib {
    
    self.backgroundColor = kClearColor;
    
    self.backgroundView.layer.cornerRadius = 0.5 * self.backgroundView.lh_height;
    self.backgroundView.backgroundColor = kWhiteColor;
    
    self.searchTextField.returnKeyType = UIReturnKeySearch;
    self.searchTextField.delegate = self;
    self.searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    
    !self.searchDoneHandler?:self.searchDoneHandler();
    [self.searchTextField resignFirstResponder];
    return YES;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
