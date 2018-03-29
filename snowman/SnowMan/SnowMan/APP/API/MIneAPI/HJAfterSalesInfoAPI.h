//
//  HJAfterSalesInfoAPI.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJAfterSalesInfoModel;
@interface HJAfterSalesInfoAPI : HJBaseAPI

@property (nonatomic, strong) HJAfterSalesInfoModel *data;

+ (instancetype)afterSalesInfoRequestWithRefundId:(NSNumber *)refundId;
@end


@class HJAfterSalesInfoPriceListModel;
@interface HJAfterSalesInfoModel : NSObject

@property (nonatomic, copy) NSString *refundNo;

@property (nonatomic, copy) NSString *cause;

@property (nonatomic, assign) NSInteger refundId;

@property (nonatomic, copy) NSString *consignee;

@property (nonatomic, copy) NSString *consigneePhone;

@property (nonatomic, copy) NSString *receiptName;

@property (nonatomic, assign) NSInteger payType;

@property (nonatomic, copy) NSString *orderNo;

@property (nonatomic, copy) NSString *sendName;

@property (nonatomic, copy) NSString *orderTime;

@property (nonatomic, copy) NSString *payTime;

@property (nonatomic, copy) NSString *confirmTime;

@property (nonatomic, copy) NSString *refundTime;

@property (nonatomic, copy) NSString *fee;
//
//@property (nonatomic, assign) NSInteger *goodsId;

@property (nonatomic, copy) NSString *goodsIco;

@property (nonatomic, assign) NSInteger isSpecial;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, strong) NSArray<HJAfterSalesInfoPriceListModel *> *priceList;

@end

@interface HJAfterSalesInfoPriceListModel : NSObject

@property (nonatomic, assign) NSInteger parameterValue;

@property (nonatomic, assign) NSInteger parameterId;

@property (nonatomic, copy) NSString *formerPrice;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, assign) NSInteger count;

@property (nonatomic, assign) NSInteger standardType;

@end



