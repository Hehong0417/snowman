//
//  HJAfterSalesListAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAfterSalesListAPI.h"

@implementation HJAfterSalesListAPI

+ (instancetype)afterSalesList_page:(NSNumber *)page rows:(NSNumber *)rows {
    
    HJAfterSalesListAPI *api = [self new];
    
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    
    api.subUrl = API_AFTER_SALES_LIST;
    
    return api;
}


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJAfterSaleListModel class]};
}
@end
@implementation HJAfterSaleListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"priceList" : [HJAfterSalesPricelistModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    
    if ([self.fee lh_numberOfDecimal]>2) {
        
        
        CGFloat fee = self.fee.floatValue;
        
        self.fee = [NSString stringWithFormat:@"%.2f",fee];
        
    }
}

@end


@implementation HJAfterSalesPricelistModel

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


