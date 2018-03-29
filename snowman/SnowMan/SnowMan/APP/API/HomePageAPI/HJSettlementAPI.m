//
//  HJSettlementAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSettlementAPI.h"

@implementation HJSettlementAPI

+ (instancetype)settlement {
    
    HJSettlementAPI * api = [self new];
    api.subUrl = API_SETTLEMENT;
    return api;

}
@end
@implementation HJSettlementModel

+ (NSDictionary *)objectClassInArray{
    return @{@"sendList" : [HJSendlistModel class]};
}

@end


@implementation HJSendlistModel

@end


