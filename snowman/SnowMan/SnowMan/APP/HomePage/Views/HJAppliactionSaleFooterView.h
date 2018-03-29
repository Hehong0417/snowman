//
//  HJAppliactionSaleFooterView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "XYQPlaceholderTextVIew.h"

@class HJAppliactionSaleFooterView;

@protocol HJAppliactionSaleFooterViewDelegate <NSObject>
@optional
- (void)saleFooterViewDidClickSubmitButton:(HJAppliactionSaleFooterView *)saleFooterView phone:(NSString *)phone saleType:(NSInteger)saleType content:(NSString *)content;
@end

@interface HJAppliactionSaleFooterView : UIView
@property (weak, nonatomic) IBOutlet UITextField *phoneTextField;
@property (weak, nonatomic) IBOutlet XYQPlaceholderTextVIew *contentTextView;
@property (weak, nonatomic) IBOutlet UIButton *submitButton;
@property (nonatomic, assign) HJSaleType saleType;
@property (nonatomic, weak) id<HJAppliactionSaleFooterViewDelegate> delegate;
@property (nonatomic, assign) BOOL selectedApplicationReason;

- (IBAction)exchangeGoodsClick:(id)sender;
- (IBAction)returnGoodsClick:(id)sender;
- (IBAction)submitButtonClick:(id)sender;

@end
