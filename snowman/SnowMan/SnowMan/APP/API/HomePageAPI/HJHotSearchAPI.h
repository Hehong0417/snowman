//
//  HJHotSearchAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJHotSearchModel;
@interface HJHotSearchAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJHotSearchModel *> *data;

+ (instancetype)hotSearch;

@end
@interface HJHotSearchModel : NSObject

@property (nonatomic, assign) NSInteger goodsId;

@property (nonatomic, copy) NSString *goodsName;

@end

