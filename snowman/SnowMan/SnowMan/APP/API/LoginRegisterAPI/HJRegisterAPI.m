//
//  HJRegisterAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJRegisterAPI.h"

@implementation HJRegisterAPI

+ (instancetype)register_phone:(NSString *)phone captcha:(NSString *)captcha pwd:(NSString *)pwd shopName:(NSString *)shopName {
    
    HJRegisterAPI *api = [HJRegisterAPI new];
    
    [api.parameters setObject:phone forKey:@"phone"];
    [api.parameters setObject:captcha forKey:@"captcha"];
    [api.parameters setObject:pwd forKey:@"pwd"];
    [api.parameters setObject:shopName forKey:@"shopName"];
    
    api.subUrl = API_REGISTER;
    
    return api;
}

@end
