//
//  HJConfirmIndentAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJConfirmModel;
@interface HJConfirmIndentAPI : HJBaseAPI
@property (nonatomic, strong) HJConfirmModel *data;
+ (instancetype)confirmIndent_orderId:(NSNumber *)orderId;
@end

@interface HJConfirmModel : HJBaseModel
@property (nonatomic, copy) NSString *score;
@end


