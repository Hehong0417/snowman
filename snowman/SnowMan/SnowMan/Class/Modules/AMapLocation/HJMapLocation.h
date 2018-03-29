//
//  HJMapLocation.h
//  Ddsc
//
//  Created by zhipeng-mac on 16/1/20.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "HJBaseModel.h"

@interface HJUserCurrentLocationModel : HJBaseModel

@property (nonatomic, strong) CLLocation *location;
@property (nonatomic, strong) AMapLocationReGeocode *regeocode;

@end

@interface HJMapLocation : NSObject

@property (nonatomic, strong) HJUserCurrentLocationModel *currentLocationModel;

+ (instancetype)sharedMapLocation;

- (void)startLocationWithSuccessHandler:(void (^)(HJUserCurrentLocationModel *currentLocationModel))successHandler failureHandler:(void (^)(NSError *error))failureHandler;

@end
