//
//  HJFirstClassifyAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJClassifyModel;
@interface HJFirstClassifyAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJClassifyModel *> *data;

+ (instancetype)firstClassify;

@end
@interface HJClassifyModel : NSObject

@property (nonatomic, copy) NSString *goodsTypeName;

@property (nonatomic, assign) NSInteger goodsTypeId;

@end

