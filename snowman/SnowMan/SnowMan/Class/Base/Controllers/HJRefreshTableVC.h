//
//  HJRefreshTableVC.h
//  Apws
//
//  Created by zhipeng-mac on 15/12/26.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

extern NSUInteger const kPageSize;

@protocol HJRefreshTableVCGetDataList <NSObject>

@required
/**
 *  @author hejing
 *
 *  获取接口列表数据
 */
- (void)getDataList;

@end

@interface HJRefreshTableVC : UITableViewController <HJRefreshTableVCGetDataList>

{
    NSInteger _pageNo;
}


/**
 *  @author hejing
 *
 *  tableView数据源
 */
@property (strong, nonatomic) NSMutableArray * dataSource;/**< 组数组 描述TableView有多少组 */

/**
 *  @author hejing
 *
 *  是否集成刷新,默认集成刷新
 */
@property (unsafe_unretained, nonatomic) BOOL canRefresh;

/**
 *  @author hejing
 *
 *  刷新控件结束刷新状态
 */
- (void)refreshControlEndRefresh;
/**
 *  @author hejing
 *
 *  获取数据后刷新tableView数据源
 *
 *  @param dataList 数据源列表
 */
- (void)reloadTableViewAfterRequestSuccessGetDataList:(NSArray *)dataList;
/**
 *  @author hejing
 *
 *  加载新数据
 */
- (void)loadNewData;

/**
 *  @author hejing
 *
 *  加载更多数据
 */
- (void)loadMoreData;


@end
