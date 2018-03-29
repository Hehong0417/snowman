//
//  HJBannerListAPI.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/7.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJBannerListModel;
@interface HJBannerListAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJBannerListModel *> *data;


+ (instancetype)bannerList;

@end
@interface HJBannerListModel : NSObject

@property (nonatomic, assign) NSInteger bannerType;

@property (nonatomic, copy) NSString *createTime;

@property (nonatomic, copy) NSString *ico;

@property (nonatomic, copy) NSString *url;

@property (nonatomic, copy) NSString *note;

@property (nonatomic, assign) NSInteger bannerId;

@end

