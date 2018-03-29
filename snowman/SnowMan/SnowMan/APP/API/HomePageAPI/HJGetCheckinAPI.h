//
//  HJGetCheckinAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJCheckinModel;
@interface HJGetCheckinAPI : HJBaseAPI

@property (nonatomic, strong) HJCheckinModel *data;

+ (instancetype)getCheckin;

@end
@interface HJCheckinModel : NSObject

@property (nonatomic, copy) NSString *score;

@property (nonatomic, assign) BOOL isCheckin;

@end

