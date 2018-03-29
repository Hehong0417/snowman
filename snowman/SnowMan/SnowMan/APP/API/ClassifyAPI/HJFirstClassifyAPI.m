//
//  HJFirstClassifyAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJFirstClassifyAPI.h"

@implementation HJFirstClassifyAPI

+ (instancetype)firstClassify {
    HJFirstClassifyAPI *api = [self new];
    api.subUrl = API_FIRST_CLASSIFY;
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJClassifyModel class]};
}
@end
@implementation HJClassifyModel

@end


