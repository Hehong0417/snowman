//
//  HJJoinShopCartAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJJoinShopCartAPI.h"

@implementation HJJoinShopCartAPI

+ (instancetype)joinShopCart_goodsId:(NSString *)goodsId parameterList:(NSString *)parameterList{
    HJJoinShopCartAPI * api = [self new];
    [api.parameters setObject:goodsId forKey:@"goodsId"];
    [api.parameters setObject:parameterList forKey:@"parameterList"];
    api.subUrl = API_JOINSHOPCART;
    return api;
}
@end
