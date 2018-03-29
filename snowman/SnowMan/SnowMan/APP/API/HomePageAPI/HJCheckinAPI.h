//
//  HJCheckinAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJBaseModel.h"
@class HJDayScoreModel;
@interface HJCheckinAPI : HJBaseAPI

@property (nonatomic, strong) HJDayScoreModel *data;

+ (instancetype)checkin;

@end

@interface HJDayScoreModel : HJBaseModel

@property (nonatomic, copy) NSString *dayScore;

@end