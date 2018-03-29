//
//  HJForgotPasswordAPI.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJForgotPasswordAPI.h"

@implementation HJForgotPasswordAPI

+ (instancetype)getBackPwdWithPhone:(NSString *)phone captcha:(NSString *)captcha pwd:(NSString *)pwd
{
    HJForgotPasswordAPI *api = [HJForgotPasswordAPI new];
    
    [api.parameters setObject:phone forKey:@"phone"];
    
    [api.parameters setObject:captcha forKey:@"captcha"];
    
    [api.parameters setObject:pwd forKey:@"pwd"];
    
    api.subUrl = API_GET_BACK_PWD;
    
    return api;
}
@end
