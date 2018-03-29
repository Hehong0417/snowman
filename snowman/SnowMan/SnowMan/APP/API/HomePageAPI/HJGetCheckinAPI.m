//
//  HJGetCheckinAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGetCheckinAPI.h"

@implementation HJGetCheckinAPI

+ (instancetype)getCheckin {
    
    HJGetCheckinAPI *api = [self new];
    
    api.subUrl = API_GET_CHECKIN;
    
    return api;
    
}

@end
@implementation HJCheckinModel

@end


