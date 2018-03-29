//
//  HJSettlementAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJSettlementModel,HJSendlistModel;
@interface HJSettlementAPI : HJBaseAPI

@property (nonatomic, strong) HJSettlementModel *data;

+ (instancetype)settlement;

@end
@interface HJSettlementModel : NSObject

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *address;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, strong) NSArray<HJSendlistModel *> *sendList;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *receiptId;

@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, copy) NSString *score;

@property (nonatomic, assign) CGFloat scoreUseRatio;

@end

@interface HJSendlistModel : NSObject

@property (nonatomic, assign) NSInteger sendId;

@property (nonatomic, copy) NSString *sendName;

@end

