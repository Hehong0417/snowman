//
//  HJLoginAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/6.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJUser.h"

typedef NS_ENUM(NSUInteger, HJUserLoginType) {
    HJUserLoginTypeNormal = 1,
    HJUserLoginTypeQQ,
    HJUserLoginTypeWeiXin,
    HJUserLoginTypeWeiBo,
};

@class HJLoginModel;
@interface HJLoginAPI : HJBaseAPI

@property (nonatomic, strong) HJLoginModel *data;

+ (instancetype)login_phone:(NSString *)phone pwd:(NSString *)pwd type:(NSNumber *)type;

@end

