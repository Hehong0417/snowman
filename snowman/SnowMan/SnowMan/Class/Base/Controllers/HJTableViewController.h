//
//  HJTabViewController.h
//  Cancer
//
//  Created by zhipeng-mac on 16/2/17.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

static NSString * const kDataSourceKeyPath = @"dataSource";

@interface HJTableViewController : UITableViewController <HJDataHandlerProtocol>

@property (nonatomic, strong) NSMutableArray *selectItem;
@property (nonatomic, strong) NSArray *dataSource;

- (void)showRightIndicatorWhenSelectedCell:(UITableViewCell *)cell indicatorSelectedImageName:(NSString *)selectedImageName cellIndexPath:(NSIndexPath *)indexPath;

@end
