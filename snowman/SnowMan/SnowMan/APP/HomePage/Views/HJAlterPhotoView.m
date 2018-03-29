//
//  HJAlterPhotoView.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAlterPhotoView.h"

@interface HJAlterPhotoView ()
@property (weak, nonatomic) IBOutlet UILabel *warnLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *warnLabelHeight;
@end
@implementation HJAlterPhotoView

+ (instancetype)alterPhotoView
{
    return [[[NSBundle mainBundle] loadNibNamed:[HJAlterPhotoView className] owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
}

- (IBAction)cancerClick:(id)sender {
    [self removeFromSuperview];
}

- (void)setAlertType:(HJAlertType)alertType
{
    if (alertType == HJAlertTypePersonPhoto) {
        self.warnLabel.hidden = YES;
    }
}

@end
