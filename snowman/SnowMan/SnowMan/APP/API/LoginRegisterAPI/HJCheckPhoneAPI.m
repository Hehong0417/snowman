//
//  HJCheckPhoneAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCheckPhoneAPI.h"

@implementation HJCheckPhoneAPI

+ (instancetype)checkPhone_phone:(NSString *)phone {
    
    HJCheckPhoneAPI *api = [self new];
    
    [api.parameters setObject:phone forKey:@"phone"];
    
    api.subUrl = API_CHECK_PHONE;
    
    return api;
}

@end
