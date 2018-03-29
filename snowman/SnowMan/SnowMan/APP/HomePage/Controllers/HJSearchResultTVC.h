//
//  HJSearchResultTVC.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJTableViewController.h"
#import "HJGetGoodsListAPI.h"

@interface HJSearchResultTVC : HJTableViewController
@property (nonatomic, copy) NSString *goodsName;
@property (nonatomic, strong) NSArray<HJGoodsListModel *> *searchResultArray;
@end
