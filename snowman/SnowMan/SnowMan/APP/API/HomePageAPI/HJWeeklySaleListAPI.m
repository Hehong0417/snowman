//
//  HJWeeklySaleListAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJWeeklySaleListAPI.h"

@implementation HJWeeklySaleListAPI

+ (instancetype)weeklySaleList {
    
    HJWeeklySaleListAPI *api = [self new];
    
    api.subUrl = API_WEEKLY_SALE_LIST;
    
    return api;
}


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJHomePageGoodsListModel class]};
}
@end

@implementation HJHomePageGoodsListModel

+ (NSDictionary *)objectClassInArray{
    return @{@"standardList" : [HJStandardlistModel class]};
}

@end


@implementation HJStandardlistModel

+ (NSDictionary *)objectClassInArray{
    return @{@"priceList" : [HJPricelistModel class]};
}

@end


@implementation HJPricelistModel

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


