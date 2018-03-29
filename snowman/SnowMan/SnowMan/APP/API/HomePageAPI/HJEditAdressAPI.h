//
//  HJEditAdressAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJEditAdressAPI : HJBaseAPI

+ (instancetype)editAdress_receiptId:(NSNumber *)receiptId userName:(NSString *)userName phone:(NSString *)phone areaId:(NSNumber *)areaId address:(NSString *)address;
@end
