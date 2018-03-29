//
//  HJUpdatePwdAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJUpdatePwdAPI.h"

@implementation HJUpdatePwdAPI

+ (instancetype)updatePwd_oldPwd:(NSString *)oldPwd newPwd:(NSString*)newPwd {
    HJUpdatePwdAPI * api = [self new];
    [api.parameters setObject:oldPwd forKey:@"oldPwd"];
    [api.parameters setObject:newPwd forKey:@"newPwd"];
    api.subUrl = API_UPDATEPWD;
    return api;

}
@end
