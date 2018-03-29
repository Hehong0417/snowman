//
//  HJCartSubmitOrderAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCartSubmitOrderAPI.h"

@implementation HJCartSubmitOrderAPI

+ (instancetype)cartSubmitOrder_receiptName:(NSString *)receiptName sendId:(NSNumber *)sendId shopCartArray:(NSString *)shopCartArray boxArray:(NSString *)boxArray isUseScore:(NSNumber *)isUseScore payType:(NSNumber *)payType orderType:(NSNumber *)orderType consignee:(NSString *)consignee consigneePhone:(NSString *)consigneePhone isSpecial:(NSNumber *)isSpecial {
    
    HJCartSubmitOrderAPI *api = [self new];
    
    [api.parameters setObject:receiptName forKey:@"receiptName"];
    [api.parameters setObject:sendId forKey:@"sendId"];
    if (shopCartArray) {
        
        [api.parameters setObject:shopCartArray forKey:@"shopCartArray"];
  
    }
    
    if (boxArray) {
        
        [api.parameters setObject:boxArray forKey:@"boxArray"];
   
    }
    
    [api.parameters setObject:isUseScore forKey:@"isUseScore"];
    [api.parameters setObject:payType forKey:@"payType"];
    [api.parameters setObject:orderType forKey:@"orderType"];
    [api.parameters setObject:consignee forKey:@"consignee"];
    [api.parameters setObject:consigneePhone forKey:@"consigneePhone"];
    [api.parameters setObject:isSpecial forKey:@"isSpecial"];
    
    api.subUrl = API_CART_SUBMIT_ORDER;
    
    return api;
}

@end
