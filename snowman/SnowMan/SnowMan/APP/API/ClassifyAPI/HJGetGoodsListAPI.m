//
//  HJGetGoodsListAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGetGoodsListAPI.h"
#import "HJWeeklySaleListAPI.h"

@implementation HJGetGoodsListAPI

+ (instancetype)getGoodsList_goodsTypeId:(NSNumber *)goodsTypeId type:(HJGoodsClassifyIdType)type brandId:(NSNumber *)brandId page:(NSNumber *)page rows:(NSNumber *)rows {
    HJGetGoodsListAPI * api = [self new];
    [api.parameters setObject:goodsTypeId forKey:@"goodsTypeId"];
    [api.parameters setObject:@(type) forKey:@"type"];
    if (brandId) {
        
        [api.parameters setObject:brandId forKey:@"brandId"];
    }
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_GET_GOODS_LIST;
    return api;

}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJGoodsListModel class]};
}
@end
@implementation HJGoodsListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"standardList" : [HJStandardlistModel class]};
}

@end


