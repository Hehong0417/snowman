//
//  HJAfterSalesListAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJAfterSaleListModel,HJAfterSalesPricelistModel;
@interface HJAfterSalesListAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJAfterSaleListModel *> *data;

+ (instancetype)afterSalesList_page:(NSNumber *)page rows:(NSNumber *)rows;

@end
@interface HJAfterSaleListModel : HJBaseModel

@property (nonatomic, assign) NSInteger payType;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, copy) NSString *refundNo;

@property (nonatomic, assign) NSInteger refundId;

@property (nonatomic, strong) NSArray<HJAfterSalesPricelistModel *> *priceList;

@property (nonatomic, copy) NSString *fee;

@property (nonatomic, copy) NSString *actualFee;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *goodsIco;

@property (nonatomic, assign) NSInteger isSpecial;

@end

@interface HJAfterSalesPricelistModel : HJBaseModel

@property (nonatomic, copy) NSString *unitName;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger standardType;

@property (nonatomic, assign) NSInteger parameterValue;

@property (nonatomic, copy) NSString *formerPrice;

@property (nonatomic, assign) NSInteger parameterId;

@end

