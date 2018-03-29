//
//  HJSubmitOrderAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

//receiptId	int	yes	地址ID
//sendId	int	yes	配送时间ID
//goodsId	int	yes	商品Id
//parameterList		yes	规格列表
//parameterId	parameterList	yes	规格值Id
//count	parameterList	yes	商品数量
//isUseScore	int	yes	是否使用积分
//payType	int	yes	支付方式（1.支付宝、2.微信、3.货到付款）
//isSpecial	int	yes	特殊订单（0否1是）

@class HJSubmitOrderModel;
@interface HJSubmitOrderAPI : HJBaseAPI

@property (nonatomic, strong) HJSubmitOrderModel *data;

+ (instancetype)submitOrder_receiptName:(NSString *)receiptName sendId:(NSNumber *)sendId goodsId:(NSNumber *)goodsId parameterList:(NSString *)parameterList isUseScore:(NSNumber *)isUseScore
                                payType:(NSNumber *)payType orderType:(NSNumber *)orderType consignee:(NSString *)consignee consigneePhone:(NSString *)consigneePhone isSpecial:(NSNumber *)isSpecial;

@end

@interface HJSubmitOrderModel : HJBaseModel

@property (nonatomic, strong) NSString *orderNo;

@end
