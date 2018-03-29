//
//  HJSearchAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSearchAPI.h"

@implementation HJSearchAPI

+ (instancetype)search_goodsName:(NSString *)goodsName page:(NSNumber *)page rows:(NSNumber *)rows {
    HJSearchAPI * api = [self new];
    [api.parameters setObject:goodsName forKey:@"goodsName"];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_SEARCH;
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJGoodsListModel class]};
}

@end
