//
//  HJClassifyVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJClassifyVC.h"
#import "HJClassifyHeaderTitleView.h"
#import "HJGoodsDetailVC.h"
#import "HJFirstClassifyAPI.h"
#import "HJSecondClassifyAPI.h"
#import "HJGetGoodsListAPI.h"
#import "HJBrandAPI.h"
#import "HJClassifyGoodsListCell.h"
#import "XYQButton.h"
#import "HJMapLocation.h"
#import "HJProvinceTVC.h"
#import "HJSearchBar.h"
#import "HJSearchCVC.h"
#import "UIScrollView+EmptyDataSet.h"

#define kTableBackGroundColor RGB(245, 245, 245)

@interface HJClassifyVC () <UITableViewDelegate,UITableViewDataSource,UITableViewRefreshHandlerDelegate,DZNEmptyDataSetSource, DZNEmptyDataSetDelegate>

@property (nonatomic, strong) HJClassifyHeaderTitleView *titleView;

@property (nonatomic, strong) UITableView *leftTableView;
@property (nonatomic, strong) UITableView *rightTableView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UITableView *secondClassifyTableView;//全部分类和品牌筛选tableView
@property (nonatomic, strong) NSArray *firstClassifyArray;
@property (nonatomic, strong) NSArray *filterContentArray;//全部类别和品牌数据源
@property (nonatomic, strong) NSArray *goodsListArray;
@property (nonatomic, assign) HJGoodsClassifyIdType goodsClassifyIdType;
@property (nonatomic, strong) XYQButton *cityButton;
@property (nonatomic, strong) HJSearchBar *searchBar;
@property (nonatomic, assign) NSUInteger selectedFirstClassIndex;
@property (nonatomic, assign) NSUInteger selectedSecondClassIndex;
@property (nonatomic, assign) NSUInteger selectedBrandIndex;
@property (nonatomic, strong) HJClassifyModel *selectedSecondClassifyModel;
@property (nonatomic, strong) HJBrandModel *selectedBrandModel;

@property (nonatomic, strong) NSNumber *selectedGoodsTypeId;
@property (nonatomic, strong) NSNumber *selectedBrandId;
@property (nonatomic, assign) HJGoodsClassifyIdType selectedType;

@end

@implementation HJClassifyVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"分类";
    
    [self.view addSubview:self.titleView];
    [self.view addSubview:self.leftTableView];
    [self.view addSubview:self.rightTableView];
    [self.view addSubview:self.lineView];
    
    //导航左边定位按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.cityButton];
    
    self.navigationItem.titleView = self.searchBar;

    self.goodsClassifyIdType = HJGoodsClassifyIdTypeFirst;
    
    //注册定位城市改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recieveNotificationChangeLocationCity:) name:kNotification_ChangeLocationCity object:nil];
    
    //定位城市
    [[HJMapLocation sharedMapLocation]startLocationWithSuccessHandler:^(HJUserCurrentLocationModel *currentLocationModel) {
        
        [self.cityButton setTitle:currentLocationModel.regeocode.city forState:UIControlStateNormal];
        
    } failureHandler:^(NSError *error) {
        
        
    }];
    
    //KVO
    [self bk_addObserverForKeyPath:@"selectedSecondClassIndex" task:^(id target) {
        
        NSLog(@"selectedSecond==%ld",self.selectedSecondClassIndex);
        //
        self.selectedSecondClassifyModel = self.filterContentArray[self.selectedSecondClassIndex];
        
    }];
    
    [self bk_addObserverForKeyPath:@"selectedBrandIndex" task:^(id target) {
        
        NSLog(@"selectedBrandIndex==%ld",self.selectedBrandIndex);
        //
        self.selectedBrandModel = self.filterContentArray[self.selectedBrandIndex];
    }];

    //添加下拉刷新
    self.rightTableView.pageNo = 1;
    [self.rightTableView lh_addHeaderHandleEvent:self beginRefreshing:NO];
    [self.rightTableView lh_addFooterHandleEvent:self];
    
    //暂无数据显示
    self.rightTableView.emptyDataSetSource = self;
    self.rightTableView.emptyDataSetDelegate = self;

    [self firstClassifyRequest];

}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
}

