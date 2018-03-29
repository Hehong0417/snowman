//
//  HJEditAdressAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJEditAdressAPI.h"

@implementation HJEditAdressAPI

+ (instancetype)editAdress_receiptId:(NSNumber *)receiptId userName:(NSString *)userName phone:(NSString *)phone areaId:(NSNumber *)areaId address:(NSString *)address {
    HJEditAdressAPI * api = [self new];
    if (receiptId) {
        [api.parameters setObject:receiptId forKey:@"receiptId"];
    }
    if (areaId) {
        [api.parameters setObject:areaId forKey:@"areaId"];
    }
    [api.parameters setObject:userName forKey:@"userName"];
    [api.parameters setObject:phone forKey:@"phone"];
    [api.parameters setObject:address forKey:@"address"];
    api.subUrl = API_EDIT_ADRESS;
    return api;
}
@end
