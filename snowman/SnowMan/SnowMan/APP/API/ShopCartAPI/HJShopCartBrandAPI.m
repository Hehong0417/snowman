//
//  HJShopCartBrandAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJShopCartBrandAPI.h"

@implementation HJShopCartBrandAPI

+ (instancetype)shopCartBrand {
    
    HJShopCartBrandAPI *api = [self new];
    
    api.subUrl = API_SHOPCART_BRAND;
    
    return api;
}

@end

@implementation HJShopCartModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"goodsList" : [HJGoodsListModell class],
             @"boxList" : [HJBoxListModel class]
             };
}
@end

@implementation HJGoodsListModell
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"priceList" : [HJPriceListModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    
    //特殊商品变普通
    if (self.isSpecial) {
        
        HJPriceListModel *pricelistModel = [self.priceList objectOrNilAtIndex:0];
        if (pricelistModel.unitName.length > 0) {
            
            if ([pricelistModel.unitName isEqualToString:pricelistModel.unitPrice]) {
                
                self.isSpecial = 0;
            }
            
        }
        
    }

}

@end

@implementation HJPriceListModel

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

@implementation HJBoxListModel
+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"priceList" : [HJBoxPriceListModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    
    //特殊商品变普通
    if (self.isSpecial) {
        
        HJPriceListModel *pricelistModel = [self.priceList objectOrNilAtIndex:0];
        if (pricelistModel.unitName.length > 0) {
            
            if ([pricelistModel.unitName isEqualToString:pricelistModel.unitPrice]) {
                
                self.isSpecial = 0;
            }
            
        }
        
    }
    
}

@end

@implementation HJBoxPriceListModel

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


