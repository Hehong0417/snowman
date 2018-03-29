//
//  HJApplicationSaleAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJApplicationSaleAPI.h"

@implementation HJApplicationSaleAPI

+ (instancetype)applicationSale_orderId:(NSNumber *)orderId ID:(NSNumber *)ID type:(NSNumber *)type phone:(NSString *)phone cause:(NSString *)cause; {
    HJApplicationSaleAPI * api = [self new];
    [api.parameters setObject:orderId forKey:@"orderId"];
    [api.parameters setObject:ID forKey:@"id"];
    [api.parameters setObject:type forKey:@"type"];
    [api.parameters setObject:phone forKey:@"phone"];
    [api.parameters setObject:cause forKey:@"cause"];
    api.subUrl = API_APPLICATION_SALES;
    return api;
}
@end
