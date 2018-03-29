//
//  HJWishAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJWishAPI.h"

@implementation HJWishAPI

+ (instancetype)wish_userPhone:(NSString *)userPhone goodsName:(NSString *)goodsName brandName:(NSString *)brandName phone:(NSString *)phone content:(NSString *)content ico:(NSArray *)ico {
    HJWishAPI * api = [self new];
    [api.parameters setObject:userPhone forKey:@"userPhone"];
    [api.parameters setObject:goodsName forKey:@"goodsName"];
    [api.parameters setObject:brandName forKey:@"brandName"];
    [api.parameters setObject:phone forKey:@"phone"];
    [api.parameters setObject:content forKey:@"content"];
    api.subUrl = API_WISH;
    
    NSMutableArray *files = [NSMutableArray array];
    
    [ico enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSData *icoData = obj;
        
        HJNetworkClientFile *file = [HJNetworkClientFile imageFileWithFileData:icoData name:@"ico"];
        [files addObject:file];
    }];
    
    api.uploadFile = files;
    
    return api;
}
@end
