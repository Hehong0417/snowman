//
//  HJUserIcoAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJUserIcoAPI.h"

@implementation HJUserIcoAPI

+ (instancetype)userIco_ico:(NSData *)ico {
    HJUserIcoAPI * api = [self new];
    
    HJNetworkClientFile *file = [HJNetworkClientFile imageFileWithFileData:ico name:@"ico"];
    api.uploadFile = @[file];
    
    api.subUrl = API_USERICO;
    
    return api;
}
@end
