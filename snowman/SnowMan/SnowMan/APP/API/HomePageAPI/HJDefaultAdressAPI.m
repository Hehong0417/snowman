//
//  HJDefaultAdressAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJDefaultAdressAPI.h"

@implementation HJDefaultAdressAPI

+ (instancetype)defaultAdress_receiptId:(NSNumber *)receiptId {
    HJDefaultAdressAPI * api = [self new];
    [api.parameters setObject:receiptId forKey:@"receiptId"];
    api.subUrl = API_DEFAULT_ADDRESS;
    return api;
    
}
@end
