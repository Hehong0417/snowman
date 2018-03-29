//
//  HJAppliactionSaleFooterView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAppliactionSaleFooterView.h"

@interface HJAppliactionSaleFooterView () <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UIButton *exchangeGoodsBtn;
@property (weak, nonatomic) IBOutlet UIButton *returnGoddsBtn;

@end

@implementation HJAppliactionSaleFooterView

- (void)awakeFromNib
{
    self.contentTextView.placeholder = @"填写退货说明【文字说明】最多50字";
    self.phoneTextField.placeholder = @"请输入您的手机号码";
    self.phoneTextField.delegate = self;
    self.exchangeGoodsBtn.selected = NO;
    self.returnGoddsBtn.selected = NO;
    
    self.exchangeGoodsBtn.layer.cornerRadius = kSmallCornerRadius;
    self.returnGoddsBtn.layer.cornerRadius = kSmallCornerRadius;
    self.submitButton.layer.cornerRadius = kSmallCornerRadius;
}

- (IBAction)exchangeGoodsClick:(id)sender {
    self.returnGoddsBtn.selected = NO;
    self.exchangeGoodsBtn.selected = YES;
    self.selectedApplicationReason = YES;
    [self.exchangeGoodsBtn setBackgroundColor:RGB(249, 158, 27)];
    [self.returnGoddsBtn setBackgroundColor:RGB(193, 193, 193)];
}

- (IBAction)returnGoodsClick:(id)sender {
    self.exchangeGoodsBtn.selected = NO;
    self.returnGoddsBtn.selected = YES;
    self.selectedApplicationReason = YES;
    [self.exchangeGoodsBtn setBackgroundColor:RGB(193, 193, 193)];
    [self.returnGoddsBtn setBackgroundColor:RGB(249, 158, 27)];
}

- (IBAction)submitButtonClick:(id)sender {
    if (self.exchangeGoodsBtn.selected) {
        self.saleType = HJSaleTypeExchangeGoods;
    } else if (self.returnGoddsBtn.selected) {
        self.saleType = HJSaleTypeReturnGoods;
    }
    
    [self.delegate saleFooterViewDidClickSubmitButton:self phone:self.phoneTextField.text saleType:self.saleType  content:self.contentTextView.text];
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField == self.phoneTextField) {
        if (string.length == 0) return YES;
        
        NSInteger existedLength = textField.text.length;
        NSInteger selectedLength = range.length;
        NSInteger replaceLength = string.length;
        if (existedLength - selectedLength + replaceLength > 11) {
            return NO;
        }
    }
    
    return YES;
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
