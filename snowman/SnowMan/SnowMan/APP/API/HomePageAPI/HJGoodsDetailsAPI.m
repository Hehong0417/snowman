//
//  HJGoodsDetailsAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGoodsDetailsAPI.h"

@implementation HJGoodsDetailsAPI

+ (instancetype)goodsDetail_goodsId:(NSString *)goodsId; {
    HJGoodsDetailsAPI * api = [self new];
    [api.parameters setObject:goodsId  forKey:@"goodsId"];
    api.subUrl = API_GOODS_DETAILS;
    return api;
}
@end
