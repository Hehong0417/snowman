//
//  HJOrderListAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderListAPI.h"

@implementation HJOrderListAPI

+ (instancetype)orderList_state:(HJOrderState)state page:(NSNumber *)page rows:(NSNumber *)rows {
    HJOrderListAPI * api = [self new];
    [api.parameters setObject:@(state) forKey:@"state"];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_ORDERLIST;
    return api;
}


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJOrderListModel class]};
}
@end


@implementation HJOrderListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"goodsList" : [HJOrderGoodslistModel class]};
}

@end


@implementation HJOrderGoodslistModel

+ (NSDictionary *)objectClassInArray{
    return @{@"priceList" : [HJOrderPricelistModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}

@end


@implementation HJOrderPricelistModel

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"unitPrice":@"unitName"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    
    if ([self.formerPrice lh_numberOfDecimal]>2) {
        
        
        CGFloat formerPrice = self.formerPrice.floatValue;
        
        self.formerPrice = [NSString stringWithFormat:@"%.2f",formerPrice];
        
    }
    
    if ([self.currentPrice lh_numberOfDecimal]>2) {
        
        CGFloat currentPrice = self.currentPrice.floatValue;
        self.currentPrice = [NSString stringWithFormat:@"%.2f",currentPrice];
        
    }
    
}

@end


