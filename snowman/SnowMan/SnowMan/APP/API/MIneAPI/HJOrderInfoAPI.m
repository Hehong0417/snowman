//
//  HJOrderInfoAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderInfoAPI.h"

@implementation HJOrderInfoAPI

+ (instancetype)orderInfo_orderId:(NSNumber *)orderId {
    
    HJOrderInfoAPI *api = [self new];
    
    [api.parameters setObject:orderId forKey:@"orderId"];
    
    api.subUrl = API_ORDERINFO;
    
    return api;
}

@end

@implementation HJOrderInfoGoodslistModel

+ (NSDictionary *)objectClassInArray{
    return @{@"priceList" : [HJOrderInfoPricelistModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @{@"ID" : @"id"};
}

@end

@implementation HJOrderInfoModel

+ (NSDictionary *)objectClassInArray{
    return @{@"goodsList" : [HJOrderInfoGoodslistModel class]};
}

@end

@implementation HJOrderInfoPricelistModel

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

