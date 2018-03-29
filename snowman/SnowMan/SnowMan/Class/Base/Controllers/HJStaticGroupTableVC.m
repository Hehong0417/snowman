//
//  HJGroupTableVC.m
//  Bsh
//
//  Created by zhipeng-mac on 15/12/17.
//  Copyright (c) 2015年 lh. All rights reserved.
//

#import "HJStaticGroupTableVC.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import "HJGroupItem.h"

static const CGFloat kNormalTableSectionHeaderViewHeight = 30;
static const CGFloat kNormalGroupSpacing = 10;
static const CGFloat kNormalCellHeight = 44;

@interface HJStaticGroupTableVC () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@end

@implementation HJStaticGroupTableVC

#pragma mark - Life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    //tableView头部设置
    self.tableView.tableHeaderView = self.tableHeaderView;
    //tableView数据源设置
    [self setGroups];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - Methods

- (void)setGroups{
    
    __block NSMutableArray *groups = [NSMutableArray array];
    
    [self.groupTitles enumerateObjectsUsingBlock:^(NSArray *itemTitles, NSUInteger idx, BOOL *stop) {
        
        // 创建组模型
        HJGroupItem *group = [[HJGroupItem alloc]init];
        // 创建行模型
        NSMutableArray *items = [NSMutableArray array];
        
        NSArray *itemIcons = [self.groupIcons objectAtIndex:idx];
        NSArray *itemDetails = [self.groupDetials objectAtIndex:idx];
        [itemTitles enumerateObjectsUsingBlock:^(NSString *itemTitle, NSUInteger idx, BOOL *stop) {
            
            HJSettingItem *settingItem = [HJSettingItem itemWithtitle:itemTitle image:itemIcons[idx]];
            settingItem.detailTitle = itemDetails[idx];
            [items addObject:settingItem];
        }];
        
        group.items = items;
        
        [groups addObject:group];
        
    }];
    
    self.groups = [groups mutableCopy];
}

- (HJSettingItem *)settingItemInIndexPath:(NSIndexPath *)indexPath {
    
    HJGroupItem *groupItem = [self.groups objectAtIndex:indexPath.section];
    
    return  [groupItem.items objectAtIndex:indexPath.row];
}

- (NSArray *)allSettingItems {
    
    NSMutableArray *allSetttingItems = [NSMutableArray array];
    
    [self.groups enumerateObjectsUsingBlock:^(HJGroupItem *groupItem, NSUInteger idx, BOOL *stop) {
        
        [groupItem.items enumerateObjectsUsingBlock:^(HJSettingItem *settingItem, NSUInteger idx, BOOL *stop) {
            
            [allSetttingItems addObject:settingItem];
        }];
        
    }];
    
    return allSetttingItems;
}

- (void)allSettingItemReloadDetailTiltleWithDataSource:(NSArray *)dataSource {
    
    NSArray *allSettingItems = [self allSettingItems];
    
    [allSettingItems enumerateObjectsUsingBlock:^(HJSettingItem *settingItem, NSUInteger idx, BOOL *stop) {
        
        if (idx < 4) {
            
            settingItem.detailTitle = dataSource[idx];
        }
    }];
    
    [self.tableView reloadData];
}

