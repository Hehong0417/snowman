//
//  HJCommentAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJCommentAPI.h"

@implementation HJCommentAPI

+ (instancetype)commentId:(NSNumber *)Id content:(NSString *)content ico:(NSArray *)ico {
    HJCommentAPI * api = [self new];
    [api.parameters setObject:Id forKey:@"id"];
    [api.parameters setObject:content forKey:@"content"];
    
    NSMutableArray *files = [NSMutableArray array];
    
    [ico enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSData *icoData = obj;
        
        HJNetworkClientFile *file = [HJNetworkClientFile imageFileWithFileData:icoData name:@"ico"];
        [files addObject:file];
    }];
    
    api.uploadFile = files;
    
    api.subUrl = API_COMMENT;
    return api;

}
@end
