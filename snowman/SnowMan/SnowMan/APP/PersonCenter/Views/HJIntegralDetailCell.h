//
//  HJIntegralDetailCell.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJScoreListModel;
@interface HJIntegralDetailCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property (nonatomic, strong) HJScoreListModel *scoreListModel;
@end
