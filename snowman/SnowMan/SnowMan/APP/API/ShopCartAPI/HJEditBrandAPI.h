//
//  HJEditBrandAPI.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@interface HJEditBrandAPI : HJBaseAPI
+ (instancetype)editBrandWithGoodsList:(NSString *)goodsList boxList:(NSString *)boxList;
@end
