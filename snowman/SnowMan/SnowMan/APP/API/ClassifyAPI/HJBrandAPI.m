//
//  HJBrandAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBrandAPI.h"

@implementation HJBrandAPI

+ (instancetype)brand_goodsTypeId:(NSNumber *)goodsTypeId type:(NSNumber *)type {
    HJBrandAPI * api = [self new];
    [api.parameters setObject:goodsTypeId forKey:@"goodsTypeId"];
    [api.parameters setObject:type forKey:@"type"];
    api.subUrl = API_BRAND;
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJBrandModel class]};
}
@end
@implementation HJBrandModel

@end


