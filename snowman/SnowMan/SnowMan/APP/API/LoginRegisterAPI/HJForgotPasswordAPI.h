//
//  HJForgotPasswordAPI.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJForgotPasswordAPI : HJBaseAPI

+ (instancetype)getBackPwdWithPhone:(NSString *)phone captcha:(NSString *)captcha pwd:(NSString *)pwd;
@end


