//
//  HJWishAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJWishAPI : HJBaseAPI

+ (instancetype)wish_userPhone:(NSString *)userPhone goodsName:(NSString *)goodsName brandName:(NSString *)brandName phone:(NSString *)phone content:(NSString *)content ico:(NSArray *)ico;

@end
