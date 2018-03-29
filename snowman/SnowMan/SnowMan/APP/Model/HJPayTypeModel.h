//
//  HJPayTypeModel.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/20.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseModel.h"

@interface HJPayTypeModel : HJBaseModel

+ (NSString *)payTypeStringBaseOnThePayChannelType:(HJPayChannelType)payChannelType;

@end
