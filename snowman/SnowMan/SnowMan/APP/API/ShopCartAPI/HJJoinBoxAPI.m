//
//  HJJoinBoxAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJJoinBoxAPI.h"

@implementation HJJoinBoxAPI

+ (instancetype)joinBox_goodsId:(NSString *)goodsId parameterList:(NSString *)parameterList{
    HJJoinBoxAPI *api = [self new];
    [api.parameters setObject:goodsId forKey:@"goodsId"];
     [api.parameters setObject:parameterList forKey:@"parameterList"];
    api.subUrl = API_JOINBOX;
    return api;
}
@end
