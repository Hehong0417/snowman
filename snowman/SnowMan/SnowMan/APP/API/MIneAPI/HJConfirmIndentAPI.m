//
//  HJConfirmIndentAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJConfirmIndentAPI.h"

@implementation HJConfirmIndentAPI
+ (instancetype)confirmIndent_orderId:(NSNumber *)orderId {
    HJConfirmIndentAPI * api = [self new];
    [api.parameters setObject:orderId forKey:@"orderId"];
    api.subUrl = API_CONFIRMINDENT;
    return api;

}
@end


@implementation HJConfirmModel

@end