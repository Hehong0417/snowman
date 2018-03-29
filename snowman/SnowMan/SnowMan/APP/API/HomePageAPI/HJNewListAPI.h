//
//  HJNewListAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJHomePageGoodsListModel,HJStandardlistModel,HJPricelistModel;
@interface HJNewListAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJHomePageGoodsListModel *> *data;

+ (instancetype)newList_page:(NSNumber *)page rows:(NSNumber *)rows;

@end

