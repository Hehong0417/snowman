//
//  HJLoginAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJLoginAPI.h"

@implementation HJLoginAPI

+ (instancetype)login_phone:(NSString *)phone pwd:(NSString *)pwd type:(NSNumber *)type {
    
    HJLoginAPI *api = [self new];
    
    [api.parameters setObject:phone forKey:@"phone"];
    [api.parameters setObject:pwd forKey:@"pwd"];
    [api.parameters setObject:type forKey:@"type"];
    
    api.subUrl = API_LOGIN;
    
    return api;
}

@end

