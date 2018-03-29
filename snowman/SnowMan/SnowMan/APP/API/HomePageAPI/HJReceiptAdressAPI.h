//
//  HJReceiptAdressAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJRecieptAddressModel;
@interface HJReceiptAdressAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJRecieptAddressModel *> *data;

+ (instancetype)receiptAdress_page:(NSNumber *)page rows:(NSNumber *)rows;

@end
@interface HJRecieptAddressModel : HJBaseModel

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *areaName;

@property (nonatomic, copy) NSNumber *receiptId;

@property (nonatomic, assign) NSInteger type;

@property (nonatomic, copy) NSString *address;

@end

