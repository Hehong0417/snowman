//
//  HJEditAddressTVC.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJStaticGroupTableVC.h"

@class HJRecieptAddressModel;
@interface HJEditAddressTVC : HJStaticGroupTableVC
@property (nonatomic, assign) HJAddressManagerType addressManagerType;
@property (nonatomic, strong) HJRecieptAddressModel *addressModel;
@end
