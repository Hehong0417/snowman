//
//  HJStandardValueAlertHeaderView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJStandardValueAlertHeaderView : UIView

@property (weak, nonatomic) IBOutlet UILabel *goodsFormerPriceLabel;
@property (weak, nonatomic) IBOutlet UIImageView *goodsIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (nonatomic, strong) voidBlock closeViewBlock;

@end
