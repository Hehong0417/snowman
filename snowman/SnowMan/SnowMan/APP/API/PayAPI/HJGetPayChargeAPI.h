//
//  HJGetPayChargeAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJGetPayChargeAPI : HJBaseAPI

@property (nonatomic, strong) NSDictionary *data;

+ (instancetype)getPayCharge_orderNo:(NSNumber *)orderNo;
@end
