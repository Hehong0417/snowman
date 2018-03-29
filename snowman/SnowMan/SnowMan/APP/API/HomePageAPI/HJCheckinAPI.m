//
//  HJCheckinAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCheckinAPI.h"

@implementation HJCheckinAPI

+ (instancetype)checkin {
    
    HJCheckinAPI *api = [self new];
    
    api.subUrl = API_CHECKIN;
    
    return api;
}

@end

@implementation HJDayScoreModel


@end