//
//  HJGoodsStandardPriceModel.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/20.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGoodsStandardPriceModel.h"
#import "HJConfigureStandardSizeModel.h"

@implementation HJGoodsStandardPriceModel

+ (NSString *)goodsStandardPriceBaseOnStandardPriceList:(NSArray<HJGoodsIntroducePricelistModel *> *)pricelist isCurrentPrice:(BOOL)isCurrentPrice {
    
    
    NSMutableArray *goodsPriceArray = [NSMutableArray array];
    
    //
    [pricelist enumerateObjectsUsingBlock:^(HJGoodsIntroducePricelistModel * _Nonnull priceListModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *priceString = [NSString stringWithFormat:@"¥%@/%@",isCurrentPrice?priceListModel.currentPrice:priceListModel.formerPrice,[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:priceListModel.standardType]];
        
        if (isCurrentPrice == NO) {
            
            NSString *formerPrice = priceListModel.formerPrice;
            
            if (formerPrice.floatValue != 0 && ![formerPrice isEqualToString:@"null"] && ![formerPrice isEqualToString:kEmptySrting]) {
                
                [goodsPriceArray addObject:priceString];
            }

            
        } else {
            
            [goodsPriceArray addObject:priceString];

        }
        
         }];
    
    return [goodsPriceArray componentsJoinedByString:@"  "];
}

+ (BOOL)goodsStandardPriceExistBaseOnStandardPriceList:(NSArray<HJGoodsIntroducePricelistModel *> *)pricelist isCurrentPrice:(BOOL)isCurrentPrice {
    
    //
    __block BOOL exist = NO;
    
    //
    [pricelist enumerateObjectsUsingBlock:^(HJGoodsIntroducePricelistModel * _Nonnull priceListModel, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSString *formerPrice = priceListModel.formerPrice;
        
        if (formerPrice.floatValue != 0 && ![formerPrice isEqualToString:@"null"] && ![formerPrice isEqualToString:kEmptySrting]) {
            
            exist = YES;
            
            *stop = YES;
            
        }
        
    }];
    
    return exist;
}

@end
