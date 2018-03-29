//
//  HJCommentPagAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCommentPagAPI.h"

@implementation HJCommentPagAPI
+ (instancetype)commentPag_orderId:(NSNumber *)orderId {
    HJCommentPagAPI * api = [self new];
    [api.parameters setObject:orderId forKey:@"orderId"];
    api.subUrl = API_COMMENTPAG;
    return api;
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"data" : [HJOrderCommentModel class]};
}
@end

@implementation HJOrderCommentModel
+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{@"Id" : @"id"};
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"imageList" : [HJImageListModel class]};
}

@end

@implementation HJImageListModel


@end
