//
//  HJRegisterAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJRegisterAPI : HJBaseAPI

+ (instancetype)register_phone:(NSString *)phone captcha:(NSString *)captcha pwd:(NSString *)pwd shopName:(NSString *)shopName;

@end
