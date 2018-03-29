//
//  HJReceiptAdressAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJReceiptAdressAPI.h"

@implementation HJReceiptAdressAPI
+ (instancetype)receiptAdress_page:(NSNumber *)page rows:(NSNumber *)rows {
    HJReceiptAdressAPI * api = [self new];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_RECEIPT_ADDRESS;
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJRecieptAddressModel class]};
}
@end
@implementation HJRecieptAddressModel

@end


