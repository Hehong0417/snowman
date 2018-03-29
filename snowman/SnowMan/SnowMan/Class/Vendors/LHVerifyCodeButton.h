//
//  LHVerifyCodeButton.h
//  Bsh
//
//  Created by IMAC on 15/12/26.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LHVerifyCodeButton : UIButton

- (void)addCornerStyle;

- (void)startTimer:(NSTimeInterval)interval;

- (void)disableTimer;

@end
