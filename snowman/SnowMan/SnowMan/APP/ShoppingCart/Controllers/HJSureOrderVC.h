//
//  HJSureOrderVC.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"
#import "HJGoodsIntroduceAPI.h"
#import "HJSelectStandardValueModel.h"
#import "HJShopCartBrandAPI.h"

@interface HJSureOrderVC : HJViewController

@property (nonatomic, strong) HJGoodsIntroduceModel *goodsIntroduceModel;
@property (nonatomic, strong) NSArray <HJSelectStandardValueModel *>*selectedStandardModels;
@property (nonatomic, strong) NSString *goodsTotalPrice;
@property (nonatomic, strong) NSMutableArray *settleGoodsList;
@property (nonatomic, strong) NSArray <HJGoodsListModell *> *shopCartArray;
@property (nonatomic, strong) NSArray <HJBoxListModel *> *boxArray;


@end
