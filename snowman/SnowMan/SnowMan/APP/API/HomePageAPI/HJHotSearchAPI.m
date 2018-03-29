//
//  HJHotSearchAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJHotSearchAPI.h"

@implementation HJHotSearchAPI
+ (instancetype)hotSearch {
    HJHotSearchAPI * api = [self new];
    api.subUrl = API_HOT_SEARCH;
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJHotSearchModel class]};
}
@end
@implementation HJHotSearchModel

@end


