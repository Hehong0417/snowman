//
//  HJGroupTableVC.h
//  Bsh
//
//  Created by zhipeng-mac on 15/12/17.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HJSettingItem.h"
#import "XYQButton.h"

typedef void(^UpdateIconBlock)(UIImage *image);

@interface HJStaticGroupTableVC : UITableViewController <HJDataHandlerProtocol>

@property (strong, nonatomic) NSMutableArray * groups;/**< 组数组 描述TableView有多少组 */
@property (nonatomic, strong) UIImageView *cellHeadImageView;

@property (nonatomic, assign, getter=isAllCellIndicator) BOOL allCellIndicator;

@property (nonatomic, strong) UpdateIconBlock updateIconAction;

/**
 *  @author hejing
 *
 *  静态cell数据源
 */
- (NSArray *)groupTitles;
- (NSArray *)groupIcons;
- (NSArray *)groupDetials;
- (NSArray *)indicatorIndexPaths;//detailTitle有值时默认不显示箭头，这里可以添加箭头
- (void)setGroups;

- (HJSettingItem *)settingItemInIndexPath:(NSIndexPath *)indexPath;

- (NSArray *)allSettingItems;

- (void)allSettingItemReloadDetailTiltleWithDataSource:(NSArray *)dataSource;
/**
 *  @author hejing
 *
 *  是否显示箭头,默认显示
 */
- (BOOL)isSettingIndicator;

- (FontAttributes *)titleLabelFontAttributes;

/**
 *  @author hejing
 *
 *  第一组的间距
 */
- (CGFloat)firstGroupSpacing;

/**
 *  @author hejing
 *
 *  头像cell indexPath
 */
- (NSIndexPath *)headImageCellIndexPath;

/**
 *  @author hejing
 *
 *  点击选中效果
 */
- (UITableViewCellSelectionStyle)cellSelectionStyle;

/**
 *  @author hejing
 *
 *  右边的类型是UISwitch的cell路径
 */
- (NSArray *)rightViewSwitchIndexPaths;

/**
 *  @author hejing
 *
 *  table HeadView 的title
 */
- (NSArray *)tableSectionHeaderViewTitle;

/**
 *  设置tableView的表头，会随之上下滑动
 *
 *  @return tableView的表头
 */
- (UIView *)tableHeaderView;

/**
 *  获得相册资源
 *
 *  @param sourceType 类型
 */
- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType;

@end
