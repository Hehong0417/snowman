//
//  HJConfigureStandardSizeModel.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/13.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJConfigureStandardSizeModel.h"

@implementation HJConfigureStandardSizeModel

+ (NSString *)StandardStringConfigureStandardSize:(HJStandardValueType)standardSize {
    
    switch (standardSize) {
        case HJStandardValueTypeBox: {
            {
                
              return @"箱";
            }
            break;
        }
        case HJStandardValueTypeBag: {
            {
                
              return @"袋";
            }
            break;
        }
        case HJStandardValueTypeKG: {
            {
                
              return @"斤";
            }
            break;
        }
    }
    
}

@end
