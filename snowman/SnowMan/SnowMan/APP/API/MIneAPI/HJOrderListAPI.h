//
//  HJOrderListAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJWeeklySaleListAPI.h"

@class HJOrderListModel,HJOrderGoodslistModel,HJOrderPricelistModel;
@interface HJOrderListAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJOrderListModel *> *data;

+ (instancetype)orderList_state:(HJOrderState)state page:(NSNumber *)page rows:(NSNumber *)rows;

@end
@interface HJOrderListModel : HJBaseModel

@property (nonatomic, assign) NSInteger amount;

@property (nonatomic, copy) NSString *actualFee;

@property (nonatomic, assign) HJPayChannelType payType;

@property (nonatomic, copy) NSString *orderId;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, copy) NSString *orderTime;

@property (nonatomic, copy) NSString *fee;

@property (nonatomic, copy) NSString *sendName;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, strong) NSArray<HJOrderGoodslistModel *> *goodsList;

@property (nonatomic, assign) BOOL isSpecial;

@end

@interface HJOrderGoodslistModel : HJBaseModel

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger isAfterSales;

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, copy) NSString *goodsIco;

@property (nonatomic, strong) NSArray<HJOrderPricelistModel *> *priceList;

@property (nonatomic, assign) BOOL isSpecial;

@end

@interface HJOrderPricelistModel : HJBaseModel

@property (nonatomic, copy) NSString *formerPrice;

@property (nonatomic, copy) NSString *parameterName;

/**
 *  特殊商品单位字段
 */
@property (nonatomic, copy) NSString *unitPrice;

//@property (nonatomic, copy) NSString *unitName;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger standardType;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, assign) NSInteger parameterId;

@end