- (void)viewDidLayoutSubviews {
    
    self.titleView.frame = CGRectMake(0, STATUS_NAV_HEIGHT, SCREEN_WIDTH, 50);
    
    self.leftTableView.frame = CGRectMake(0, self.titleView.lh_bottom, SCREEN_WIDTH/3.0, SCREEN_HEIGHT - self.titleView.lh_bottom - TABBAR_HEIGHT);
    self.leftTableView.frame = CGRectMake(0, self.titleView.lh_bottom, SCREEN_WIDTH/3.0, SCREEN_HEIGHT - self.titleView.lh_bottom - TABBAR_HEIGHT);
    self.rightTableView.frame = CGRectMake(self.leftTableView.lh_right, self.leftTableView.lh_top, SCREEN_WIDTH - self.leftTableView.lh_width, self.leftTableView.lh_height);
    self.secondClassifyTableView.frame = self.rightTableView.frame;
    self.lineView.frame = CGRectMake(self.rightTableView.lh_left-1.0f, self.rightTableView.lh_top, 1.0f, self.rightTableView.lh_height);
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    //
    if ([responseObject isKindOfClass:[HJFirstClassifyAPI class]]) {
        
        HJFirstClassifyAPI *apiModel = responseObject;
        
        self.firstClassifyArray = apiModel.data;
        
        [self.leftTableView reloadData];
        
        //默认选中第一个分类
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        
        //
        HJClassifyModel *firstClassifyModel = [self.firstClassifyArray firstObject];
        
        [self getGoodsListWithGoodsTypeId:@(firstClassifyModel.goodsTypeId) type:HJGoodsClassifyIdTypeFirst brandId:nil];

    }
    
    //
    if ([responseObject isKindOfClass:[HJSecondClassifyAPI class]]) {
        
        HJSecondClassifyAPI *apiModel = responseObject;
        
        //添加第一个全部类别
        NSMutableArray *filterContentArray = apiModel.data.mutableCopy;
        HJClassifyModel *allClassModel = [HJClassifyModel new];
        allClassModel.goodsTypeName = @"全部类别";
        [filterContentArray insertObject:allClassModel atIndex:0];
        
        self.filterContentArray = filterContentArray;
        
        [self.secondClassifyTableView reloadData];
        [self.secondClassifyTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedSecondClassIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        self.selectedSecondClassifyModel = self.filterContentArray[self.selectedSecondClassIndex];
    }
    
    //
    if ([responseObject isKindOfClass:[HJGetGoodsListAPI class]]) {
        
        HJGetGoodsListAPI *apiModel = responseObject;
        
        [self.rightTableView lh_setRefreshDataSource:apiModel.data];
        
        self.goodsListArray =self.rightTableView.refreshDataSource;
        
        [self.rightTableView reloadData];
    }
    
    //
    if ([responseObject isKindOfClass:[HJBrandAPI class]]) {
        
        HJBrandAPI *apiModel = responseObject;
        
        //添加第一个全部类别
        NSMutableArray *filterContentArray = apiModel.data.mutableCopy;
        HJBrandModel *brandModel = [HJBrandModel new];
        brandModel.brandName = @"全部品牌";
        [filterContentArray insertObject:brandModel atIndex:0];

        self.filterContentArray = filterContentArray;
        
        [self.secondClassifyTableView reloadData];
        [self.secondClassifyTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:self.selectedBrandIndex inSection:0] animated:YES scrollPosition:UITableViewScrollPositionNone];
        self.selectedBrandModel = self.filterContentArray[self.selectedBrandIndex];

    }
}

