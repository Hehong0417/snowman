//
//  HJGetPayChargeAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGetPayChargeAPI.h"

@implementation HJGetPayChargeAPI

+ (instancetype)getPayCharge_orderNo:(NSNumber *)orderNo {
    HJGetPayChargeAPI * api = [self new];
    [api.parameters setObject:orderNo forKey:@"orderNo"];
    api.subUrl = API_GETPAYCHARGE;
    return api;
}
@end
