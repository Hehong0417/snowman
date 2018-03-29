//
//  HJSegmentCotrollVC.h
//  Bsh
//
//  Created by zhipeng-mac on 15/12/17.
//  Copyright (c) 2015年 lh. All rights reserved.
//
#import "LjjUISegmentedControl.h"

@interface HJSegmentCotrollVC : UIViewController  <UITableViewDelegate,UITableViewDataSource,LjjUISegmentedControlDelegate>

{
    NSInteger _pageNo;
    NSString       *_selectedValue;
}

@property (strong, nonatomic) NSMutableArray *dataSources;
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) LjjUISegmentedControl *segmentControll;
@property (nonatomic, assign) NSInteger selectedType;
@property (nonatomic, strong) NSArray *segmentTitles;

- (void)getDataList;

- (void)loadNewData;

- (void)loadMoreData;

- (void)refreshSegmentTitles;

- (NSArray *)segmentTitles;

@end
