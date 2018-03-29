//
//  HJRequestParameterListModel.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseModel.h"
#import "HJShopCartBrandAPI.h"

@interface HJRequestParameterListModel : HJBaseModel
@property (nonatomic, assign) NSInteger goodsId;
@property (nonatomic, strong) NSMutableArray *parameterList;

+ (NSString *)parameterGoodsListStringFromGoodsListModelArray:(NSArray <HJGoodsListModell *>*)GoodsListModelArray;

+ (NSString *)parameterGoodsListStringFromBoxListModelArray:(NSArray <HJBoxListModel *>*)boxListModelArray;
@end

@interface HJParameterListModel : HJBaseModel
@property (nonatomic, assign) NSInteger parameterId;
@property (nonatomic, assign) NSInteger count;
@end
