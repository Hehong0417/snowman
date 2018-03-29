//
//  HJGoodsStandardPriceModel.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/20.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseModel.h"
#import "HJGoodsIntroduceAPI.h"

@interface HJGoodsStandardPriceModel : HJBaseModel

+ (NSString *)goodsStandardPriceBaseOnStandardPriceList:(NSArray<HJGoodsIntroducePricelistModel *> *)pricelist isCurrentPrice:(BOOL)isCurrentPrice;

+ (BOOL)goodsStandardPriceExistBaseOnStandardPriceList:(NSArray<HJGoodsIntroducePricelistModel *> *)pricelist isCurrentPrice:(BOOL)isCurrentPrice;

@end
