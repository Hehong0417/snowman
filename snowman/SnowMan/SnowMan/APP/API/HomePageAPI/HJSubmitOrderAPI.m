//
//  HJSubmitOrderAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSubmitOrderAPI.h"

@implementation HJSubmitOrderAPI

+ (instancetype)submitOrder_receiptName:(NSString *)receiptName sendId:(NSNumber *)sendId goodsId:(NSNumber *)goodsId parameterList:(NSString *)parameterList isUseScore:(NSNumber *)isUseScore payType:(NSNumber *)payType orderType:(NSNumber *)orderType consignee:(NSString *)consignee consigneePhone:(NSString *)consigneePhone isSpecial:(NSNumber *)isSpecial {
    
    HJSubmitOrderAPI *api = [self new];
    
    [api.parameters setObject:receiptName forKey:@"receiptName"];
    [api.parameters setObject:sendId forKey:@"sendId"];
    [api.parameters setObject:goodsId forKey:@"goodsId"];
    [api.parameters setObject:parameterList forKey:@"parameterList"];
    [api.parameters setObject:isUseScore forKey:@"isUseScore"];
    [api.parameters setObject:payType forKey:@"payType"];
    [api.parameters setObject:orderType forKey:@"orderType"];
    [api.parameters setObject:consignee forKey:@"consignee"];
    [api.parameters setObject:consigneePhone forKey:@"consigneePhone"];
    [api.parameters setObject:isSpecial forKey:@"isSpecial"];

    api.subUrl = API_SUBMIT_ORDER;
    
    return api;
}

@end

@implementation HJSubmitOrderModel


@end
