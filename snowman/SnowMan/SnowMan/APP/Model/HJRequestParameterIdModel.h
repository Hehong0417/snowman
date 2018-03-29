//
//  HJRequestParameterIdModel.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/12.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseModel.h"
#import "HJSelectStandardValueModel.h"

@interface HJRequestParameterIdModel : HJBaseModel

@property (nonatomic, strong) NSString *parameterId;
@property (nonatomic, copy) NSString *count;

+ (NSString *)parameterListStringFromStandardValueModelArray:(NSArray <HJSelectStandardValueModel *>*)standardValueModelArray;

@end
