//
//  TSTextFieldCell.m
//  Transport
//
//  Created by zhipeng-mac on 15/11/30.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "HJTextFieldCell.h"

@interface HJTextFieldCell () <UITextFieldDelegate>

@end

@implementation HJTextFieldCell

- (void)awakeFromNib {
    // Initialization code
    
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //textLabel
        self.textLabel.font = FontNormalSize;
        //KVO
        [self.textLabel addObserver:self forKeyPath:@"text" options:NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld context:NULL];          //textField
        UITextField *textField = [[UITextField alloc]init];
        textField.textColor = [UIColor blackColor];
        textField.text = @"";
        textField.font = FontNormalSize;
        textField.delegate = self;
        self.detailTextField = textField;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:textField];
        
        //监测textField值变化
        [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:nil];
        }
    
    return self;
}

-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if([keyPath isEqualToString:@"text"])
    {
    //*****根据textLabel字符串长度确定detailTextField位置
        CGFloat left = [self.textLabel.text widthForFont:FontNormalSize] + +15;
        self.detailTextField.frame = CGRectMake(left, 6, self.lh_width-left-20, 36);
    }
}

- (void)dealloc {
    
    [self.textLabel removeObserver:self forKeyPath:@"text"];
}

- (void)setTextFieldLeft:(CGFloat)textFieldLeft {

    _textFieldLeft = textFieldLeft;
    
    [self.detailTextField mas_updateConstraints:^(MASConstraintMaker *make) {
        
        make.left.equalTo([NSNumber numberWithFloat:textFieldLeft]);
    }];
    
}

- (void)setShowActionSheet:(BOOL)showActionSheet {
    
    _showActionSheet = showActionSheet;
    
    self.detailTextField.enabled = !showActionSheet;
    
}

- (void)textFieldDidChange:(NSNotification *)notification {
    
    UITextField *textField =  notification.object;
    
    if ([textField isEqual:self.detailTextField]) {
        
        self.settingItem.inputString = textField.text;
        
        DDLogInfo(@"inputStr=%@",self.settingItem.inputString);
    }
//    NSLog(@"text =%@", textField.text);
}


- (void)setSettingItem:(HJSettingItem *)settingItem{
    
    _settingItem = settingItem;
    
    self.textLabel.text = settingItem.title;
    self.detailTextField.placeholder = settingItem.detailTitle;
    self.detailTextField.text = settingItem.inputString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark - UITextFieldDelegate
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.TextFieldCellType == HJTextFieldCellTypePhone) {
        if (textField == self.detailTextField) {
            if (string.length == 0) return YES;
            
            NSInteger existedLength = textField.text.length;
            NSInteger selectedLength = range.length;
            NSInteger replaceLength = string.length;
            if (existedLength - selectedLength + replaceLength > 11) {
                return NO;
            }
        }
    }
    return YES;
}

@end
