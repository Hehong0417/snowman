//
//  CustomAlertView.h
//  PlusStar_1.0
//
//  Created by 劉 on 15-4-1.
//  Copyright (c) 2015年 HuangZhenXiang. All rights reserved.
//

#import <UIKit/UIKit.h>

#define JKCustomAlertViewStandardFrame CGRectMake((kScreenWidth-280)/2.0, (kScreenHeight - 140)/2.0, 280, 140)

typedef NS_ENUM(NSUInteger,JKAlertType) {
    
    JKAlertTypeOneTitleLabel,
    JKAlertTypeOneTextField,
};

@class JKCustomAlertView;

@protocol JKCustomAlertViewDelegate <NSObject>

@required

- (UIView *)alertViewContentView;

@end

@interface JKCustomAlertView : UIView <JKCustomAlertViewDelegate>

@property(nonatomic,weak)id<JKCustomAlertViewDelegate>delegate;
@property (nonatomic,unsafe_unretained)JKAlertType alertType;
@property (nonatomic, strong) UITextField *textField1;
@property (nonatomic, strong) UILabel *titleLabel1;
@property (nonatomic, copy) NSString *title1;
@property (nonatomic, copy) NSString *placeHolder1;
@property (nonatomic, copy) void(^tapAlertViewButtonAction)(JKCustomAlertView *alertView, NSUInteger buttonIndex);

-(instancetype)initWithJKAlertType:(JKAlertType)alertType contentView:(UIView *)contentView;

-(void)show;

- (void)dismiss;

@end
