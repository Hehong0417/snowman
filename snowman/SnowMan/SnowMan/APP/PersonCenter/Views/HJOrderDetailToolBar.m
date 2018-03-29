//
//  HJOrderDetailToolBar.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/20.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderDetailToolBar.h"
#import "HJOrderInfoAPI.h"
#import "HJAfterSalesInfoAPI.h"
#import "HJJudgeSepcialGoodsModel.h"

NSString * const kCancelOrderString = @"取消订单";
NSString * const kPayRightNowString = @"立即支付";
NSString * const kSureRecieveGoods = @"确认收货";
NSString * const kDeleteOrderString = @"删除订单";
NSString * const kCommentString = @"评价";

@interface HJOrderDetailToolBar ()

@property (weak, nonatomic) IBOutlet UIButton *firstHandlerButton;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *cancelBtnWidth;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *payBtnWidth;


@property (weak, nonatomic) IBOutlet UIButton *secondHandlerButton;

@end

@implementation HJOrderDetailToolBar

- (void)awakeFromNib
{
    self.firstHandlerButton.layer.cornerRadius = kSmallCornerRadius;
    self.secondHandlerButton.layer.cornerRadius = kSmallCornerRadius;
}


- (IBAction)tapActionButton:(id)sender {
    
    !self.actionButtonHandler?:self.actionButtonHandler(sender);
}


- (void)setOrderState:(HJOrderState)orderState {
    
    _orderState = orderState;
    
    switch (orderState) {
        case HJOrderStateWaitPaid: {
            {
                [self.firstHandlerButton setTitle:kCancelOrderString forState:UIControlStateNormal];
                [self.secondHandlerButton setTitle:kPayRightNowString forState:UIControlStateNormal];
                
            }
            break;
        }
        case HJOrderStateWaitRecieveGoods: {
            {
                self.firstHandlerButton.hidden = YES;
                self.secondHandlerButton.hidden = YES;
                
            }
            break;
        }
        case HJOrderStateSureRecieveGoods: {
            {
                self.firstHandlerButton.hidden = YES;
                [self.secondHandlerButton setTitle:kSureRecieveGoods forState:UIControlStateNormal];
                
            }
            break;
        }
        case HJOrderStateFinished: {
            {
                
                [self.firstHandlerButton setTitle:kDeleteOrderString forState:UIControlStateNormal];
                [self.secondHandlerButton setTitle:kCommentString forState:UIControlStateNormal];

            }
            break;
        }
        case HJOrderStateReturnOfGoods: {
            {
                
                self.firstHandlerButton.hidden = YES;
                self.secondHandlerButton.backgroundColor = RGB(193, 193, 193);
                [self.secondHandlerButton setTitle:kCommentString forState:UIControlStateNormal];
            }
            break;
        }
        case HJOrderStateDeleteAfter: {
            {
                
                self.firstHandlerButton.hidden = YES;
                self.secondHandlerButton.backgroundColor = RGB(193, 193, 193);
                [self.secondHandlerButton setTitle:kDeleteOrderString forState:UIControlStateNormal];
            }
            break;
        }
    }
    
}

- (void)setOrderInfoModel:(HJOrderInfoModel *)orderInfoModel
{
    _orderInfoModel = orderInfoModel;
    
    
    if (orderInfoModel.isSpecial) {
        self.totalPriceLabel.text = @"以线下结算为准";
        self.cancelBtnWidth.constant = WidthScaleSize(60);
        self.payBtnWidth.constant = WidthScaleSize(60);
        
        if (orderInfoModel.state == HJOrderStateSureRecieveGoods) {
            
            self.payBtnWidth.constant = WidthScaleSize(80);

        }
        
    } else {
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", self.orderInfoModel.actualFee? KIntToFloat([orderInfoModel.actualFee floatValue]):0];
        self.cancelBtnWidth.constant = WidthScaleSize(80);
        self.payBtnWidth.constant = WidthScaleSize(80);
    }
}

- (void)setAfterSalesInfoModel:(HJAfterSalesInfoModel *)afterSalesInfoModel
{
    _afterSalesInfoModel = afterSalesInfoModel;
    self.payBtnWidth.constant = WidthScaleSize(80);
    
    if (afterSalesInfoModel.isSpecial) {
        self.totalPriceLabel.text = @"以线下结算为准";
        
    } else {
        self.totalPriceLabel.text = [NSString stringWithFormat:@"￥%.2f", afterSalesInfoModel.fee ? KIntToFloat([afterSalesInfoModel.fee floatValue]):0];
    }
}

@end
