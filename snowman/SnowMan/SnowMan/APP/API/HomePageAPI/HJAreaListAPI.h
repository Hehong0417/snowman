//
//  HJAreaListAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJAreaListModel;
@interface HJAreaListAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJAreaListModel *> *data;


+ (instancetype)areaList_areaId:(NSNumber *)areaId;
@end
@interface HJAreaListModel : HJBaseModel

@property (nonatomic, copy) NSNumber *areaId;

@property (nonatomic, copy) NSString *areaName;

@end

