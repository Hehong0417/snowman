//
//  HJSignAlertView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSignAlertView.h"

@interface HJSignAlertView ()

@property (nonatomic, strong) UILabel *scoreLabel;

@end

@implementation HJSignAlertView

- (UIView *)alertViewContentView {
    
    CGFloat contentViewTop = WidthScaleSize(180);
    CGFloat contentViewLeft = 20;
    CGFloat contentViewWidth = kScreenWidth - 2*contentViewLeft;
    CGFloat contentViewHeight = 0.5 * contentViewWidth;
    
    UIView *contentView = [UIView lh_viewWithFrame:CGRectMake(contentViewLeft, contentViewTop, contentViewWidth, contentViewHeight) backColor:kWhiteColor];
    contentView.layer.cornerRadius = 5.0f;
    
    UILabel *signSuccessLabel = [UILabel lh_labelWithFrame:CGRectMake(0, 0, contentViewWidth, contentViewHeight/3.0) text:@"签到成功" textColor:kFontBlackColor font:FontNormalSize textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    
    [contentView addSubview:signSuccessLabel];
    
    CGFloat integralLabelHeight = contentViewHeight/3.0;
    CGFloat integralLabelTop = contentViewHeight/3.0;
    CGFloat integralLabelLeft = 0;
    CGFloat integralLabelWidth = (contentViewWidth - integralLabelLeft*2);

    UILabel *integralLabel = [UILabel lh_labelWithFrame:CGRectMake(integralLabelLeft, integralLabelTop, integralLabelWidth, integralLabelHeight) text:@"恭喜您获得20积分" textColor:kFontBlackColor font:FontBigSize textAlignment:NSTextAlignmentCenter backgroundColor:kClearColor];
    [contentView addSubview:integralLabel];
    
    self.scoreLabel = integralLabel;

    CGFloat buttonWidth = 80;
    CGFloat buttonLeft = (contentViewWidth - buttonWidth)/2.0;
    CGFloat buttonHeight = 30;
    CGFloat buttonTop = contentViewHeight - buttonHeight - 10;
    
    UIButton *sureButton = [UIButton lh_buttonWithFrame:CGRectMake(buttonLeft, buttonTop, buttonWidth, buttonHeight) target:self action:@selector(sureAction) title:@"确定" titleColor:kOrangeColor font:FontBigSize backgroundColor:kWhiteColor];
    [sureButton lh_setCornerRadius:3 borderWidth:0.5 borderColor:kLineDeepColor];
    [contentView addSubview:sureButton];
    
    return contentView;
}

- (void)setScore:(NSString *)score {
    
    _score = score;
    
    if (score) {
        
        self.scoreLabel.text = [NSString stringWithFormat:@"恭喜您获得%@积分",score];
    }
}

- (void)sureAction {
    
    [self dismiss];
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
