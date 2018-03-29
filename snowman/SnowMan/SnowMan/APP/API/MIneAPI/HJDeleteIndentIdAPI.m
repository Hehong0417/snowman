//
//  HJDeleteIndentIdAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJDeleteIndentIdAPI.h"

@implementation HJDeleteIndentIdAPI
+ (instancetype)deleteOrderWithOrderId:(NSNumber *)OrderId; {
    HJDeleteIndentIdAPI * api = [self new];
    [api.parameters setObject:OrderId forKey:@"OrderId"];
    api.subUrl = API_DELETEORDER;
    return api;

}
@end
