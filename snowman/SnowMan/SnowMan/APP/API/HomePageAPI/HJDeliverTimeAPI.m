//
//  HJDeliverTimeAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJDeliverTimeAPI.h"

@implementation HJDeliverTimeAPI

+ (instancetype)deliverTime {
    HJDeliverTimeAPI * api = [self new];
    api.subUrl = API_DELIVER_TIME;
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJDeliverTimeModel class]};
}
@end
@implementation HJDeliverTimeModel

@end


