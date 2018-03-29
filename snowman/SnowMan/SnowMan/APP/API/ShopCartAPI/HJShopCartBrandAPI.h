//
//  HJShopCartBrandAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJShopCartModel;
@interface HJShopCartBrandAPI : HJBaseAPI
@property (nonatomic, strong) HJShopCartModel *data;
+ (instancetype)shopCartBrand;
@end

@interface HJShopCartModel : HJBaseModel
@property (nonatomic, strong) NSMutableArray *goodsList;
@property (nonatomic, strong) NSMutableArray *boxList;
@end

@interface HJGoodsListModell : HJBaseModel

@property (nonatomic, assign) NSInteger isSpecial;
@property (nonatomic, assign) NSInteger shopCartId;
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, copy) NSString *goodsIco;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, strong) NSArray *priceList;

@end

@interface HJPriceListModel : HJBaseModel
@property (nonatomic, assign) NSInteger shopCartId;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger standardType;
@property (nonatomic, assign) NSInteger parameterId;
@property (nonatomic, copy) NSString *formerPrice;
@property (nonatomic, copy) NSString *currentPrice;
@property (nonatomic, copy) NSString *unitName;
@property (nonatomic, copy) NSString *unitPrice;
@property (nonatomic, assign) NSInteger parameterValue;
@end

@interface HJBoxListModel : HJBaseModel
@property (nonatomic, assign) NSInteger isSpecial;
@property (nonatomic, assign) NSInteger boxId;
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, copy) NSString *goodsIco;
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, strong) NSArray *priceList;
@end

@interface HJBoxPriceListModel : HJBaseModel
@property (nonatomic, assign) NSInteger parameterValue;
@property (nonatomic, assign) NSInteger count;
@property (nonatomic, assign) NSInteger standardType;
@property (nonatomic, copy) NSString *formerPrice;
@property (nonatomic, copy) NSString *currentPrice;
@property (nonatomic, assign) NSInteger parameterId;
@property (nonatomic, copy) NSString *unitName;
@property (nonatomic, copy) NSString *unitPrice;

@end

