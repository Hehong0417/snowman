//
//  HJCustomServiceAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCustomServiceAPI.h"

@implementation HJCustomServiceAPI

+ (instancetype)customService_indentId:(NSNumber *)indentId {
    HJCustomServiceAPI * api = [self new];
    [api.parameters setObject:indentId forKey:@"indentId"];
    api.subUrl = API_CUSTOMER_SERVICE;
    return api;
}
@end
