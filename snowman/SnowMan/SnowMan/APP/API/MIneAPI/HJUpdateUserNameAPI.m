//
//  HJUpdateUserNameAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJUpdateUserNameAPI.h"

@implementation HJUpdateUserNameAPI

+ (instancetype)updateUserName_userName:(NSString *)userName {
    HJUpdateUserNameAPI * api = [self new];
    [api.parameters setObject:userName forKey:@"userName"];
    api.subUrl = API_UPDATEUSERNAME;
    return api;
}
@end
