//
//  HJDeleteIndentIdAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJDeleteIndentIdAPI : HJBaseAPI

+ (instancetype)deleteOrderWithOrderId:(NSNumber *)OrderId;
@end
