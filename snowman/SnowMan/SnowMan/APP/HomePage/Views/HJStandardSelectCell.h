//
//  HJStandardSelectCell.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/11.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGoodsIntroduceAPI.h"
#import "HJStandardValueAlertView.h"

@interface HJStandardSelectCell : UITableViewCell

@property (nonatomic, strong) HJGoodsIntroducePricelistModel *priceListModel;
@property (nonatomic, copy) NSString *unitName;
@property (nonatomic, copy) NSString *unitPrice;
@property (nonatomic, strong)  HJStandardValueAlertView *alertView;
@property (nonatomic, strong) NSString *selectedParameterValue;
@property (nonatomic, strong) NSString *selectedParameterId;
@property (nonatomic, strong) NSString *selectedGoodsCount;
@property (nonatomic, strong) NSString *selectedUnitGoodsCount;
@property (weak, nonatomic) IBOutlet UILabel *goodsCountLabel;
@property (nonatomic, assign) HJStandardValueType standardValueType;

@end