#pragma mark - Actions

- (void)chooseClassItemAction {
    
    
    
}

- (void)chooseAllClassItemAction:(UIButton *)button {
    
    //
    button.selected = !button.selected;
    
    if (button.selected == NO) {
        
        [self.secondClassifyTableView removeFromSuperview];
    } else {
    
    self.secondClassifyTableView.frame = self.rightTableView.frame;
    [self.view addSubview:self.secondClassifyTableView];
    
    //
    NSUInteger leftSelectRow = self.leftTableView.indexPathForSelectedRow.row;
    //
    HJClassifyModel *classifyModel = self.firstClassifyArray[leftSelectRow];
    [self secondClassifyRequestWithGoodsTypeId:@(classifyModel.goodsTypeId)];
    }
}

- (void)chooseAllBrandItemAction:(UIButton *)button {
    
    button.selected = !button.selected;
    
    if (button.selected == NO) {
        
        [self.secondClassifyTableView removeFromSuperview];
    } else {
    
    self.secondClassifyTableView.frame = self.rightTableView.frame;
    [self.view addSubview:self.secondClassifyTableView];
    
    //
    NSUInteger leftSelectRow = self.leftTableView.indexPathForSelectedRow.row;
    //
    HJClassifyModel *classifyModel = self.firstClassifyArray[leftSelectRow];
    [self brandRequestWithGoodsTypeId:@(classifyModel.goodsTypeId) type:@(HJGoodsClassifyIdTypeFirst)];
    }
}

- (void)chooseCityAction {
    
    HJProvinceTVC *provinceTVC = [HJProvinceTVC new];
    provinceTVC.areaChooseType = HJAreaChooseTypeProvince;
    provinceTVC.untilChooseType = HJAreaChooseTypeCity;
    [self.navigationController lh_pushVC:provinceTVC];
    
}

- (void)goToSearchAction {
    
    [self.searchBar.searchTextField resignFirstResponder];
    
    HJSearchCVC *searchCVC = [HJSearchCVC new];
    [self.navigationController lh_pushVC:searchCVC];
}

#pragma mark - Methods

- (void)recieveNotificationChangeLocationCity:(NSNotification *)notification {
    
    NSString *locationCity = notification.object;
    
    [self.cityButton setTitle:locationCity forState:UIControlStateNormal];
}


#pragma mark -Delegate Methods

#pragma mark - DZNEmptyDataSetSource

- (NSAttributedString *)titleForEmptyDataSet:(UIScrollView *)scrollView
{
    NSString *text = @"暂无数据";
    
    NSDictionary *attributes = @{NSFontAttributeName: [UIFont boldSystemFontOfSize:16.0f],
                                 NSForegroundColorAttributeName: kFontBlackColor};
    
    return [[NSAttributedString alloc] initWithString:text attributes:attributes];
}

#pragma mark - UITableViewRefreshHandlerDelegate

