//
//  HJBrandAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJBrandModel;
@interface HJBrandAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJBrandModel *> *data;

+ (instancetype)brand_goodsTypeId:(NSNumber *)goodsTypeId type:(NSNumber *)type;

@end
@interface HJBrandModel : NSObject

@property (nonatomic, assign) NSInteger brandId;

@property (nonatomic, copy) NSString *brandName;

@end

