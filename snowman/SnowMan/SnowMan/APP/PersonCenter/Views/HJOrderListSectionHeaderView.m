//
//  HJOrderListSectionHeaderView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderListSectionHeaderView.h"

@interface HJOrderListSectionHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *orderTypeLabel;

@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;


@end

@implementation HJOrderListSectionHeaderView

- (void)setOrderListModel:(HJOrderListModel *)orderListModel {
    
    _orderListModel = orderListModel;
    
    self.orderNoLabel.text = [NSString stringWithFormat:@"订单编号：%@", orderListModel.orderNo];
    
    //***待收货付款方式***
    if (self.orderType == HJOrderStateWaitRecieveGoods || self.orderType == HJOrderStateSureRecieveGoods) {
        
        //******
        if (orderListModel.payType == HJPayChannelTypeOffLine) {
            
            if (orderListModel.state == HJOrderStateWaitRecieveGoods) {
                self.orderTypeLabel.text = @"待发货(货到付款)";
                
            } else if (orderListModel.state == HJOrderStateSureRecieveGoods) {
                self.orderTypeLabel.text = @"待收货(货到付款)";
            }
        }
        else {
            
            if (orderListModel.state == HJOrderStateWaitRecieveGoods) {
                self.orderTypeLabel.text = @"待发货(线上支付)";
                
            } else if (orderListModel.state == HJOrderStateSureRecieveGoods) {
                self.orderTypeLabel.text = @"待收货(线上支付)";
            }
        }
        
    }
    
    //***已完成付款方式***
    if (self.orderType == HJOrderStateFinished) {
        
        //******
        if (orderListModel.payType == HJPayChannelTypeOffLine) {
            
            self.orderTypeLabel.text = @"已完成(货到付款)";
        }
        else {
            
            self.orderTypeLabel.text = @"已完成(线上支付)";
        }
    }
}

- (void)setAfterSaleListModel:(HJAfterSaleListModel *)afterSaleListModel {

    _afterSaleListModel = afterSaleListModel;
    self.orderNoLabel.text = [NSString stringWithFormat:@"售后编号：%@", afterSaleListModel.refundNo];
    self.orderTypeLabel.text = [NSString stringWithFormat:@"%@(%@)", [self getReturnState:afterSaleListModel.state ReturnType:afterSaleListModel.type],[self getpayTypeString:afterSaleListModel.payType]];
}

- getOrderStateString:(NSInteger)orderState
{
    switch (orderState) {
        case HJOrderStateWaitPaid: {
            {
                return @"待付款";
            }
            break;
        }
        case HJOrderStateWaitRecieveGoods: {
            {
                return @"待收货";
            }
            break;
        }
        case HJOrderStateFinished: {
            {
                return @"已完成";
            }
            break;
        }
        case HJOrderStateReturnOfGoods: {
            {
                return @"已退货";
            }
            break;
        }
    }
    return nil;
}

- (NSString *)getReturnState:(NSInteger)returnState ReturnType:(NSInteger)returnType
{
    switch (returnState) {
        case HJReturnTypeApplying: {
            return @"申请中";
        }
            break;
        case HJReturnTypeCompleted: {
            if (returnType == 1) {
                return @"已换货";
                
            } else if (returnType == 2) {
                return @"已退货";
            }
        }
            break;
            
        case HJReturnTypeRefuse: {
            return @"已拒绝";
        }
        default:
            break;
    }
    return nil;
}


- (NSString *)getpayTypeString:(NSInteger)payType
{
    switch (payType) {
        case HJPayChannelTypeAliPay: {
            return @"线上付款";
        }
            break;
        case HJPayChannelTypeWx: {
            return @"线上付款";
        }
            break;
            
        case HJPayChannelTypeOffLine: {
            return @"货到付款";
        }
        default:
            break;
    }
    return nil;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
