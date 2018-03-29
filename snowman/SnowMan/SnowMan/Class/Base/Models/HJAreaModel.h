//
//  HJAreaModel.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseModel.h"

@class HJAearRootModel,HJProvinceModel,HJCityModel,HJDistrictModel;
@interface HJAreaModel : HJBaseModel

@property (nonatomic, strong) HJAearRootModel *root;


@end
@interface HJAearRootModel : HJBaseModel

@property (nonatomic, strong) NSArray<HJProvinceModel *> *province;

@end

@interface HJProvinceModel : HJBaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<HJCityModel *> *city;

@end

@interface HJCityModel : HJBaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray<HJDistrictModel *> *district;

@end

@interface HJDistrictModel : HJBaseModel

@property (nonatomic, copy) NSString *name;

@property (nonatomic, copy) NSString *zipcode;

@end

