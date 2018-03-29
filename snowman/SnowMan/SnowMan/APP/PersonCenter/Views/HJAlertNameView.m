//
//  HJAlertNameView.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/31.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAlertNameView.h"

@interface HJAlertNameView() <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *nameTextField;
@property (weak, nonatomic) IBOutlet UIView *alertView;
@end
@implementation HJAlertNameView


+ (instancetype)alertNameView
{
    return [[[NSBundle mainBundle] loadNibNamed:[HJAlertNameView className] owner:nil options:nil] lastObject];
}

- (void)awakeFromNib{
    self.alertView.layer.cornerRadius = kSmallCornerRadius;
    self.nameTextField.delegate = self;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (IBAction)certainClick:(id)sender {
    
    if ([self.nameTextField.text lh_isEmpty]) {
        [SVProgressHUD showInfoWithStatus:@"请输入昵称!"];
        return;
    }
    !self.nameString?:self.nameString(self.nameTextField.text);
    [self removeFromSuperview];
}

- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    [UIView animateWithDuration:KAnimationTime animations:^{
        self.alertView.lh_top = self.alertView.lh_top - 50;
    }];
    
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    [UIView animateWithDuration:KAnimationTime animations:^{
        self.alertView.lh_top = self.alertView.lh_top + 50;
    }];
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.nameTextField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 12) {
            return NO;
        }
    }
    return YES;
}



@end
