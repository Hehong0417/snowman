//
//  HJCancelIndentAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCancelIndentAPI.h"

@implementation HJCancelIndentAPI

+ (instancetype)cancelIndent_orderId:(NSNumber *)orderId {
    HJCancelIndentAPI * api = [self new];
    [api.parameters setObject:orderId forKey:@"orderId"];
    api.subUrl = API_DELETE_ORDER;
    return api;
}
@end
