//
//  HJPersonCenterHeaderView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGetUserInfoAPI.h"

typedef void(^SelectOderButtonAction)(HJOrderState orderButtonType);

@interface HJPersonCenterHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *checkAllOrderButton;
@property (weak, nonatomic) IBOutlet UIButton *signButton;
@property (nonatomic, copy) SelectOderButtonAction selectOrderButtonAction;
@property (weak, nonatomic) IBOutlet UIButton *userIconButton;
@property (nonatomic, strong) HJUserInfoModel *userInfoModel;

@end
