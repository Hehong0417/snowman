//
//  HJApplicationSaleAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJApplicationSaleAPI : HJBaseAPI

+ (instancetype)applicationSale_orderId:(NSNumber *)orderId ID:(NSNumber *)ID type:(NSNumber *)type phone:(NSString *)phone cause:(NSString *)cause;

@end
