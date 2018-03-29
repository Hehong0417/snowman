//
//  HJWeeklySaleListAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJBaseModel.h"

@class HJHomePageGoodsListModel,HJStandardlistModel,HJPricelistModel;
@interface HJWeeklySaleListAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJHomePageGoodsListModel *> *data;


+ (instancetype)weeklySaleList;

@end
@interface HJHomePageGoodsListModel : HJBaseModel

@property (nonatomic, strong) NSArray<HJStandardlistModel *> *standardList;

@property (nonatomic, assign) NSInteger isSpecial;

@property (nonatomic, copy) NSString *goodsIco;

@property (nonatomic, copy) NSString *goodsId;

@end

@interface HJStandardlistModel : HJBaseModel

@property (nonatomic, copy) NSString *unitName;

@property (nonatomic, assign) NSInteger standardId;

@property (nonatomic, copy) NSString *unitPrice;

@property (nonatomic, copy) NSString *standardName;

@property (nonatomic, strong) NSArray<HJPricelistModel *> *priceList;

@property (nonatomic, assign) NSInteger standardSize;

@end

@interface HJPricelistModel : HJBaseModel

@property (nonatomic, copy) NSString *formerPrice;

@property (nonatomic, assign) HJStandardValueType standardType;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, assign) NSInteger priceId;

@end

