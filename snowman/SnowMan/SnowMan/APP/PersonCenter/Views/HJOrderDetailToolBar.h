//
//  HJOrderDetailToolBar.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/20.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSString *const kCancelOrderString;
extern NSString *const kPayRightNowString;
extern NSString *const kSureRecieveGoods;
extern NSString *const kCommentString;
extern NSString *const kDeleteOrderString;

@class HJOrderInfoModel;
@class HJAfterSalesInfoModel;
@interface HJOrderDetailToolBar : UIView

@property (nonatomic, assign) HJOrderState orderState;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (nonatomic, copy) idBlock actionButtonHandler;

@property (nonatomic, strong) HJOrderInfoModel *orderInfoModel;
@property (nonatomic, strong) HJAfterSalesInfoModel *afterSalesInfoModel;

@end
