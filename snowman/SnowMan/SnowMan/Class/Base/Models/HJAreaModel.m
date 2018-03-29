//
//  HJAreaModel.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAreaModel.h"

@implementation HJAreaModel

@end
@implementation HJAearRootModel

+ (NSDictionary *)objectClassInArray{
    return @{@"province" : [HJProvinceModel class]};
}

@end


@implementation HJProvinceModel

//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    
//    return @{@"name":@"-name"};
//}

+ (NSDictionary *)objectClassInArray{
    return @{@"city" : [HJCityModel class]};
}

@end


@implementation HJCityModel

//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    
//    return @{@"name":@"-name"};
//}

+ (NSDictionary *)objectClassInArray{
    return @{@"district" : [HJDistrictModel class]};
}

@end


@implementation HJDistrictModel

//+ (NSDictionary *)mj_replacedKeyFromPropertyName {
//    
//    return @{@"name":@"-name",
//             @"zipcode":@"-zipcode"};
//}

@end


