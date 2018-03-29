//
//  HJOrderDetailVC.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJViewController.h"

@interface HJOrderDetailVC : HJViewController

@property (nonatomic, assign) HJOrderState orderType;
@property (nonatomic, strong) NSNumber *orderId;

@end
