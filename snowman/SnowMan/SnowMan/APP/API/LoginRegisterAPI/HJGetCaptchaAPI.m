//
//  HJGetCaptchaAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGetCaptchaAPI.h"

@implementation HJGetCaptchaAPI

+ (instancetype)getCaptcha_phone:(NSString *)phone {
    
    HJGetCaptchaAPI *api = [self new];
    
    [api.parameters setObject:phone forKey:@"phone"];
    
    api.subUrl = API_GET_CAPTCHA;
    
    return api;
}

@end

@implementation HJVerifyCodeModel


@end