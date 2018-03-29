//
//  HJStandardValueAlertView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "LHAlertView.h"
#import "HJGoodsIntroduceAPI.h"

@interface HJStandardValueAlertView : LHAlertView

@property (nonatomic, strong) HJGoodsIntroduceModel *goodsIntroduceModel;
@property (nonatomic, copy) idBlock sureHandler;
@property (nonatomic, copy) NSString *goodsPrice;
@property (nonatomic, copy) NSString *formerGoodsPrice;

@end
