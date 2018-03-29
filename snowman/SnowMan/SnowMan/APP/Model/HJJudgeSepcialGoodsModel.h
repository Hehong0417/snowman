//
//  HJJudgeSepcialGoodsModel.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/25.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseModel.h"
#import "HJOrderListAPI.h"
#import "HJOrderInfoAPI.h"

@interface HJJudgeSepcialGoodsModel : HJBaseModel

+ (BOOL)judgeSpecialGoodsWithOrderGoodsListModels:(NSArray <HJOrderGoodslistModel *> *)goodsListModels;

+ (BOOL)judgeSpecialGoodsWithHJOrderInfoGoodslistModel:(NSArray <HJOrderInfoGoodslistModel *> *)infoGoodslistModels;
@end
