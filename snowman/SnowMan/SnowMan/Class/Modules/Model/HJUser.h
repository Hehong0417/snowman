//
//  HJUser.h
//  Bsh
//
//  Created by IMAC on 15/12/25.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "HJBaseModel.h"
@interface HJLoginModel : HJBaseModel
@property (nonatomic, copy) NSNumber *isFirstLogin;
@property (nonatomic, copy) NSNumber *userId;
@property (nonatomic, copy) NSString *token;
@end

@interface HJUser : HJBaseModel {
    HJLoginModel *_userModel;
}

singleton_h(User)

@property (nonatomic, strong) HJLoginModel *loginModel;

@property (nonatomic, assign) BOOL isRememberPwd;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, assign) BOOL isLogin;

@end
