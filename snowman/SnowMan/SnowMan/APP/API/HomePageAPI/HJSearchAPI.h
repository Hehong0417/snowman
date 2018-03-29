//
//  HJSearchAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJGetGoodsListAPI.h"

@interface HJSearchAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJGoodsListModel *> *data;

+ (instancetype)search_goodsName:(NSString *)goodsName page:(NSNumber *)page rows:(NSNumber *)rows;

@end
