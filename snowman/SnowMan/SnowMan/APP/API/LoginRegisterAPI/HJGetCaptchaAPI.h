//
//  HJGetCaptchaAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJBaseModel.h"

@class HJVerifyCodeModel;
@interface HJGetCaptchaAPI : HJBaseAPI

@property (nonatomic, strong) HJVerifyCodeModel *data;

+ (instancetype)getCaptcha_phone:(NSString *)phone;

@end

@interface HJVerifyCodeModel : HJBaseModel

@property (nonatomic, assign) NSInteger time;

@end
