//
//  HJHomePageTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJHomePageTVC.h"
#import "HJBannerView.h"
#import "HJHomePageFirstSectionCell.h"
#import "HJHomePageSecondSectionCell.h"
#import "HJHomePageGoodsListCell.h"
#import "HJMemberSignInVC.h"
#import "HJWishWallTVC.h"
#import "XYQButton.h"
#import "HJProvinceTVC.h"
#import "HJSearchBar.h"
#import "HJBannerListAPI.h"
#import "HJWeeklySaleListAPI.h"
#import "HJNewListAPI.h"
#import "HJSearchCVC.h"
#import "HJGoodsDetailVC.h"
#import "HJMapLocation.h"
#import "HJBannerViewVC.h"

//
typedef NS_ENUM(NSUInteger, HJGoodsSelectedType) {
    HJGoodsSelectedTypeWeeklySale = 0,
    HJGoodsSelectedTypeNewList,
};

@interface HJHomePageTVC () <SDCycleScrollViewDelegate,HJDataHandlerProtocol,UITableViewRefreshHandlerDelegate,UITableViewRefreshHandlerDelegate>

@property (nonatomic, strong) HJBannerView *headerBannerView;
@property (nonatomic, strong) XYQButton *cityButton;
@property (nonatomic, strong) HJSearchBar *searchBar;
@property (nonatomic, strong) NSArray *goodsListArray;
@property (nonatomic, assign) HJGoodsSelectedType selectedGoodsTypes;//选择商品类型
@property (nonatomic, strong) NSArray *bannerListArray;

@end

@implementation HJHomePageTVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"首页";
    
    //导航左边定位按钮
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.cityButton];
    
    //搜索栏
    self.navigationItem.titleView = self.searchBar;
    
    self.collectionView.backgroundColor = kVCBackGroundColor;
    
    [self.collectionView registerClass:[HJBannerView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:[HJBannerView className]];
    [self.collectionView registerNib:[UINib nibWithNibName:[HJHomePageFirstSectionCell className] bundle:nil] forCellWithReuseIdentifier:[HJHomePageFirstSectionCell className]];
    [self.collectionView registerNib:[UINib nibWithNibName:[HJHomePageSecondSectionCell className] bundle:nil] forCellWithReuseIdentifier:[HJHomePageSecondSectionCell className]];
    [self.collectionView registerNib:[UINib nibWithNibName:[HJHomePageGoodsListCell className] bundle:nil] forCellWithReuseIdentifier:[HJHomePageGoodsListCell className]];
    
    //注册定位城市改变通知
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(recieveNotificationChangeLocationCity:) name:kNotification_ChangeLocationCity object:nil];
    
    //上下拉刷新
    [self.collectionView lh_addHeaderHandleEvent:self beginRefreshing:NO];
    [self.collectionView lh_addFooterHandleEvent:self];
    
    //开始定位
    [self startLocation];
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self bannerListRequest];
    switch (self.selectedGoodsTypes) {
        case HJGoodsSelectedTypeWeeklySale: {
            {
                [self weeklySaleListRequest];
            }
            break;
        }
        case HJGoodsSelectedTypeNewList: {
            {
                
                [self newListRequest];
            }
            break;
        }
    }
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    //
    if ([responseObject isKindOfClass:[HJBannerListAPI class]]) {
        
        HJBannerListAPI *apiModel = responseObject;
        self.bannerListArray = apiModel.data;
        
        NSMutableArray *bannerImageURLStrs = [NSMutableArray array];
        
        [apiModel.data enumerateObjectsUsingBlock:^(HJBannerListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [bannerImageURLStrs addObject:kAPIImageFromUrl(obj.ico) ];
        }];
        
        self.headerBannerView.cycleSrollView.imageURLStringsGroup = bannerImageURLStrs;
    }
    
    //
    if ([responseObject isKindOfClass:[HJWeeklySaleListAPI class]]) {
        //结束刷新
        [self.collectionView.refreshHeader endRefreshing];
        [self.collectionView.mj_footer endRefreshing];
        
        HJWeeklySaleListAPI *apiModel = responseObject;
        
        self.goodsListArray = apiModel.data.mutableCopy;
        [self.collectionView reloadData];
    }
    
    //
    if ([responseObject isKindOfClass:[HJNewListAPI class]]) {
        
        HJNewListAPI *apiModel = responseObject;
        
        [self.collectionView lh_setRefreshDataSource:apiModel.data];
        
        self.goodsListArray = self.collectionView.refreshDataSource;
        [self.collectionView reloadData];
    }
    
}

