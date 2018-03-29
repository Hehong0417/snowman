//
//  HJNewListAPI.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJNewListAPI.h"
#import "HJWeeklySaleListAPI.h"
#import "HJGetGoodsListAPI.h"

@implementation HJNewListAPI

+ (instancetype)newList_page:(NSNumber *)page rows:(NSNumber *)rows {
    
    HJNewListAPI *api = [self new];
    
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    
    api.subUrl = API_NEW_LIST;
    
    return api;
}


+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJGoodsListModel class]};
}
@end



