//
//  HJDeleteAfterOrderAPI.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/30.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJDeleteAfterOrderAPI : HJBaseAPI
+ (instancetype)deleteAfterOrderWithRefundId:(NSNumber *)refundId;
@end
