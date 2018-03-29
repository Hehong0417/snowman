//
//  HJGetGoodsListAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

typedef NS_ENUM(NSUInteger, HJGoodsClassifyIdType) {
    HJGoodsClassifyIdTypeFirst = 1,
    HJGoodsClassifyIdTypeSecond,
};

@class HJGoodsListModel,HJStandardlistModel,HJPricelistModel;
@interface HJGetGoodsListAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJGoodsListModel *> *data;

+ (instancetype)getGoodsList_goodsTypeId:(NSNumber *)goodsTypeId type:(HJGoodsClassifyIdType)type brandId:(NSNumber *)brandId page:(NSNumber *)page rows:(NSNumber *)rows;

@end
@interface HJGoodsListModel : HJBaseModel

@property (nonatomic, strong) NSArray<HJStandardlistModel *> *standardList;

@property (nonatomic, assign) NSInteger isSpecial;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, copy) NSString *goodsId;

@property (nonatomic, copy) NSString *goodsIco;

@property (nonatomic, copy) NSString *brandName;

@end

