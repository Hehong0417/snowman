//
//  HJUpdatePwdAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJUpdatePwdAPI : HJBaseAPI

+ (instancetype)updatePwd_oldPwd:(NSString *)oldPwd newPwd:(NSString*)newPwd;
@end