- (void)tableViewRefreshDataHandle:(UITableView *)tableView {
    
    [self getGoodsListWithGoodsTypeId:self.selectedGoodsTypeId type:self.selectedType brandId:self.selectedBrandId];
    
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.leftTableView) {
        
        return self.firstClassifyArray.count;
    }
    
    if (tableView == self.rightTableView) {
        
        return self.goodsListArray.count;
    }
    
    return self.filterContentArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == self.leftTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
        
        cell.contentView.backgroundColor = kTableBackGroundColor;
        cell.selectedTextColor = APP_COMMON_COLOR;
        UIView *backGroundView = [UIView new];
        backGroundView.backgroundColor = kWhiteColor;
        cell.selectedBackgroundView = backGroundView;
        HJClassifyModel *classifyModel = self.firstClassifyArray[indexPath.row];
        
        cell.textLabel.text = classifyModel.goodsTypeName;
        
        [cell lh_setSeparatorInsetZero];
        
        return cell;

        
    } else if (tableView == self.rightTableView) {
        //商品列表cell
        HJClassifyGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJClassifyGoodsListCell className]];
        HJGoodsListModel *goodsListModel = self.goodsListArray[indexPath.row];
        cell.goodsListModel = goodsListModel;
        
        UIView *backGroundView = [UIView new];
        backGroundView.backgroundColor = kWhiteColor;
        cell.selectedBackgroundView = backGroundView;

        return cell;
        
    } else if (tableView == self.secondClassifyTableView) {
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[UITableViewCell className]];
        
        cell.contentView.backgroundColor = kTableBackGroundColor;
        cell.selectedTextColor = APP_COMMON_COLOR;

        id model = self.filterContentArray[indexPath.row];
        
        if ([model isKindOfClass:[HJClassifyModel class]]) {
            
            HJClassifyModel *classifyModel = model;
            
            cell.textLabel.text = classifyModel.goodsTypeName;
        }
        
        if ([model isKindOfClass:[HJBrandModel class]]) {
            
            HJBrandModel *brandModel = model;
            
            cell.textLabel.text = brandModel.brandName;
        }

        [cell lh_setSeparatorInsetZero];
        
        UIView *backGroundView = [UIView new];
        backGroundView.backgroundColor = kWhiteColor;
        cell.selectedBackgroundView = backGroundView;

        return cell;
    }
    
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView ==  self.leftTableView || tableView == self.secondClassifyTableView) {
        
        return 50;
    } else {
        
        return 102;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    if (tableView == self.leftTableView) {
        
        HJClassifyModel *classifyModel = self.firstClassifyArray[indexPath.row];
        
        //点击其他类别是第二个分类类别和商品默认选中第一个
        if (self.selectedFirstClassIndex != indexPath.row) {
            
            self.selectedSecondClassIndex = 0;
            self.selectedBrandIndex = 0;
            //
            self.selectedFirstClassIndex = indexPath.row;
            
            //
            [self.titleView.allClassItemButton setTitle:@"全部类别" forState:UIControlStateNormal];
            [self.titleView.allBrandItemButton setTitle:@"全部品牌" forState:UIControlStateNormal];

        }
        
        //如果在筛选类别或者品牌，则进行二级列表或者品牌列表的筛选内容请求
        if ([self.view.subviews containsObject:self.secondClassifyTableView]) {
            
            [self secondClassifyRequestWithGoodsTypeId:@(classifyModel.goodsTypeId)];
            
            return;
        }
        
        //点击时如果二级分类和品牌选择都为0，也即是选择全部，进行第一级分类所有商品请求
        if (self.selectedSecondClassIndex == 0&& self.selectedBrandIndex == 0) {
            //
         //清除原先类别的数据源
            self.rightTableView.pageNo = 1;
            
        //商品列表请求
        [self getGoodsListWithGoodsTypeId:@(classifyModel.goodsTypeId) type:HJGoodsClassifyIdTypeFirst
                                  brandId:nil];
        }
    }
    
    if (tableView == self.secondClassifyTableView) {
       
        //清除原先类别的数据源
        self.rightTableView.pageNo = 1;
        
        NSUInteger selectedRow = indexPath.row;
        
        [self.secondClassifyTableView removeFromSuperview];
        
        id model = self.filterContentArray[selectedRow];
        
        //条件筛选进行商品列表请求
        if ([model isKindOfClass:[HJClassifyModel class]]) {
            
            //对应全部类别按钮状态更改
            self.titleView.allClassItemButton.selected = NO;
            
            HJClassifyModel *classifyModel = model;
            
            //选中的二级分类index
            self.selectedSecondClassIndex = indexPath.row;
            
            if (indexPath.row == 0) {
                
                NSUInteger leftTableSelectedRow = self.leftTableView.indexPathForSelectedRow.row;
                HJClassifyModel *firstClassifyModel = self.firstClassifyArray[leftTableSelectedRow];
                
                classifyModel.goodsTypeId = firstClassifyModel.goodsTypeId;
                
                //选择二级分类标题改变
                [self.titleView.allClassItemButton setTitle:classifyModel.goodsTypeName forState:UIControlStateNormal];
                
                //全部类别商品列表请求
                [self getGoodsListWithGoodsTypeId:@(classifyModel.goodsTypeId) type:HJGoodsClassifyIdTypeFirst
                                          brandId:self.selectedBrandIndex == 0 ? nil : @(self.selectedBrandModel.brandId)];

            } else {
                
            //选择二级分类标题改变
            [self.titleView.allClassItemButton setTitle:classifyModel.goodsTypeName forState:UIControlStateNormal];
                
            [self getGoodsListWithGoodsTypeId:@(classifyModel.goodsTypeId) type:HJGoodsClassifyIdTypeSecond brandId:self.selectedBrandIndex == 0 ? nil : @(self.selectedBrandModel.brandId)];
            }
        }
        
        if ([model isKindOfClass:[HJBrandModel class]]) {
            
            //对应全部品牌按钮状态更改
            self.titleView.allBrandItemButton.selected = NO;
            
            //选中的品牌index
            self.selectedBrandIndex = indexPath.row;

            NSUInteger firstSelectRow = self.leftTableView.indexPathForSelectedRow.row;
            HJClassifyModel *classifyModel = self.firstClassifyArray[firstSelectRow];
            
            //如果二级分类选中的不是第一个的全部类别，classifyModel应为选中的二级分类model
            if (self.selectedSecondClassIndex != 0) {
                
                classifyModel = self.selectedSecondClassifyModel;
            }
            
            HJBrandModel *brandModel = model;
            
            //选择二级分类标题改变
            [self.titleView.allBrandItemButton setTitle:brandModel.brandName forState:UIControlStateNormal];

            
            if (indexPath.row == 0) {
                
                //全部类别商品列表请求
                [self getGoodsListWithGoodsTypeId:@(classifyModel.goodsTypeId) type:self.selectedSecondClassIndex==0?HJGoodsClassifyIdTypeFirst:HJGoodsClassifyIdTypeSecond
                                          brandId:nil];
                
            } else {
            
            [self getGoodsListWithGoodsTypeId:@(classifyModel.goodsTypeId) type:self.selectedSecondClassIndex==0?HJGoodsClassifyIdTypeFirst:HJGoodsClassifyIdTypeSecond brandId:@(brandModel.brandId)];
            }
        }
        
       }
    
    if (tableView == self.rightTableView) {
        
        HJGoodsListModel *goodsListModel = self.goodsListArray[indexPath.row];
        
        HJGoodsDetailVC *goodsDetailVC = [HJGoodsDetailVC new];
        goodsDetailVC.goodsId = goodsListModel.goodsId;
        [self.navigationController lh_pushVC:goodsDetailVC];
    }
    
}

