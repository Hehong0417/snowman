//
//  HJOrderListSectionFooterView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJOrderListAPI.h"

@class HJAfterSaleListModel;
@interface HJOrderListSectionFooterView : UIView

@property (nonatomic, assign) HJOrderState orderType;
@property (weak, nonatomic) IBOutlet UIButton *sectionHanlerButton;
@property (nonatomic, strong) HJOrderListModel *orderListModel;
@property (nonatomic, strong) HJAfterSaleListModel *afterSaleListModel;

@end
