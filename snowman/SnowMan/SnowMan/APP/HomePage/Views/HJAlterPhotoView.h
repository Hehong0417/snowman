//
//  HJAlterPhotoView.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, HJAlertType) {
    HJAlertTypePersonPhoto,
};

@interface HJAlterPhotoView : UIView
@property (weak, nonatomic) IBOutlet UIButton *takePhotoButton;
@property (weak, nonatomic) IBOutlet UIButton *selectPhotoButton;

@property (nonatomic, assign) HJAlertType alertType;


+ (instancetype)alterPhotoView;
@end
