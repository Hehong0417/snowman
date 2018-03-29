//
//  HJGoodsIntroduceAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJGoodsIntroduceModel,HJGoodsIntroduceStandardlistModel,HJGoodsIntroducePricelistModel,HJParameterlistModel;
@interface HJGoodsIntroduceAPI : HJBaseAPI

@property (nonatomic, strong) HJGoodsIntroduceModel *data;

+ (instancetype)goodsIntroduce_goodsId:(NSString *)goodsId;

@end
@interface HJGoodsIntroduceModel : HJBaseModel

@property (nonatomic, copy) NSString *area;

@property (nonatomic, copy) NSString *goodsName;

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, assign) NSInteger isBox;

@property (nonatomic, strong) NSArray<HJGoodsIntroduceStandardlistModel *> *standardList;

@property (nonatomic, assign) NSInteger isSpecial;

@property (nonatomic, copy) NSString *brandName;

@property (nonatomic, copy) NSString *goodsIco;

@end

@interface HJGoodsIntroduceStandardlistModel : HJBaseModel

@property (nonatomic, copy) NSString *unitName;

@property (nonatomic, assign) NSInteger standardId;

@property (nonatomic, copy) NSString *unitPrice;

@property (nonatomic, copy) NSString *standardName;

@property (nonatomic, strong) NSArray<HJGoodsIntroducePricelistModel *> *priceList;

@property (nonatomic, assign) NSInteger standardSize;

@end

@interface HJGoodsIntroducePricelistModel : HJBaseModel

@property (nonatomic, copy) NSString *formerPrice;

@property (nonatomic, strong) NSArray<HJParameterlistModel *> *parameterList;

@property (nonatomic, assign) NSInteger standardType;

@property (nonatomic, copy) NSString *currentPrice;

@property (nonatomic, assign) NSInteger priceId;

@property (nonatomic, copy) NSString *unitName;

@end

@interface HJParameterlistModel : HJBaseModel

@property (nonatomic, assign) NSInteger parameterId;

@property (nonatomic, assign) NSInteger parameterValue;

@property (nonatomic, copy) NSString *remark;

@end

