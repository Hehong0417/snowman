//
//  HJRequestParameterIdModel.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/12.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJRequestParameterIdModel.h"

@implementation HJRequestParameterIdModel

+ (NSString *)parameterListStringFromStandardValueModelArray:(NSArray<HJSelectStandardValueModel *> *)standardValueModelArray {
    
    NSMutableArray *requestParameterList = [NSMutableArray array];
    [standardValueModelArray enumerateObjectsUsingBlock:^(HJSelectStandardValueModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HJRequestParameterIdModel *parameterModel = [HJRequestParameterIdModel new];
        parameterModel.parameterId = obj.parameterId;
        parameterModel.count = obj.goodsCount;
        
        [requestParameterList addObject:parameterModel.mj_keyValues];
    }];

    return requestParameterList.jsonStringEncoded;
}


@end
