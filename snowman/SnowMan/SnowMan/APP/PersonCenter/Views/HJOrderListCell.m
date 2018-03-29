//
//  HJOrderListCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderListCell.h"
#import "HJOrderInfoAPI.h"
#import "HJAfterSalesListAPI.h"
#import "HJAfterSalesInfoAPI.h"

@interface HJOrderListCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *numOfGoodsRightCons;
@property (weak, nonatomic) IBOutlet UIImageView *goodsIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceEveryBoxLabel;
@property (weak, nonatomic) IBOutlet UILabel *priceEveryBagLabel;
@property (weak, nonatomic) IBOutlet UILabel *boxCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bagCountLabel;

@end

@implementation HJOrderListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self setHaveHandler:NO];
    [self setHaveGoodsCount:YES];
    [self setOrderGoodsListModel:nil];
    
    self.actionHandlerButton.layer.cornerRadius = kSmallCornerRadius;
}

- (void)setHaveHandler:(BOOL)haveHandler {
    
    _haveHandler = haveHandler;
    
    self.actionHandlerButton.hidden = !haveHandler;
    self.numOfGoodsRightCons.constant = haveHandler?100:8;
}

- (void)setHaveGoodsCount:(BOOL)haveGoodsCount {
    
    _haveGoodsCount = haveGoodsCount;
    
    self.boxCountLabel.hidden = !haveGoodsCount;
    self.bagCountLabel.hidden = !haveGoodsCount;
}

