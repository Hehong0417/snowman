//
//  HJOrderListSectionFooterView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderListSectionFooterView.h"
#import "HJAfterSalesListAPI.h"
#import "HJJudgeSepcialGoodsModel.h"

@interface HJOrderListSectionFooterView ()

@property (weak, nonatomic) IBOutlet UILabel *totalPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalGoodsCountLabel;

@end

@implementation HJOrderListSectionFooterView

- (void)awakeFromNib
{
    self.sectionHanlerButton.layer.cornerRadius = kSmallCornerRadius;
}

- (void)setOrderType:(HJOrderState)orderType {
    
    _orderType = orderType;
    
    self.sectionHanlerButton.hidden = NO;
    self.sectionHanlerButton.backgroundColor = RGB(246, 160, 0);
    
    switch (orderType) {
        case HJOrderStateWaitPaid: {
            {
                
                [self.sectionHanlerButton setTitle:@"立即支付" forState:UIControlStateNormal];
            }
            break;
        }
        case HJOrderStateSureRecieveGoods: {
            {
                [self.sectionHanlerButton setTitle:@"确认收货" forState:UIControlStateNormal];

            }
            break;
        }
        case HJOrderStateFinished: {
            {
                self.sectionHanlerButton.hidden = YES;
//                self.sectionHanlerButton.backgroundColor = kLineDeepColor;
//                [self.sectionHanlerButton setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            break;
        }
        case HJOrderStateWaitRecieveGoods: {
            {
                
                self.sectionHanlerButton.hidden = YES;
            }
            break;
        }
        case HJOrderStateDeleteAfter: {
            {
                self.sectionHanlerButton.backgroundColor = kLineDeepColor;
                [self.sectionHanlerButton setTitle:@"删除订单" forState:UIControlStateNormal];
            }
            break;
        }
    }
    
}

- (void)setOrderListModel:(HJOrderListModel *)orderListModel {
    
    _orderListModel = orderListModel;
    
    self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f",KIntToFloat([orderListModel.actualFee floatValue])];
    self.totalGoodsCountLabel.text = [NSString stringWithFormat:@"共计%ld件商品",orderListModel.amount];
    
    self.orderType = orderListModel.state;
    
    //特殊商品线下结算为准
    
    if (orderListModel.isSpecial) {
        self.totalPriceLabel.text = @"以线下结算为准";
    }
    
//    if (orderListModel.payType ==  HJPayChannelTypeOffLine) {
//        
//        self.totalPriceLabel.text = @"以线下结算为准";
//    }
}

- (void)setAfterSaleListModel:(HJAfterSaleListModel *)afterSaleListModel
{
    _afterSaleListModel = afterSaleListModel;
    
    
    if (afterSaleListModel.isSpecial) {
        self.totalPriceLabel.text = @"以线下结算为准";
        
    } else {
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", afterSaleListModel.fee ? KIntToFloat([afterSaleListModel.fee floatValue]):0];
    };
    
    self.totalGoodsCountLabel.text = [NSString stringWithFormat:@"共计1件商品"];
    
    self.orderType = HJOrderStateFinished;
}

@end
