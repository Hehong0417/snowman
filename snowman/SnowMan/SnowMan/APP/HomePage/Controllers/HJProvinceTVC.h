//
//  HJProvinceTVC.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJTableViewController.h"

typedef NS_ENUM(NSUInteger, HJAreaChooseType) {
    HJAreaChooseTypeProvince = 0,
    HJAreaChooseTypeCity,
    HJAreaChooseTypeDistrict,
};


@interface HJProvinceTVC : HJTableViewController

@property (nonatomic, strong) NSString *province;
@property (nonatomic, copy) NSString *city;
@property (nonatomic, copy) NSString *district;
@property (nonatomic, strong) NSNumber *areaId;
@property (nonatomic, assign) HJAreaChooseType areaChooseType;
@property (nonatomic, assign) HJAreaChooseType untilChooseType;//进到地区选择第几级页面

@end
