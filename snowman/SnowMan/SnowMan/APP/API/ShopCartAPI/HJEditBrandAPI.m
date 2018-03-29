//
//  HJEditBrandAPI.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJEditBrandAPI.h"

@implementation HJEditBrandAPI
+ (instancetype)editBrandWithGoodsList:(NSString *)goodsList boxList:(NSString *)boxList
{
    HJEditBrandAPI *api = [[HJEditBrandAPI alloc] init];
    [api.parameters setObject:goodsList forKey:@"goodsList"];
    [api.parameters setObject:boxList forKey:@"boxList"];
    api.subUrl = API_EDIT_BRAND;
    return api;
}
@end