#pragma mark - NetWorking Request

- (void)firstClassifyRequest {
    
    [[[HJFirstClassifyAPI firstClassify]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)secondClassifyRequestWithGoodsTypeId:(NSNumber *)goodsTypeId {
    
    [[[HJSecondClassifyAPI sencondClassify_goodsTypeId:goodsTypeId]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)getGoodsListWithGoodsTypeId:(NSNumber *)goodsTypeId type:(HJGoodsClassifyIdType)type brandId:(NSNumber *)brandId {
    
    //
    [[[HJGetGoodsListAPI getGoodsList_goodsTypeId:goodsTypeId type:type brandId:brandId page:@(self.rightTableView.pageNo) rows:@(self.rightTableView.pageSize)]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
    
    //请求参数全局变量
    self.selectedGoodsTypeId = goodsTypeId;
    self.selectedType = type;
    self.selectedBrandId = brandId;

}

- (void)brandRequestWithGoodsTypeId:(NSNumber *)goodsTypeId type:(NSNumber *)type {
    
    [[[HJBrandAPI brand_goodsTypeId:goodsTypeId type:type]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

- (HJClassifyHeaderTitleView *)titleView {
    
    if (!_titleView) {
        
        _titleView = [HJClassifyHeaderTitleView lh_createByFrame:CGRectZero];
        
        //
        [_titleView.classItemButton addTarget:self action:@selector(chooseClassItemAction) forControlEvents:UIControlEventTouchUpInside];
        [_titleView.allClassItemButton addTarget:self action:@selector(chooseAllClassItemAction:) forControlEvents:UIControlEventTouchUpInside];
        [_titleView.allBrandItemButton addTarget:self action:@selector(chooseAllBrandItemAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _titleView;
}



- (UITableView *)leftTableView {
    
    if (!_leftTableView) {
        
        _leftTableView = [UITableView lh_tableViewWithFrame:CGRectZero tableViewStyle:UITableViewStylePlain delegate:self dataSourec:self];
        _leftTableView.backgroundColor = kTableBackGroundColor;
        _leftTableView.separatorColor = kLineDeepColor;
        _leftTableView.tableFooterView = [UIView new];
        [_leftTableView lh_registerClassFromCellClassName:[UITableViewCell className]];
    }
    
    return _leftTableView;
}

- (UITableView *)rightTableView {
    
    if (!_rightTableView) {
        
        _rightTableView = [UITableView lh_tableViewWithFrame:CGRectZero tableViewStyle:UITableViewStylePlain delegate:self dataSourec:self];
        _rightTableView.backgroundColor = kTableBackGroundColor;
        _rightTableView.tableFooterView = [UIView new];
        [_rightTableView lh_registerClassFromCellClassName:[UITableViewCell className]];
        [_rightTableView lh_registerNibFromCellClassName:[HJClassifyGoodsListCell className]];
    }
    
    return _rightTableView;
}

- (UITableView *)secondClassifyTableView {
    
    if (!_secondClassifyTableView) {
        
        _secondClassifyTableView = [UITableView lh_tableViewWithFrame:CGRectZero tableViewStyle:UITableViewStylePlain delegate:self dataSourec:self];
        _secondClassifyTableView.backgroundColor = kTableBackGroundColor;
        _secondClassifyTableView.tableFooterView = [UIView new];
        [_secondClassifyTableView lh_registerClassFromCellClassName:[UITableViewCell className]];
    }
    
    return _secondClassifyTableView;
}

- (UIView *)lineView {
    
    if (!_lineView) {
        
        _lineView = [UIView lh_viewWithFrame:CGRectZero backColor:kLineDeepColor];
    }
    
    return _lineView;
}

- (XYQButton *)cityButton {
    
    if (!_cityButton) {
        
        WEAK_SELF();
        _cityButton = [XYQButton  ButtonWithFrame:CGRectMake(0, 0, 80, 44)  imgaeName:@"ic_nav_dingwei"  titleName:@"请选择地址" contentType:LeftImageRightTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:[UIColor whiteColor] fontsize:13] aligmentType:AligmentTypeLeft tapAction:^(XYQButton *button) {
            
            [weakSelf chooseCityAction];
        }];
    }
    return _cityButton;
}

- (HJSearchBar *)searchBar {
    
    if (!_searchBar) {
        
        _searchBar = [HJSearchBar lh_createByFrame:CGRectMake(0, 0, WidthScaleSize(250), 30)];
        _searchBar.searchTextField.placeholder = @"请输入商品关键字";
        WEAK_SELF();
        _searchBar.searchDoneHandler = ^() {
            
            [weakSelf goToSearchAction];
        };
        
        [_searchBar.searchTextField setBk_didBeginEditingBlock:^(UITextField *textField) {
            
            [weakSelf goToSearchAction];
        }];
    }
    
    return _searchBar;
}

@end