- (void)tableViewRefreshDataHandle:(UITableView *)tableView {
    
    [self bannerListRequest];
    
    switch (self.selectedGoodsTypes) {
        case HJGoodsSelectedTypeWeeklySale: {
            {
                
                [self weeklySaleListRequest];
            }
            break;
        }
        case HJGoodsSelectedTypeNewList: {
            {
                
                [self newListRequest];
            }
            break;
        }
    }
    
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
//    HJBannerListModel *bannerListModel = self.bannerListArray[index];
//    if (bannerListModel.bannerType == HJbannerTypeWeb) {
//        HJBannerViewVC *bannerViewVC = [[HJBannerViewVC alloc] init];
//        bannerViewVC.urlString = bannerListModel.url;
//        [self.navigationController lh_pushVC:bannerViewVC];
//    } else if (bannerListModel.bannerType == HJbannerTypeGoodsDetail) {
//        
//    }
    
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 3;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    if (section == 2) {
        
    return self.goodsListArray.count;
    }
    
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    HJHomePageFirstSectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HJHomePageFirstSectionCell className] forIndexPath:indexPath];
    if (indexPath.row == 0 ) {
        
        cell.iconImageVIew.image = [UIImage imageNamed:@"ic_b1_01"];
    }
    if (indexPath.row == 1) {
        
        cell.iconImageVIew.image = [UIImage imageNamed:@"ic_b1_02"];
    }
    
    return cell;
    }
    
    if (indexPath.section == 1) {
        
        HJHomePageSecondSectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HJHomePageSecondSectionCell className] forIndexPath:indexPath];
        if (indexPath.row == 0 ) {
            
            cell.titleLabel.text = @"每周特卖";
            
            if (self.selectedGoodsTypes == HJGoodsSelectedTypeWeeklySale) {
                
                cell.titleLabel.textColor = APP_COMMON_COLOR;
            } else {
                
                cell.titleLabel.textColor = kBlackColor;
            }
        }
        if (indexPath.row == 1) {
            
            cell.titleLabel.text = @"今日上新";
            
            if (self.selectedGoodsTypes == HJGoodsSelectedTypeNewList) {
                
                cell.titleLabel.textColor = APP_COMMON_COLOR;
            } else {
                
                cell.titleLabel.textColor = kBlackColor;
            }

        }

        return cell;
        
    }
    
    if (indexPath.section == 2) {
        
        HJHomePageGoodsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HJHomePageGoodsListCell className] forIndexPath:indexPath];
        
        cell.goodsListModel = self.goodsListArray[indexPath.row];
        
        return cell;
    }
    
    return 0;
}

-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    if (indexPath.section == 1) {
        
        return CGSizeMake(SCREEN_WIDTH * 0.5, WidthScaleSize(40));
    }
    
    if (indexPath.section == 2) {
        
        return CGSizeMake(SCREEN_WIDTH , SCREEN_WIDTH * 0.6);
    }
    
    return CGSizeMake(SCREEN_WIDTH * 0.5, WidthScaleSize(80));
}

-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    if (section == 1) {
        
        return UIEdgeInsetsMake(10, 0, 0, 0);
    }
    
    return UIEdgeInsetsMake(0, 0, 0, 0);
}

-(CGFloat )collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    
    return 0;
}

- (CGFloat) collectionView:(UICollectionView *)collectionView
                    layout:(UICollectionViewLayout *)collectionViewLayout
   minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10.0f;
}

