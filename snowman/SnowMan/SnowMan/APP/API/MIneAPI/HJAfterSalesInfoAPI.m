//
//  HJAfterSalesInfoAPI.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAfterSalesInfoAPI.h"

@implementation HJAfterSalesInfoAPI
+ (instancetype)afterSalesInfoRequestWithRefundId:(NSNumber *)refundId
{
    HJAfterSalesInfoAPI *api = [[HJAfterSalesInfoAPI alloc] init];
    [api.parameters setObject:refundId forKey:@"refundId"];
    api.subUrl = API_AFTER_SALES_INFO;
    return api;
}

@end

@implementation HJAfterSalesInfoModel

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"priceList" : [HJAfterSalesInfoPriceListModel class]};
}

@end

@implementation HJAfterSalesInfoPriceListModel

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