- (void)setOrderGoodsListModel:(HJOrderGoodslistModel *)orderGoodsListModel {
    
    _orderGoodsListModel = orderGoodsListModel;
    
    [self.goodsIconImageView lh_setImageWithImagePartUrlString:orderGoodsListModel.goodsIco placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
    self.goodsNameLabel.text = orderGoodsListModel.goodsName;
    
    if (orderGoodsListModel.isAfterSales) {
        self.actionHandlerButton.userInteractionEnabled = NO;
        [self.actionHandlerButton setTitle:@"已申请售后" forState:UIControlStateNormal];
        [self.actionHandlerButton setBackgroundColor:RGB(193, 193, 193)];
    } else {
        [self.actionHandlerButton setTitle:@"申请售后" forState:UIControlStateNormal];
        self.actionHandlerButton.userInteractionEnabled = YES;
        [self.actionHandlerButton setBackgroundColor:RGB(249, 158, 27)];
    }
    
    //显示几个规格值
    if (orderGoodsListModel.priceList.count == 0) {
        
        self.priceEveryBoxLabel.hidden = YES;
        self.boxCountLabel.hidden = YES;
        self.priceEveryBagLabel.hidden = YES;
        self.bagCountLabel.hidden = YES;
    }
    if (orderGoodsListModel.priceList.count == 1) {
        
        self.priceEveryBoxLabel.hidden = NO;
        self.boxCountLabel.hidden = NO;
        self.priceEveryBagLabel.hidden = YES;
        self.bagCountLabel.hidden = YES;

    }
    if (orderGoodsListModel.priceList.count == 2) {
        
        self.priceEveryBoxLabel.hidden = NO;
        self.boxCountLabel.hidden = NO;
        self.priceEveryBagLabel.hidden = NO;
        self.bagCountLabel.hidden = NO;
    }
    
    [orderGoodsListModel.priceList enumerateObjectsUsingBlock:^(HJOrderPricelistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //第一个规格值
        if (idx == 0) {
            
            [self configureLabel:self.priceEveryBoxLabel pricelistModel:obj];
            //
            self.boxCountLabel.text = [NSString stringWithFormat:@"x%ld",obj.count];
        }
        
        //第二个规格值
        if (idx == 1) {
            
            [self configureLabel:self.priceEveryBagLabel pricelistModel:obj];
            //
            self.bagCountLabel.text = [NSString stringWithFormat:@"x%ld",obj.count];
        }

    }];
    
}

- (void)configureLabel:(UILabel *)label pricelistModel:(HJOrderPricelistModel *)pricelistModel {
    
    //
    if (pricelistModel.standardType == HJStandardValueTypeBox) {
        
        label.text = [NSString stringWithFormat:@"¥%@/箱",pricelistModel.currentPrice];
        
    }
    //
    if (pricelistModel.standardType == HJStandardValueTypeBag) {
        
        label.text = [NSString stringWithFormat:@"¥%@/袋",pricelistModel.currentPrice];
    }
    
    //特殊商品
    if (pricelistModel.unitPrice.length>0) {
        
        label.text = [NSString stringWithFormat:@"¥%@/%@",pricelistModel.currentPrice,pricelistModel.unitPrice];
        
//        label.text = [label.text stringByAppendingString:@"（此类特殊商品以线下结算为准）"];

    }
    
}


- (void)setOrderInfoGoodslistModel:(HJOrderInfoGoodslistModel *)orderInfoGoodslistModel
{
    _orderInfoGoodslistModel = orderInfoGoodslistModel;
    
    [self.goodsIconImageView lh_setImageWithImagePartUrlString:orderInfoGoodslistModel.goodsIco placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
    self.goodsNameLabel.text = orderInfoGoodslistModel.goodsName;
    
    if (orderInfoGoodslistModel.isAfterSales) {
        self.actionHandlerButton.userInteractionEnabled = NO;
        [self.actionHandlerButton setTitle:@"已申请售后" forState:UIControlStateNormal];
        [self.actionHandlerButton setBackgroundColor:RGB(193, 193, 193)];
    } else {
        [self.actionHandlerButton setTitle:@"申请售后" forState:UIControlStateNormal];
        self.actionHandlerButton.userInteractionEnabled = YES;
        [self.actionHandlerButton setBackgroundColor:RGB(249, 158, 27)];
    }

    //显示几个规格值
    if (orderInfoGoodslistModel.priceList.count == 0) {
        
        self.priceEveryBoxLabel.hidden = YES;
        self.boxCountLabel.hidden = YES;
        self.priceEveryBagLabel.hidden = YES;
        self.bagCountLabel.hidden = YES;
    }
    if (orderInfoGoodslistModel.priceList.count == 1) {
        
        self.priceEveryBoxLabel.hidden = NO;
        self.boxCountLabel.hidden = NO;
        self.priceEveryBagLabel.hidden = YES;
        self.bagCountLabel.hidden = YES;
        
    }
    if (orderInfoGoodslistModel.priceList.count == 2) {
        
        self.priceEveryBoxLabel.hidden = NO;
        self.boxCountLabel.hidden = NO;
        self.priceEveryBagLabel.hidden = NO;
        self.bagCountLabel.hidden = NO;
    }
    
    [orderInfoGoodslistModel.priceList enumerateObjectsUsingBlock:^(HJOrderInfoPricelistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //第一个规格值
        if (idx == 0) {
            
            [self configureLabel:self.priceEveryBoxLabel orderInfoPricelistModel:obj];
            //
            self.boxCountLabel.text = [NSString stringWithFormat:@"x%ld",obj.count];
        }
        
        //第二个规格值
        if (idx == 1) {
            
            [self configureLabel:self.priceEveryBagLabel orderInfoPricelistModel:obj];
            //
            self.bagCountLabel.text = [NSString stringWithFormat:@"x%ld",obj.count];
        }
        
    }];

}

- (void)configureLabel:(UILabel *)label orderInfoPricelistModel:(HJOrderInfoPricelistModel *)orderInfoPricelistModel {
    
    //
    if (orderInfoPricelistModel.standardType == HJStandardValueTypeBox) {
        
        label.text = [NSString stringWithFormat:@"¥%@/箱",orderInfoPricelistModel.currentPrice];
    }
    //
    if (orderInfoPricelistModel.standardType == HJStandardValueTypeBag) {
        
        label.text = [NSString stringWithFormat:@"¥%@/袋",orderInfoPricelistModel.currentPrice];
    }
    
    //特殊商品
    if (orderInfoPricelistModel.unitPrice) {
        
        label.text = [NSString stringWithFormat:@"¥%@/%@",orderInfoPricelistModel.currentPrice, orderInfoPricelistModel.unitPrice];
}
}

- (void)setAfterSaleListModel:(HJAfterSaleListModel *)afterSaleListModel
{
    _afterSaleListModel = afterSaleListModel;
    
    [self.goodsIconImageView lh_setImageWithImagePartUrlString:afterSaleListModel.goodsIco placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
    self.goodsNameLabel.text = afterSaleListModel.goodsName;
    
    //显示几个规格值
    if (afterSaleListModel.priceList.count == 0) {
        
        self.priceEveryBoxLabel.hidden = YES;
        self.boxCountLabel.hidden = YES;
        self.priceEveryBagLabel.hidden = YES;
        self.bagCountLabel.hidden = YES;
    }
    if (afterSaleListModel.priceList.count == 1) {
        
        self.priceEveryBoxLabel.hidden = NO;
        self.boxCountLabel.hidden = NO;
        self.priceEveryBagLabel.hidden = YES;
        self.bagCountLabel.hidden = YES;
        
    }
    if (afterSaleListModel.priceList.count == 2) {
        
        self.priceEveryBoxLabel.hidden = NO;
        self.boxCountLabel.hidden = NO;
        self.priceEveryBagLabel.hidden = NO;
        self.bagCountLabel.hidden = NO;
    }
    
    [afterSaleListModel.priceList enumerateObjectsUsingBlock:^(HJAfterSalesPricelistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //第一个规格值
        if (idx == 0) {
            
            [self configureLabel:self.priceEveryBoxLabel afterSalesPricelistModel:obj];
            //
            self.boxCountLabel.text = [NSString stringWithFormat:@"x%ld",obj.count];
        }
        
        //第二个规格值
        if (idx == 1) {
            
            [self configureLabel:self.priceEveryBagLabel afterSalesPricelistModel:obj];
            //
            self.bagCountLabel.text = [NSString stringWithFormat:@"x%ld",obj.count];
        }
        
    }];
}

- (void)configureLabel:(UILabel *)label afterSalesPricelistModel:(HJAfterSalesPricelistModel *)afterSalesPricelistModel {
    
    //
    if (afterSalesPricelistModel.standardType == HJStandardValueTypeBox) {
        
        label.text = [NSString stringWithFormat:@"¥%@/箱",afterSalesPricelistModel.currentPrice];
        
    }
    //
    if (afterSalesPricelistModel.standardType == HJStandardValueTypeBag) {
        
        label.text = [NSString stringWithFormat:@"¥%@/袋",afterSalesPricelistModel.currentPrice];
    }
    
    //特殊商品
    if (afterSalesPricelistModel.unitName.length) {
        
        label.text = [NSString stringWithFormat:@"¥%@/%@",afterSalesPricelistModel.currentPrice, afterSalesPricelistModel.unitName];
    }
}


- (void)setAfterSalesInfoModel:(HJAfterSalesInfoModel *)afterSalesInfoModel
{
    _afterSalesInfoModel = afterSalesInfoModel;
    
    [self.goodsIconImageView lh_setImageWithImagePartUrlString:afterSalesInfoModel.goodsIco placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
    self.goodsNameLabel.text = afterSalesInfoModel.goodsName;
    
    //显示几个规格值
    if (afterSalesInfoModel.priceList.count == 0) {
        
        self.priceEveryBoxLabel.hidden = YES;
        self.boxCountLabel.hidden = YES;
        self.priceEveryBagLabel.hidden = YES;
        self.bagCountLabel.hidden = YES;
    }
    if (afterSalesInfoModel.priceList.count == 1) {
        
        self.priceEveryBoxLabel.hidden = NO;
        self.boxCountLabel.hidden = NO;
        self.priceEveryBagLabel.hidden = YES;
        self.bagCountLabel.hidden = YES;
        
    }
    if (afterSalesInfoModel.priceList.count == 2) {
        
        self.priceEveryBoxLabel.hidden = NO;
        self.boxCountLabel.hidden = NO;
        self.priceEveryBagLabel.hidden = NO;
        self.bagCountLabel.hidden = NO;
    }
    
    [afterSalesInfoModel.priceList enumerateObjectsUsingBlock:^(HJAfterSalesInfoPriceListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        //第一个规格值
        if (idx == 0) {
            
            [self configureLabel:self.priceEveryBoxLabel afterSalesInfoPriceListModel:obj];
            //
            self.boxCountLabel.text = [NSString stringWithFormat:@"x%ld",obj.count];
        }
        
        //第二个规格值
        if (idx == 1) {
            
            [self configureLabel:self.priceEveryBagLabel afterSalesInfoPriceListModel:obj];
            //
            self.bagCountLabel.text = [NSString stringWithFormat:@"x%ld",obj.count];
        }
        
    }];

}


- (void)configureLabel:(UILabel *)label afterSalesInfoPriceListModel:(HJAfterSalesInfoPriceListModel *)afterSalesInfoPriceListModel {
    
    //
    if (afterSalesInfoPriceListModel.standardType == HJStandardValueTypeBox) {
        
        label.text = [NSString stringWithFormat:@"¥%@/箱",afterSalesInfoPriceListModel.currentPrice];
        
    }
    //
    if (afterSalesInfoPriceListModel.standardType == HJStandardValueTypeBag) {
        
        label.text = [NSString stringWithFormat:@"¥%@/袋",afterSalesInfoPriceListModel.currentPrice];
    }
    
    //特殊商品
    if (self.afterSalesInfoModel.isSpecial) {
        
        label.text = [NSString stringWithFormat:@"¥%@/斤",afterSalesInfoPriceListModel.currentPrice];
    }
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