/**
 *  追加视图
 */
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath {
    
    
    if (kind == UICollectionElementKindSectionHeader) {
        
        self.headerBannerView = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:[HJBannerView className] forIndexPath:indexPath];
        self.headerBannerView.cycleSrollView.delegate = self;
        
        return self.headerBannerView;
    }
    
    return nil;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    
    if (section == 1 || section == 2) {
        
        return CGSizeZero;
    }
    
    return CGSizeMake(SCREEN_WIDTH, WidthScaleSize(160));
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0 && indexPath.row == 0) {
        
        HJMemberSignInVC *memberSignInVC = [UIViewController lh_createFromStoryboardName:SB_HOME_PAGE WithIdentifier:[HJMemberSignInVC className]];
        [self.navigationController lh_pushVC:memberSignInVC];
    }
    
    if (indexPath.section == 0 && indexPath.row == 1) {
        
        HJWishWallTVC *wishWallTVC = [HJWishWallTVC new];
        [self.navigationController lh_pushVC:wishWallTVC];
    }
    
    if (indexPath.section == 1) {
       
        if (indexPath.row == 0) {
            
            self.selectedGoodsTypes = HJGoodsSelectedTypeWeeklySale;
            
            [self weeklySaleListRequest];
        }
        
        if (indexPath.row == 1) {
            
            self.selectedGoodsTypes = HJGoodsSelectedTypeNewList;
            self.collectionView.pageNo = 1;
            [self newListRequest];
        }
        
    }
    
    if (indexPath.section == 2) {
        
        HJHomePageGoodsListModel *goodsListModel = self.goodsListArray[indexPath.row];
        
        HJGoodsDetailVC *goodsDetailVC = [HJGoodsDetailVC new];
        goodsDetailVC.goodsId = goodsListModel.goodsId;
        [self.navigationController lh_pushVC:goodsDetailVC];
    }
    
}

#pragma mark - Actions

- (void)goToSearchAction {
    
    [self.searchBar.searchTextField resignFirstResponder];
    
    HJSearchCVC *searchCVC = [HJSearchCVC new];
    [self.navigationController lh_pushVC:searchCVC];
}

- (void)chooseCityAction {
    
    HJProvinceTVC *provinceTVC = [HJProvinceTVC new];
    provinceTVC.areaChooseType = HJAreaChooseTypeProvince;
    provinceTVC.untilChooseType = HJAreaChooseTypeCity;
    [self.navigationController lh_pushVC:provinceTVC];
    
}

#pragma mark - Methods

- (void)startLocation {
    
    //定位城市
    [[HJMapLocation sharedMapLocation]startLocationWithSuccessHandler:^(HJUserCurrentLocationModel *currentLocationModel) {
        
        [[NSNotificationCenter defaultCenter]postNotificationName:kNotification_ChangeLocationCity object:currentLocationModel.regeocode.city];
        
    } failureHandler:^(NSError *error) {
        
        
    }];
    
}

- (void)recieveNotificationChangeLocationCity:(NSNotification *)notification {
    
    NSString *locationCity = notification.object;
    
    [self.cityButton setTitle:locationCity forState:UIControlStateNormal];
}

#pragma mark - Networking Request

- (void)bannerListRequest {
    
    [[[HJBannerListAPI bannerList]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)weeklySaleListRequest {
    
    [[[HJWeeklySaleListAPI weeklySaleList]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)newListRequest {
    
    [[[HJNewListAPI newList_page:@(self.collectionView.pageNo) rows:@(self.collectionView.pageSize)]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

- (XYQButton *)cityButton {
    
    if (!_cityButton) {
        
        WEAK_SELF();
        _cityButton = [XYQButton  ButtonWithFrame:CGRectMake(0, 0, 80, 44)  imgaeName:@"ic_nav_dingwei"  titleName:@"请选择地址" contentType:LeftImageRightTitle buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:[UIColor whiteColor] fontsize:13] aligmentType:AligmentTypeLeft tapAction:^(XYQButton *button) {
            
            [weakSelf chooseCityAction];
            
        }];
        
    }
    
    return _cityButton;
}

- (HJBannerView *)headerBannerView {
    
    if (!_headerBannerView) {
        
        _headerBannerView = [[HJBannerView alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 0.4*SCREEN_WIDTH)];
        _headerBannerView.cycleSrollView.delegate = self;
        _headerBannerView.backgroundColor = kClearColor;
    }
    
    return _headerBannerView;
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

- (NSArray *)bannerListArray
{
    if (_bannerListArray == nil) {
        _bannerListArray = [NSArray array];
    }
    return _bannerListArray;
}

@end
