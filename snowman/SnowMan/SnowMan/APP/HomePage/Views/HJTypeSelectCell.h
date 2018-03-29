//
//  HJTypeSelectCell.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/11.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJGoodsIntroduceAPI.h"


@interface HJTypeSelectCell : UITableViewCell

@property (nonatomic, strong) NSArray <HJGoodsIntroduceStandardlistModel *>*typeArray;
@property (nonatomic, strong) idBlock selectStandardSizeHandler;
@property (nonatomic, strong) NSString *selectStandardName;

@end
