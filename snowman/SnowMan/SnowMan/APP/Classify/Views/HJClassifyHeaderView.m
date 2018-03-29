//
//  HJClassifyHeaderView.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#define KButtonViewCount 3

#import "HJClassifyHeaderView.h"
#import "HJClassifyHeaderButton.h"

@interface HJClassifyHeaderView ()
@property (nonatomic, strong) NSMutableArray *buttonViewArray;

@end

@implementation HJClassifyHeaderView

+ (instancetype)classifyHeaderView
{
    return [[self alloc] init];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        for (int i = 0; i<KButtonViewCount; i++) {
            UIView *buttonView = [[UIView alloc] init];
            [self.buttonViewArray addObject:buttonView];
            [self addSubview:buttonView];
            if (i == 0) {
                UIButton *headerButton = [[UIButton alloc] init];
                [buttonView addSubview:headerButton];
                [headerButton setTitle:@"鸭副类" forState:UIControlStateNormal];
                [self.headerButtonArray addObject:headerButton];
                [headerButton setTitleColor:kBlackColor forState:UIControlStateNormal];
            } else {
                HJClassifyHeaderButton *headerButton = [HJClassifyHeaderButton classifyHeaderButton];
                [headerButton setTitle:@"鸭副类" forState:UIControlStateNormal];
                [headerButton setImage:[UIImage imageNamed:@"ic_xiangxia"] forState:UIControlStateNormal];
                
                [buttonView addSubview:headerButton];
                [self.headerButtonArray addObject:headerButton];
            }
        }
    }
    return self;
}

- (void)layoutSubviews
{
    CGFloat btnViewW = SCREEN_WIDTH / KButtonViewCount;
    for (int i = 0; i<KButtonViewCount; i++) {
        CGFloat btnViewX = i * btnViewW;
        CGFloat btnViewY = 0;
        CGFloat BtnViewH = 50;
        UIView *buttonView = self.buttonViewArray[i];
        buttonView.frame = CGRectMake(btnViewX, btnViewY, btnViewW, BtnViewH);
        if (i == 0) {
            UIButton *headerButton = self.headerButtonArray[i];
            headerButton.frame = buttonView.frame;
        } else {
            HJClassifyHeaderButton *headerButton = self.headerButtonArray[i];
            headerButton.frame = buttonView.frame;
            headerButton.lh_centerX = buttonView.lh_centerX;
            headerButton.lh_centerY = buttonView.lh_centerY;
        }
        
    }
}

- (NSMutableArray *)buttonViewArray
{
    if (!_buttonViewArray) {
        _buttonViewArray = [NSMutableArray array];
    }
    return _buttonViewArray;
}

- (NSMutableArray *)headerButtonArray
{
    if (!_headerButtonArray) {
        _headerButtonArray = [NSMutableArray array];
    }
    return _headerButtonArray;
}

@end
