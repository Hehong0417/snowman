//
//  LHAlertView.m
//  Transport
//
//  Created by IMAC on 15/12/8.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "LHAlertView.h"

@interface LHAlertView () <UIGestureRecognizerDelegate>


@end

@implementation LHAlertView

- (instancetype)init {

    if (self = [super init]) {
        [self setFrame:kMainScreenBounds];
        self.backgroundColor = [UIColor colorWithWhite:0.3 alpha:0.3];
        UIView *contentView = [self alertViewContentView];
        self.contentView = contentView;
        [self addSubview:contentView];
        //点击回收操作
//        WEAK_SELF();
//        
//        UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc]bk_initWithHandler:^(UIGestureRecognizer *sender, UIGestureRecognizerState state, CGPoint location) {
//            
//            [weakSelf hideWithCompletion:NULL];
//        }];
//        tapGes.delegate = self;
//        [self addGestureRecognizer:tapGes];
    }
    return self;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {
    
    if ([NSStringFromClass([touch.view class]) isEqualToString:@"UITableViewCellContentView"]||[NSStringFromClass([touch.view class]) isEqualToString:@"UIButton"]) {
         
         return NO;
     }
    
    return YES;
}
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
//        [self defaulInit];
    }
    return self;
}

- (void)defaulInit {
    UIView *backView = [UIView lh_viewWithFrame:self.bounds backColor:[UIColor colorWithWhite:0.3 alpha:0.3]];
    [self addSubview:backView];
    //点击回收操作
    WEAK_SELF();
    [backView bk_whenTapped:^{
        
        [weakSelf hideWithCompletion:NULL];
    }];
    
    UIView *contentView = [self alertViewContentView];
    self.contentView = contentView;
    [self addSubview:contentView];
}

#pragma  mark -  <LHAlertViewContentViewProtocol>

-(UIView *)alertViewContentView {
    
    return nil;
}
/**
 *  显示
 *
 *  @param animated 是否启用动画
 */
- (void)showFromBottomAnimated:(BOOL)animated {
    NSAssert(self.contentView != nil, @"must have conetentView");
    
    self.animated = animated;
    
    [self av_addSuperViews];
    
    if (animated) {
        self.contentView.lh_top = self.lh_bottom;
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.lh_top = self.lh_bottom - self.contentView.lh_height;
        } completion:^(BOOL finished) {
            
        }];
    }
}

/**
 *  隐藏
 *
 *  @param completionBlock 完成block
 */
- (void)hideWithCompletion:(void(^)())completionBlock {
    if (self.animated) {
        [UIView animateWithDuration:0.3 animations:^{
            self.contentView.lh_top = self.lh_bottom;
        } completion:^(BOOL finished) {
            [self av_removeSubviews];
            
            if (completionBlock) {
                completionBlock();
            }
        }];
    }
    else {
        [self av_removeSubviews];
        
        if (completionBlock) {
            completionBlock();
        }
    }
}


-(void)showFromCenterAnimated:(BOOL)animated {
    
    NSAssert(self.contentView != nil, @"must have conetentView");
    
    self.animated = animated;
    
    if (animated) {
        
        [self triggerBounceAnimations];
        
        //添加到window上面
        UIWindow *keyWindow = [UIApplication sharedApplication].keyWindow;
        [keyWindow addSubview:self];
    }
    
}
#pragma mark - Animations
- (void) triggerBounceAnimations
{
    
    self.contentView.alpha = 0;
    self.contentView.center = CGPointMake(CGRectGetWidth(kMainScreenBounds)/2, (CGRectGetHeight(kMainScreenBounds)/2));
    
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
    [self.contentView.layer addAnimation:animation forKey:nil];
    
    [UIView animateWithDuration:0.1f
                          delay:0
                        options:UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseIn | UIViewAnimationOptionBeginFromCurrentState
                     animations:^{
                         [self.contentView setAlpha:1.0];
                         [self.contentView setAlpha:1.0];
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



- (void)av_addSuperViews {
    [kKeyWindow addSubview:self];
//    [kKeyWindow addSubview:self.contentView];
}

- (void)av_removeSubviews {
    [self.contentView removeFromSuperview];
    [self removeFromSuperview];
//    self.contentView = nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
