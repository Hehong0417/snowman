//
//  HJMyintegralHeaderView.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJScoreModel;
@interface HJMyIntegralHeaderView : UIView
@property (nonatomic, strong) HJScoreModel *scorceModel;
+ (instancetype)myIntegralHeaderView;
@end
