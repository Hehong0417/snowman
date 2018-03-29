//
//  HJIntegralRuleAPI.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/26.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJIntegralRuleAPI.h"

@implementation HJIntegralRuleAPI

+ (instancetype)integralRuleRequest
{
    HJIntegralRuleAPI *api = [[HJIntegralRuleAPI alloc] init];
    api.subUrl = API_INTEGRAL_RULE;
    return api;
}
@end
