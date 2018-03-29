//
//  HJAreaListAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAreaListAPI.h"

@implementation HJAreaListAPI

+ (instancetype)areaList_areaId:(NSNumber *)areaId {
    HJAreaListAPI * api = [self new];
    if (areaId) {
        
        [api.parameters setObject:areaId forKey:@"areaId"];
    }
    api.subUrl = API_AREALIST;
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJAreaListModel class]};
}
@end
@implementation HJAreaListModel

@end


