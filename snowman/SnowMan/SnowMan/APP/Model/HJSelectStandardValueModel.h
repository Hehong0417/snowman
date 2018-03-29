//
//  HJSelectStandardValueModel.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/12.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseModel.h"

@interface HJSelectStandardValueModel : HJBaseModel

@property (nonatomic, strong) NSString *standardName;
@property (nonatomic, assign) HJStandardValueType standardType;
@property (nonatomic, strong) NSString *parameterValue;
@property (nonatomic, strong) NSString *goodsCount;
@property (nonatomic, strong) NSString *currentPrice;
@property (nonatomic, strong) NSString *parameterId;
@property (nonatomic, strong) NSString *unitGoodsCount;
@property (nonatomic, strong) NSString *unitGoodsPrice;
@property (nonatomic, strong) NSString *unitGoodsName;

@end
