//
//  HJDeleteAfterOrderAPI.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJDeleteAfterOrderAPI.h"

@implementation HJDeleteAfterOrderAPI
+ (instancetype)deleteAfterOrderWithRefundId:(NSNumber *)refundId
{
    HJDeleteAfterOrderAPI *api = [[HJDeleteAfterOrderAPI alloc] init];
    [api.parameters setObject:refundId forKey:@"refundId"];
    api.subUrl = API_DELETE_REFUND;
    return api;
}

@end
