//
//  HJSecondClassifyAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSecondClassifyAPI.h"
#import "HJFirstClassifyAPI.h"

@implementation HJSecondClassifyAPI

+ (instancetype)sencondClassify_goodsTypeId:(NSNumber *)goodsTypeId {
    HJSecondClassifyAPI * api = [self new];
    [api.parameters setObject:goodsTypeId forKey:@"goodsTypeId"];
    api.subUrl = API_SECONDC_CLASSIFY;
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJClassifyModel class]};
}
@end



