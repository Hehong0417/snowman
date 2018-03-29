//
//  HJClassifyHeaderButton.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#define HJButtonImageW 10

#import "HJClassifyHeaderButton.h"

@implementation HJClassifyHeaderButton

+ (instancetype)classifyHeaderButton
{
    return [[self alloc] init];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // 高亮的时候不要自动调整图标
        self.adjustsImageWhenHighlighted = NO;
        self.titleLabel.font = [UIFont boldSystemFontOfSize:19];
        self.imageView.contentMode = UIViewContentModeCenter;
        // 背景
//        [self setBackgroundImage:[UIImage resizedImageWithName:@"navigationbar_filter_background_highlighted"] forState:UIControlStateHighlighted];
//        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    }
    return self;
}

- (CGRect)imageRectForContentRect:(CGRect)contentRect
{
    CGFloat imageY = 0;
    CGFloat imageW = HJButtonImageW;
    CGFloat imageX = contentRect.size.width - imageW;
    CGFloat imageH = contentRect.size.height;
    return CGRectMake(imageX, imageY, imageW, imageH);
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect
{
    CGFloat titleY = 0;
    CGFloat titleX = 0;
    CGFloat titleW = contentRect.size.width - HJButtonImageW;
    CGFloat titleH = contentRect.size.height;
    return CGRectMake(titleX, titleY, titleW, titleH);
}

- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    // 根据title计算自己的宽度
    CGFloat titleW = [title lh_sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(MAXFLOAT, MAXFLOAT)].width;
    
    CGRect frame = self.frame;
    frame.size.width = titleW + HJButtonImageW + 5;
    self.frame = frame;
    
    [super setTitle:title forState:state];
}


@end
