//
//  HJCommonProblemAPI.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCommonProblemAPI.h"

@implementation HJCommonProblemAPI
+ (instancetype)commonProblemRequest
{
    HJCommonProblemAPI *api = [[HJCommonProblemAPI alloc] init];
    api.subUrl = API_COMMON_PROBLEM;
    return api;
}
@end
