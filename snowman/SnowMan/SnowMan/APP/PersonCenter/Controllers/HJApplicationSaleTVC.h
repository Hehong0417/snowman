//
//  HJApplicationSaleTVC.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJTableViewController.h"

@class HJOrderInfoGoodslistModel;
@class HJOrderGoodslistModel;
@interface HJApplicationSaleTVC : HJTableViewController
@property (nonatomic, strong) HJOrderGoodslistModel *salegoodsListModel;
@property (nonatomic, strong) HJOrderInfoGoodslistModel *orderInfoGoodslistModel;
@property (nonatomic, copy) NSString *orderNo;
@property (nonatomic, assign) NSInteger orderId;
@end
