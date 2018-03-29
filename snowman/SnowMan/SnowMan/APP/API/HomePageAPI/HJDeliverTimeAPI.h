//
//  HJDeliverTimeAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJDeliverTimeModel;
@interface HJDeliverTimeAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJDeliverTimeModel *> *data;


+ (instancetype)deliverTime;


@end
@interface HJDeliverTimeModel : NSObject

@property (nonatomic, assign) NSInteger sendId;

@property (nonatomic, copy) NSString *sendName;

@end

