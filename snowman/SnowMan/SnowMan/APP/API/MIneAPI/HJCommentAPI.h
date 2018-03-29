//
//  HJCommentAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJCommentAPI : HJBaseAPI

+ (instancetype)commentId:(NSNumber *)Id content:(NSString *)content ico:(NSArray *)ico;

@end
