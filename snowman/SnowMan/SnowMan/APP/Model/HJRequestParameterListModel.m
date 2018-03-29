//
//  HJRequestParameterListModel.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJRequestParameterListModel.h"



@implementation HJRequestParameterListModel
+ (NSString *)parameterGoodsListStringFromGoodsListModelArray:(NSArray<HJGoodsListModell *> *)GoodsListModelArray
{
    NSMutableArray *requestParameterGoodsList = [NSMutableArray array];
    [GoodsListModelArray enumerateObjectsUsingBlock:^(HJGoodsListModell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HJRequestParameterListModel *requestParameterListModel = [HJRequestParameterListModel new];
        requestParameterListModel.goodsId = obj.goodsId;
        
        NSMutableArray *priceListArray = [NSMutableArray array];
        [obj.priceList enumerateObjectsUsingBlock:^(HJPriceListModel * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            HJParameterListModel *parameterListModel = [HJParameterListModel new];
            parameterListModel.parameterId = obj1.parameterId;
            parameterListModel.count = obj1.count;
            [priceListArray addObject:parameterListModel.mj_keyValues];
        }];
        
        requestParameterListModel.parameterList = priceListArray;
        [requestParameterGoodsList addObject:requestParameterListModel.mj_keyValues];
    }];
    
    return requestParameterGoodsList.jsonStringEncoded;
}


//+ (NSString *)parameterGoodsListStringFromGoodsListModelArray:(NSArray<HJGoodsListModell *> *)GoodsListModelArray
//{
//    NSMutableArray *requestParameterGoodsList = [NSMutableArray array];
//    [GoodsListModelArray enumerateObjectsUsingBlock:^(HJGoodsListModell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        HJGoodsListModell *parameterModel = [HJGoodsListModell new];
//        parameterModel.goodsId = obj.goodsId;
//        
//        NSMutableArray *priceListArray = [NSMutableArray array];
//        [obj.priceList enumerateObjectsUsingBlock:^(HJPriceListModel * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
//            HJPriceListModel *priceList = [HJPriceListModel new];
//            priceList.parameterId = obj1.parameterId;
//            priceList.count = obj1.count;
//            [priceListArray addObject:priceList.mj_keyValues];
//        }];
//        
//        parameterModel.priceList = priceListArray;
//        [requestParameterGoodsList addObject:parameterModel.mj_keyValues];
//    }];
//    
//    return requestParameterGoodsList.jsonStringEncoded;
//}


//+ (NSString *)parameterGoodsListStringFromGoodsListModelArray:(NSArray<HJGoodsListModell *> *)GoodsListModelArray
//{
//    NSMutableArray *requestParameterGoodsList = [NSMutableArray array];
//    [GoodsListModelArray enumerateObjectsUsingBlock:^(HJGoodsListModell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//        HJRequestParameterListModel *requestParameterListModel = [HJRequestParameterListModel new];
//        requestParameterListModel.goodsId = obj.goodsId;
//        
//        NSMutableArray *priceListArray = [NSMutableArray array];
//        [obj.priceList enumerateObjectsUsingBlock:^(HJPriceListModel * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
//            HJParameterListModel *parameterListModel = [HJParameterListModel new];
//            parameterListModel.parameterId = obj1.parameterId;
//            parameterListModel.count = obj1.count;
//            [priceListArray addObject:parameterListModel.mj_keyValues];
//        }];
//        
//        requestParameterListModel.parameterList = priceListArray;
//        [requestParameterGoodsList addObject:requestParameterListModel.mj_keyValues];
//    }];
//    
//    return requestParameterGoodsList.jsonStringEncoded;
//}



+ (NSString *)parameterGoodsListStringFromBoxListModelArray:(NSArray<HJBoxListModel *> *)boxListModelArray
{
    NSMutableArray *requestParameterBoxsList = [NSMutableArray array];
    [boxListModelArray enumerateObjectsUsingBlock:^(HJBoxListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HJRequestParameterListModel *requestParameterListModel = [HJRequestParameterListModel new];
        requestParameterListModel.goodsId = obj.goodsId;
        
        NSMutableArray *priceListArray = [NSMutableArray array];
        [obj.priceList enumerateObjectsUsingBlock:^(HJBoxPriceListModel * _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
            HJParameterListModel *parameterListModel = [HJParameterListModel new];
            parameterListModel.parameterId = obj1.parameterId;
            parameterListModel.count = obj1.count;
            [priceListArray addObject:parameterListModel.mj_keyValues];
        }];
        
        requestParameterListModel.parameterList = priceListArray;
        [requestParameterBoxsList addObject:requestParameterListModel.mj_keyValues];
    }];
    
    return requestParameterBoxsList.jsonStringEncoded;
}
@end


@implementation HJParameterListModel

@end





