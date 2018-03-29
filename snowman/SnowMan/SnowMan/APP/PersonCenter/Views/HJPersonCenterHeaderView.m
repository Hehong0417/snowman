//
//  HJPersonCenterHeaderView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJPersonCenterHeaderView.h"
#import "XYQButton.h"

static const CGFloat kHeaderButtonSize = 70;

@interface HJPersonCenterHeaderView ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@end

@implementation HJPersonCenterHeaderView

- (void)awakeFromNib {
    
    NSArray *buttonTitles = @ [@"待付款",@"待收货",@"已完成",@"退换货"];
    NSArray *buttonImages = @ [@"ic_e1_02",@"ic_e1_03",@"ic_e1_04",@"ic_e1_05"];
    
    CGFloat buttonMargin = (SCREEN_WIDTH - 4*kHeaderButtonSize)/5;
    
    for (int i=0; i<4; i++) {
        
        XYQButton *headerButton = [XYQButton ButtonWithFrame:CGRectMake(buttonMargin+(buttonMargin+kHeaderButtonSize)*i, WidthScaleSize(180)+46, kHeaderButtonSize, kHeaderButtonSize) imgaeName:[buttonImages objectAtIndex:i] titleName:[buttonTitles objectAtIndex:i] contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kFontBlackColor fontsize:12] aligmentType:AligmentTypeLeft tapAction:^(XYQButton *button) {
            
            HJOrderState orderButtonType = i;
            !self.selectOrderButtonAction?:self.selectOrderButtonAction(orderButtonType);
            
        }];
        DLogRect(headerButton.frame);
        [self.bgView addSubview:headerButton];
    }
    
    self.signButton.layer.cornerRadius = 12.5f;
    
    self.userIconButton.layer.cornerRadius = 0.5*6*SCREEN_WIDTH/32;
    self.userIconButton.layer.masksToBounds = YES;
    
}

- (void)setUserInfoModel:(HJUserInfoModel *)userInfoModel {
    
    _userInfoModel = userInfoModel;
    
    if (userInfoModel) {
        
        self.userNameLabel.text = userInfoModel.userName;
        [self.userIconButton sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(userInfoModel.userIco)] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"ic_touxiang"]];
        if (userInfoModel.isCheckin) {
            [self.signButton setTitle:@"已签到" forState:UIControlStateNormal];
        }
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
