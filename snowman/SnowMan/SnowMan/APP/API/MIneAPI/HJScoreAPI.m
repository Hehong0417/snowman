//
//  HJScoreAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJScoreAPI.h"

@implementation HJScoreAPI

+ (instancetype)score_page:(NSNumber *)page rows:(NSNumber *)rows {
    HJScoreAPI * api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_SCORE;
    return api;
}
@end


@implementation HJScoreModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"scoreList" : [HJScoreListModel class]};
}
@end

@implementation HJScoreListModel


@end
