//
//  HJSecondClassifyAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJClassifyModel;
@interface HJSecondClassifyAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJClassifyModel *> *data;

+ (instancetype)sencondClassify_goodsTypeId:(NSNumber *)goodsTyped;
@end

