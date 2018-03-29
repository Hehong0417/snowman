//
//  HJAdressListCell.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJReceiptAdressAPI.h"

@interface HJAdressListCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *editAddressButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteAddressButton;
@property (weak, nonatomic) IBOutlet UIButton *defaultAddressButton;

@property (nonatomic, assign) BOOL canEdit;

@property (nonatomic, assign) BOOL showMarginView;

@property (nonatomic, strong) HJRecieptAddressModel *addressModel;

@property (nonatomic, assign) BOOL showDefault;

@end
