

//
//  HJGoodsIntroduceAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGoodsIntroduceAPI.h"

@implementation HJGoodsIntroduceAPI

+ (instancetype)goodsIntroduce_goodsId:(NSString *)goodsId {
    HJGoodsIntroduceAPI * api = [self new];
    [api.parameters setObject:goodsId forKey:@"goodsId"];
    api.subUrl = API_GOODS_INTRODUCE;
    return api;
}
@end
@implementation HJGoodsIntroduceModel

+ (NSDictionary *)objectClassInArray{
    return @{@"standardList" : [HJGoodsIntroduceStandardlistModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    
    //特殊商品变普通处理
    if (self.isSpecial == 1) {
        
        HJGoodsIntroduceStandardlistModel *standardlistModel = [self.standardList objectOrNilAtIndex:0];
        NSString *unitName = standardlistModel.unitName;
        NSString *unitPrice = standardlistModel.unitPrice;
        if ([unitName isEqualToString:unitPrice]) {
            
            self.isSpecial = 0;
        }
    }

}

@end


@implementation HJGoodsIntroduceStandardlistModel

+ (NSDictionary *)objectClassInArray{
    return @{@"priceList" : [HJGoodsIntroducePricelistModel class]};
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName {
    
    return @ {@"standardName" : @"customMadeSize"};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    
    //规格排序处理
    if (self.unitName.length == 0) {
        
        NSArray *sortDescriptors = [NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"standardType" ascending:YES]];
        NSMutableArray *priceList = self.priceList.mutableCopy;
        [priceList sortUsingDescriptors:sortDescriptors];
        NSLog(@"排序后的数组%@",priceList);
        
        self.priceList = priceList;
    }
        
}



@end


@implementation HJGoodsIntroducePricelistModel

+ (NSDictionary *)objectClassInArray{
    return @{@"parameterList" : [HJParameterlistModel class]};
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


@implementation HJParameterlistModel

@end