- (void)updateIco:(UIImage *)image {
    
    !self.updateIconAction?:self.updateIconAction(image);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    HJGroupItem *group = self.groups[section];
    return group.items.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    /**
     静态cell不去重用队列获取
     */
      UITableViewCell  *cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:nil];
        cell.selectionStyle = self.cellSelectionStyle;
    // Configure the cell...
    HJGroupItem *group = self.groups[indexPath.section];
    HJSettingItem *item = group.items[indexPath.row];
    
    cell.textLabel.textColor = self.titleLabelFontAttributes.fontColor;
    cell.textLabel.font = self.titleLabelFontAttributes.font;
    cell.textLabel.text = item.title;
    //
    if (item.image.length>0) {
        cell.imageView.image = [UIImage imageNamed:item.image];
    }
    //
    cell.detailTextLabel.text = item.detailTitle;
    cell.detailTextLabel.font = FontNormalSize;
    
    if (self.isSettingIndicator) {
        
        // detailTitle无值时设置Cell右边的小箭头
        if (item.detailTitle.length > 0) {
            
            cell.accessoryType = UITableViewCellAccessoryNone;
        }else {
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        //detailTitle有值时可以设置箭头此时仍然存在
        if (self.indicatorIndexPaths) {
            
            [self.indicatorIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indicatorIndexPath, NSUInteger idx, BOOL *stop) {
                
                if ([indicatorIndexPath isEqual:indexPath]) {
                    
                    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                }
            }];
        }
    }
    
    //右边按钮是UISwitch类型
    if (self.rightViewSwitchIndexPaths) {
        
        [self.rightViewSwitchIndexPaths enumerateObjectsUsingBlock:^(NSIndexPath *indicatorIndexPath, NSUInteger idx, BOOL *stop) {
            
            if ([indicatorIndexPath isEqual:indexPath]) {
                
                cell.accessoryView = [UISwitch new];
            }
        }];
    }
    
    //头像cell
    if ([indexPath isEqual:self.headImageCellIndexPath]) {
        
        [cell.contentView addSubview:self.cellHeadImageView];
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    
    //全部cell有箭头
    if (self.isAllCellIndicator) {
        
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}

#pragma  mark - TableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (!self.tableSectionHeaderViewTitle) {
        
        if (section == 0 && self.firstGroupSpacing > 0) {
            
            
            return self.firstGroupSpacing;
        }
        
        return kNormalGroupSpacing;
    }else {
        
       NSString *tableSectionTitle = [self.tableSectionHeaderViewTitle objectAtIndex:section];
        
        if (tableSectionTitle.length >0) {
            
            return kNormalTableSectionHeaderViewHeight;
        }else {
            
            if (self.firstGroupSpacing>0 && section ==0) {
                
                return self.firstGroupSpacing;
            }
            
            return kNormalGroupSpacing;
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *tableSectionTitle = [self.tableSectionHeaderViewTitle objectAtIndex:section];
    if (tableSectionTitle.length >0) {
        
        UIView *headView = [UIView lh_viewWithFrame:CGRectMake(0, 0, self.tableView.lh_width, kNormalTableSectionHeaderViewHeight) backColor:kClearColor];
        
        UILabel *headLabel = [UILabel lh_labelWithFrame:CGRectMake(15, 0, SCREEN_WIDTH, 30) text:tableSectionTitle textColor:kFontGrayColor font:FontSmallSize textAlignment:NSTextAlignmentLeft backgroundColor:kClearColor];
        [headView addSubview:headLabel];
        
        return headView;
        
    }else {
        
        if (section == 0) {
            
            UIView *headView = [UIView lh_viewWithFrame:CGRectMake(0, 0, self.tableView.lh_width, self.firstGroupSpacing>0?self.firstGroupSpacing:kNormalGroupSpacing) backColor:kClearColor];

            return headView;
        }
        
        UIView *headView = [UIView lh_viewWithFrame:CGRectMake(0, 0, self.tableView.lh_width, kNormalGroupSpacing) backColor:kClearColor];

        return headView;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kNormalCellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if ([indexPath isEqual:self.headImageCellIndexPath]) {
        
        UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"从相册选择", @"拍照", nil];
        [actionSheet bk_setWillDismissBlock:^(UIActionSheet *actionSheet, NSInteger buttonIndex) {
            
            if (buttonIndex == 0) {
                // 相册
                [self getMediaFromSource:UIImagePickerControllerSourceTypeSavedPhotosAlbum];
            }else if (buttonIndex == 1) {
                // 拍照
                [self getMediaFromSource:UIImagePickerControllerSourceTypeCamera];
            }
            
        }];
        [actionSheet showInView:self.view];
    }
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setSeparatorInset:UIEdgeInsetsZero];
    // Prevent the cell from inheriting the Table View's margin settings
    if (iOS8) {
        [cell setPreservesSuperviewLayoutMargins:NO];
        // Explictly set your cell's layout margins
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}

#pragma mark - 拍照 & 相册

- (void)getMediaFromSource:(UIImagePickerControllerSourceType)sourceType {
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
        ipc.sourceType = sourceType;
        ipc.allowsEditing = YES;
        ipc.delegate = self;
        [self presentViewController:ipc animated:YES completion:nil];
    }else {
        [UIAlertView lh_showWithMessage:@"当前设备不支持拍摄功能"];
    }
}


#pragma mark - UIImagePickerControllerDelegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSString *type = info[UIImagePickerControllerMediaType];
    //当选择的类型是图片
    if ([type isEqualToString:(NSString *)kUTTypeImage]) {
        UIImage *image = nil;
        // 判断，图片是否允许修改
        if ([picker allowsEditing]) {
            //获取用户编辑之后的图像
            image = [info objectForKey:UIImagePickerControllerEditedImage];
        } else {
            // 照片的元数据参数
            image = [info objectForKey:UIImagePickerControllerOriginalImage];
        }
        
        //关闭相册界面
        [picker dismissViewControllerAnimated:YES completion:^{
            [self updateIco:image];
        }];
    }
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissViewControllerAnimated:YES completion:nil];
    
    picker.delegate = nil;
    picker = nil;
}

#pragma mark - Setter&Getter

- (NSMutableArray *)groups
{
    if (!_groups) {
        _groups = [NSMutableArray array];
        
    }
    return _groups;
}

- (NSArray *)groupIcons {
    
    return nil;
}

- (NSArray *)groupTitles {
    
    return nil;
}

- (NSArray *)groupDetials {
    
    return nil;
}
- (void)getdatas
{
   
}
- (NSArray *)indicatorIndexPaths {
    
    return nil;
}

- (NSArray *)rightViewSwitchIndexPaths {
    
    return nil;
}

- (BOOL)isSettingIndicator {
    
    return YES;
}

- (FontAttributes *)titleLabelFontAttributes {
    
    return [FontAttributes fontAttributesWithFontColor:[UIColor blackColor] fontsize:14.0];
}

- (CGFloat)firstGroupSpacing {
    
    return 0;
}

- (NSIndexPath *)headImageCellIndexPath {
    
    return nil;
}

- (UITableViewCellSelectionStyle)cellSelectionStyle {
    
    return UITableViewCellSelectionStyleDefault;
}

- (NSArray *)tableSectionHeaderViewTitle {
    
    return nil;
}

- (UIView *)tableHeaderView {
    
    return nil;
}

- (UIImageView *)cellHeadImageView {
    
    if (!_cellHeadImageView) {
        
        CGFloat imageViewSize = 47;
        UIImageView *headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(20, (64-imageViewSize)/2.0, imageViewSize, imageViewSize)];
        [headImageView setBackgroundColor:[UIColor orangeColor]];
        [headImageView lh_setRoundImageViewWithBorderWidth:0 borderColor:kClearColor];
        _cellHeadImageView = headImageView;
    }
    
    return _cellHeadImageView;
}

@end
