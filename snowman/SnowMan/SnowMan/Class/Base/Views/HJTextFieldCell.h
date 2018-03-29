//
//  TSTextFieldCell.h
//  Transport
//
//  Created by zhipeng-mac on 15/11/30.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJSettingItem.h"

typedef NS_ENUM(NSUInteger, HJTextFieldCellType) {
    HJTextFieldCellTypePhone = 0,
};

@interface HJTextFieldCell : UITableViewCell

@property (nonatomic, strong) HJSettingItem *settingItem;

@property (nonatomic, unsafe_unretained) BOOL showActionSheet;

@property (nonatomic, strong) UITextField *detailTextField;

@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, unsafe_unretained) CGFloat textFieldLeft;
@property (nonatomic, assign) HJTextFieldCellType TextFieldCellType;

@end
