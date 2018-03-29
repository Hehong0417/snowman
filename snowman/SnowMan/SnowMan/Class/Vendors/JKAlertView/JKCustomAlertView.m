//
//  CustomAlertView.m
//  PlusStar_1.0
//
//  Created by 劉 on 15-4-1.
//  Copyright (c) 2015年 HuangZhenXiang. All rights reserved.
//

#import "JKCustomAlertView.h"

/*Default Colors*/
#define RJTitleLabelBackgroundColor [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1.0]
#define RJComfirmButtonColor [UIColor colorWithRed:0.20392156862745098 green:0.596078431372549 blue:0.8588235294117647 alpha:1.0]

#define screenBounds [[UIScreen mainScreen] bounds]
#define IS_IOS7_Or_Later [[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0

@interface JKCustomAlertView ()

@property(unsafe_unretained,nonatomic)NSInteger selectedButtonIndex;
@property (nonatomic,strong) UIView *contentView;
@property (nonatomic,strong) UIView *alertPopupView;
@property (nonatomic, strong) UIButton *cancelButton;
@property (nonatomic, strong) UIButton *sureButton;

@end

@implementation JKCustomAlertView

- (instancetype)init {
    
    self = [super init];
    
    if (self) {
        
        [self setFrame:kMainScreenBounds];
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        UIView *contentView = [self alertViewContentView];
        self.contentView = contentView;
        [self addSubview:contentView];
    }
    
    return self;
}



-(instancetype)initWithJKAlertType:(JKAlertType)alertType contentView:(UIView *)contentView {
    
    self=[super init];

    if (self) {
        
        self.opaque = NO;
        self.backgroundColor =  RGBA(20, 32, 40, 0.3);
        self.frame=CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
        
        _contentView=contentView;
        _alertType=alertType;

        self.alertPopupView.userInteractionEnabled=YES;
        self.alertPopupView.alpha = 0.0;
        
        UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 280, 140)];
        view.opaque = NO;
        view.backgroundColor = [UIColor whiteColor];
        view.alpha = 1;
        view.layer.cornerRadius = 3.0;
        [self addSubview:view];
        self.alertPopupView = view;
        
        //
        UILabel *titileLabel = [[UILabel alloc]initWithFrame:CGRectMake(33, 20, (self.alertPopupView.lh_width-2*33), 40)];
        titileLabel.textColor = kFontGrayColor;
        if (alertType == JKAlertTypeOneTextField) {
            //
            self.textField1 = [[UITextField alloc]initWithFrame:CGRectMake(40, 25,self.alertPopupView.lh_width-2*40, 40)];
            [self.alertPopupView addSubview:self.textField1];
            
            //添加分割线
            UIView *lineView = [UIView lh_viewWithFrame:CGRectMake(0, self.textField1.lh_height-1, self.textField1.lh_width, 1) backColor:kLineLightColor];
            [self.textField1 addSubview:lineView];
            
        }else if(alertType == JKAlertTypeOneTitleLabel) {
            
            titileLabel.text = self.title1;
            self.titleLabel1 = titileLabel;
            [self.alertPopupView addSubview:self.titleLabel1];
            
        }
        
        titileLabel.numberOfLines = 2;
        titileLabel.font = FontBigSize;
        
        CGFloat button_width = 100;
        CGFloat button_height = 40;
        CGFloat button_margin = (self.alertPopupView.lh_width - 2*100)/3.0;
        
        UIButton *cancelButton = [self actionButtonWithFrame:CGRectMake(button_margin, titileLabel.lh_bottom +30, button_width, button_height) title:@"取消" titleColor:kBlackColor backgroundColor:kWhiteColor  font:FontNormalSize];
        [cancelButton lh_setCornerRadius:kSmallCornerRadius borderWidth:1 borderColor:kBlackColor];
        cancelButton.tag = 0;
        [self.alertPopupView addSubview:cancelButton];
        self.cancelButton = cancelButton;
        
        UIButton *sureButton = [self actionButtonWithFrame:CGRectMake(button_margin*2+button_width, titileLabel.lh_bottom+30, button_width, cancelButton.lh_height) title:@"确定" titleColor:kWhiteColor backgroundColor:APP_COMMON_COLOR font:FontNormalSize];
        sureButton.tag = 1;
        [self.alertPopupView addSubview:sureButton];
        self.sureButton = sureButton;
    
    }
    return self;
}

#pragma  mark -  <LHAlertViewContentViewProtocol>

-(UIView *)alertViewContentView {
    
    return nil;
}

- (void)setTitle1:(NSString *)title1 {
    
    _title1 = title1;
    
    self.titleLabel1 = [UILabel lh_labelAdaptionWithFrame:CGRectMake(self.cancelButton.lh_left, 25,self.alertPopupView.lh_width-2*self.cancelButton.lh_left, 40)text:title1 textColor:kFontGrayColor font:FONT(17) textAlignment:NSTextAlignmentCenter];
    [self.alertPopupView addSubview:self.titleLabel1];
}

- (void)setPlaceHolder1:(NSString *)placeHolder1 {
    
    _placeHolder1 = placeHolder1;
    
    self.textField1.placeholder = placeHolder1;
}

- (UIButton *)actionButtonWithFrame:(CGRect)frame title:(NSString *)title titleColor:(UIColor *)titleColor backgroundColor:(UIColor *)backgroundColor font:(UIFont *)font {
    
    UIButton *actionButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [actionButton setFrame:frame];
    [actionButton setTitle:title forState:UIControlStateNormal];
    [actionButton setTitleColor:titleColor forState:UIControlStateNormal];
    [actionButton setBackgroundColor:backgroundColor];
    [actionButton.layer setCornerRadius:3.0];
    [actionButton.titleLabel setFont:font];
    [actionButton addTarget:self action:@selector(tapButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    return actionButton;
}

- (void)tapButtonAction:(UIButton *)button{
    
    [self dismiss];
    
//    if ([self.delegate respondsToSelector:@selector(customAlertView:clickButton:)]) {
//        
////        [self.delegate customAlertView:self clickButton:button.tag];
//    }
    
    if (self.tapAlertViewButtonAction) {
        
        self.tapAlertViewButtonAction(self,button.tag);
    }
}

-(void)show{
    
    [self triggerBounceAnimations];
    
    //添加到window上面
    UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
    [keyWindow addSubview:self];
}
#pragma mark - Animations
- (void) triggerBounceAnimations
{
    
    self.alertPopupView.alpha = 0;
    self.alertPopupView.center = CGPointMake(CGRectGetWidth(screenBounds)/2, (CGRectGetHeight(screenBounds)/2));
    
    CAKeyframeAnimation * animation;
    animation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    animation.duration = 0.3f;
    //animation.delegate = self;
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    NSMutableArray *values = [NSMutableArray array];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.2, 1.2, 1.0)]];
    [values addObject:[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.0, 1.0, 1.0)]];
    animation.values = values;
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [self.alertPopupView.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:0.1f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.alertPopupView setAlpha:1.0];
                         [self.alertPopupView setAlpha:1.0];
                     }
                     completion:^(BOOL finished){
                     }];
}

- (void)dismiss
{
    
    [UIView animateWithDuration:0.4
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseInOut
                     animations:^{
                         self.alpha = 0;
                     }
                     completion:^(BOOL finished){
                         [self removeFromSuperview];
                     }];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self endEditing:YES];
}

@end
