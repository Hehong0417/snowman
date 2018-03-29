//
//  HJOrderListCell.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJOrderListAPI.h"

@class HJAfterSalesInfoModel;
@class HJAfterSaleListModel;
@class HJOrderInfoGoodslistModel;
@interface HJOrderListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *actionHandlerButton;

@property (nonatomic, assign) BOOL haveHandler;

@property (nonatomic, assign) BOOL haveGoodsCount;

@property (nonatomic, strong) HJOrderGoodslistModel *orderGoodsListModel;

@property (nonatomic, strong) HJOrderInfoGoodslistModel *orderInfoGoodslistModel;

@property (nonatomic, strong) HJAfterSaleListModel *afterSaleListModel;

@property (nonatomic, strong) HJAfterSalesInfoModel *afterSalesInfoModel;

@end
