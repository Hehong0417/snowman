//
//  HJDeleteAdressAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJDeleteAdressAPI.h"

@implementation HJDeleteAdressAPI

+ (instancetype)deleteAdress_receiptId:(NSNumber *)receiptId {
    HJDeleteAdressAPI * api = [self new];
    [api.parameters setObject:receiptId forKey:@"receiptId"];
    api.subUrl = API_DELETE_ADDRESS;
    return api;
}
@end
