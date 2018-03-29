//
//  HJOrderListSectionHeaderView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJOrderListAPI.h"
#import "HJAfterSalesListAPI.h"

typedef NS_ENUM(NSUInteger, HJReturnType) {
    HJReturnTypeApplying = 0,
    HJReturnTypeCompleted,
    HJReturnTypeRefuse,
};


@interface HJOrderListSectionHeaderView : UIView

@property (nonatomic, assign) HJOrderState orderType;

@property (nonatomic, strong) HJOrderListModel *orderListModel;

@property (nonatomic, strong) HJAfterSaleListModel *afterSaleListModel;

@end
