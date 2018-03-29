//
//  HJOrderInfoAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJOrderInfoModel,HJOrderInfoGoodslistModel,HJOrderInfoPricelistModel;
@interface HJOrderInfoAPI : HJBaseAPI

@property (nonatomic, strong) HJOrderInfoModel *data;

+ (instancetype)orderInfo_orderId:(NSNumber *)orderId;

@end
@interface HJOrderInfoModel : NSObject

@property (nonatomic, copy) NSString *consignee;

@property (nonatomic, copy) NSString *sendName;

@property (nonatomic, assign) NSInteger state;

@property (nonatomic, copy) NSString *orderTime;

@property (nonatomic, copy) NSString *consigneePhone;

@property (nonatomic, copy) NSString *receiptName;

@property (nonatomic, copy) NSString *payTime;

@property (nonatomic, copy) NSString *fee;

@property (nonatomic, copy) NSString *getScore;

@property (nonatomic, strong) NSArray<HJOrderInfoGoodslistModel *> *goodsList;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, assign) NSInteger payType;

@property (nonatomic, assign) NSInteger orderId;

@property (nonatomic, copy) NSString *preferentialMoney;

@property (nonatomic, copy) NSString *confirmTime;

@property (nonatomic, copy) NSString *actualFee;

@property (nonatomic, assign) BOOL isSpecial;

@end

@interface HJOrderInfoGoodslistModel : NSObject

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, assign) NSInteger isAfterSales;

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, copy) NSString *goodsIco;

@property (nonatomic, assign) BOOL isSpecial;

@property (nonatomic, strong) NSArray<HJOrderInfoPricelistModel *> *priceList;

@end

@interface HJOrderInfoPricelistModel : NSObject

@property (nonatomic, copy) NSString *formerPrice;

@property (nonatomic, assign) NSInteger parameterId;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger standardType;

@property (nonatomic, assign) NSInteger parameterValue;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, copy) NSString *unitPrice;

@end

