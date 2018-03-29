//
//  HJPayTypeModel.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/20.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJPayTypeModel.h"

@implementation HJPayTypeModel

+ (NSString *)payTypeStringBaseOnThePayChannelType:(HJPayChannelType)payChannelType {
    
    NSString *payTypeString = @"";
    
    switch (payChannelType) {
        case HJPayChannelTypeAliPay: {
            {
                
                payTypeString = @"支付宝支付";
            }
            break;
        }
        case HJPayChannelTypeWx: {
            {
                
                payTypeString = @"微信支付";
            }
            break;
        }
        case HJPayChannelTypeOffLine: {
            {
                
                payTypeString = @"货到付款";
            }
            break;
        }
    }
    
    return payTypeString;
}

@end
