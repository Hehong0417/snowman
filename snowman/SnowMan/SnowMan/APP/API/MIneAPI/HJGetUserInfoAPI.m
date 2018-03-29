//
//  HJGetUserInfoAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGetUserInfoAPI.h"

@implementation HJGetUserInfoAPI

+ (instancetype)getUserInfo {
    HJGetUserInfoAPI * api = [self new];
    api.subUrl = API_GET_USER_INFO;
    return api;
}
@end
@implementation HJUserInfoModel

@end


