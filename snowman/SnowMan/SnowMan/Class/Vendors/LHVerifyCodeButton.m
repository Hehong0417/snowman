//
//  LHVerifyCodeButton.m
//  Bsh
//
//  Created by IMAC on 15/12/26.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "LHVerifyCodeButton.h"

#define kVCTitleColor [UIColor whiteColor]
#define kVCBackgroundColor UIColorHex(EC6D1C)
#define kVCDisableBackgroundColor [UIColor lightGrayColor]

@interface LHVerifyCodeButton ()

@property (nonatomic, strong) NSTimer *timer;

@property (nonatomic, assign) BOOL isCustomStyle;

@end

@implementation LHVerifyCodeButton

- (void)defaulInit {
    self.titleLabel.adjustsFontSizeToFitWidth = YES;
    self.contentEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 5);
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self defaulInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self defaulInit];
    }
    return self;
}

- (void)addCornerStyle {
    self.isCustomStyle = YES;
    
    self.layer.cornerRadius = 6;
    [self setTitleColor:kVCTitleColor forState:UIControlStateNormal];
    self.backgroundColor = kVCBackgroundColor;
}

- (void)startTimer:(NSTimeInterval)interval {
    if (self.timer || interval <= 0) {
        return;
    }
    
    __weak __typeof(self) weakSelf = self;
    __block NSTimeInterval timerInterval = interval;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 block:^(NSTimer *timer) {
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        
        if (--timerInterval >= 0) {
            strongSelf.enabled = NO;
            if (strongSelf.isCustomStyle) {
                strongSelf.backgroundColor = kVCDisableBackgroundColor;
            }
            [strongSelf setTitle:[NSString stringWithFormat:@"%.0f秒后可重发", timerInterval] forState:UIControlStateDisabled];
        }
        else {
            strongSelf.enabled = YES;
            if (strongSelf.isCustomStyle) {
                strongSelf.backgroundColor = kVCBackgroundColor;
            }
            [strongSelf disableTimer];
        }
//        LHLog(@"timerInterval = %f", timerInterval);
    } repeats:YES];
}

- (void)disableTimer {
    if (self.timer) {
        [self.timer invalidate];
        self.timer = nil;
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
