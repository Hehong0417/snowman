//
//  HJCartSubmitOrderAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/23.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"
#import "HJSubmitOrderAPI.h"

@interface HJCartSubmitOrderAPI : HJBaseAPI

//userId	int
//token	string
//sendId	int
//shopCartArray	string[]
//boxArray	string[]
//isUseScore	int
//payType	int
//orderType	int
//consignee	string
//receiptName	string
//consigneePhone	string

@property (nonatomic, strong) HJSubmitOrderModel *data;


+ (instancetype)cartSubmitOrder_receiptName:(NSString *)receiptName sendId:(NSNumber *)sendId shopCartArray:(NSString *)shopCartArray boxArray:(NSString *)boxArray isUseScore:(NSNumber *)isUseScore
                                payType:(NSNumber *)payType orderType:(NSNumber *)orderType consignee:(NSString *)consignee consigneePhone:(NSString *)consigneePhone
                                  isSpecial:(NSNumber *)isSpecial;
@end

