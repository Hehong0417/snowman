//
//  HJJudgeSepcialGoodsModel.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJJudgeSepcialGoodsModel.h"

@implementation HJJudgeSepcialGoodsModel

+ (BOOL)judgeSpecialGoodsWithOrderGoodsListModels:(NSArray<HJOrderGoodslistModel *> *)goodsListModels {
    
    __block  BOOL haveSpecialGoods = NO;
    
    [goodsListModels enumerateObjectsUsingBlock:^(HJOrderGoodslistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.isSpecial) {
            
            haveSpecialGoods = YES;
        }
        
    }];
    
    return haveSpecialGoods;
}

+ (BOOL)judgeSpecialGoodsWithHJOrderInfoGoodslistModel:(NSArray <HJOrderInfoGoodslistModel *> *)infoGoodslistModels
{
    __block  BOOL haveSpecialGoods = NO;
    
    [infoGoodslistModels enumerateObjectsUsingBlock:^(HJOrderInfoGoodslistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.isSpecial) {
            
            haveSpecialGoods = YES;
        }
        
    }];
    
    return haveSpecialGoods;
}


@end
