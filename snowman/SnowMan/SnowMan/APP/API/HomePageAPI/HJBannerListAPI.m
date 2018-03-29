//
//  HJBannerListAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBannerListAPI.h"

@implementation HJBannerListAPI

+ (instancetype)bannerList {
    
    HJBannerListAPI *api = [self new];
    
    api.subUrl = API_BANNER_LIST;
    
    return api;
}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJBannerListModel class]};
}
@end
@implementation HJBannerListModel

@end


