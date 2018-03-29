//
//  HJJoinShopCartAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJJoinShopCartAPI : HJBaseAPI

+ (instancetype)joinShopCart_goodsId:(NSString *)goodsId parameterList:(NSString *)parameterList;

@end
