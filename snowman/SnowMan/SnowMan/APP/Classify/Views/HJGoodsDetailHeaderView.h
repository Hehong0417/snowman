//
//  HJGoodsDetailHeaderView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGoodsIntroduceAPI.h"

@interface HJGoodsDetailHeaderView : UIView

@property (weak, nonatomic) IBOutlet UIButton *isBoxButton;
@property (weak, nonatomic) IBOutlet UILabel *joinBoxLabel;
@property (nonatomic, strong) HJGoodsIntroduceModel *goodsIntroduceModel;
@property (nonatomic, strong) NSString *goodsPrice;
@property (nonatomic, strong) NSString *formerGoodsPrice;

@end
