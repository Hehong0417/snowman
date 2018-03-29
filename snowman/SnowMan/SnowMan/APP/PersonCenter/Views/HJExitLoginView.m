//
//  HJExitLoginView.m
//  Enjoy
//
//  Created by 邓朝文 on 16/5/11.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJExitLoginView.h"

@implementation HJExitLoginView

- (void)awakeFromNib {
    self.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    self.baseView.layer.cornerRadius = 6;
    self.cancelButton.layer.cornerRadius = 6;
    self.certanButton.layer.cornerRadius = 6;
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

+ (instancetype)exitLoginView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HJExitLoginView" owner:nil options:nil] lastObject];
}

+ (instancetype)exitLoginViewWithWarnTitle:(NSString *)warnTitle
{
    HJExitLoginView *view = [HJExitLoginView exitLoginView];
    view.warnLabel.text = warnTitle;
    return view;
}

- (IBAction)cancelClick:(id)sender {
    [self removeFromSuperview];
}

- (IBAction)certanClick:(id)sender {
    self.certanBlock();
    [self removeFromSuperview];
}


@end
