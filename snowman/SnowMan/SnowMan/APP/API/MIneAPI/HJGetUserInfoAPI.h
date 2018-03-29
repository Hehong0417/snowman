//
//  HJGetUserInfoAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJUserInfoModel;
@interface HJGetUserInfoAPI : HJBaseAPI

@property (nonatomic, strong) HJUserInfoModel *data;

+ (instancetype)getUserInfo;

@end
@interface HJUserInfoModel : NSObject

@property (nonatomic, copy) NSString *userIco;

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, assign) NSInteger isCheckin;

@property (nonatomic, copy) NSString *userName;

@end

