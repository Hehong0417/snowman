//
//  HJSearchCVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/11.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSearchCVC.h"
#import "HJTitleCCell.h"
#import "HJHotSearchAPI.h"
#import "HJSearchBar.h"
#import "HJSearchResultTVC.h"
#import "HJGoodsDetailVC.h"

@interface HJSearchCVC ()

@property (nonatomic, strong) NSArray *hotSearchDataSource;
@property (nonatomic, strong) HJSearchBar *searchBar;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *hotSeachLabel;

@end

@implementation HJSearchCVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.collectionView.backgroundColor = kVCBackGroundColor;
    
    self.navigationItem.titleView = self.searchBar;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    [self.collectionView registerNib:[UINib nibWithNibName:[HJTitleCCell className] bundle:nil] forCellWithReuseIdentifier:[HJTitleCCell className]];
    [self.view addSubview:self.hotSeachLabel];
    
    [self hotSearchRequest];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    if ([responseObject isKindOfClass:[HJHotSearchAPI class]]) {
        
        HJHotSearchAPI *apiModel = responseObject;
        
        self.hotSearchDataSource = apiModel.data;
        
        [self.collectionView reloadData];
    }
}

#pragma mark - Collection view data source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return self.hotSearchDataSource.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    HJTitleCCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:[HJTitleCCell className] forIndexPath:indexPath];
    
    HJHotSearchModel *hotSearchModel = self.hotSearchDataSource[indexPath.row];
    
    cell.titleLabel.text = hotSearchModel.goodsName;
    
    return cell;
}


-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    return CGSizeMake(WidthScaleSize(90),35);
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(40, 15, 20, 15);
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    HJHotSearchModel *hotSearchModel = self.hotSearchDataSource[indexPath.row];
    
    HJSearchResultTVC *searchResultTVC = [[HJSearchResultTVC alloc] init];
    searchResultTVC.goodsName = hotSearchModel.goodsName;
    [self.navigationController lh_pushVC:searchResultTVC];
}

#pragma mark - Action

- (void)searchAction {
    [self.view endEditing:YES];
    
    if (self.searchBar.searchTextField.text.length<=0) {
        
        [SVProgressHUD showInfoWithStatus:@"搜索关键字不能为空"];
        
        return;
    }
    
    HJSearchResultTVC *searchResultTVC = [[HJSearchResultTVC alloc] init];
    searchResultTVC.goodsName = self.searchBar.searchTextField.text?:kEmptySrting;
    [self.navigationController lh_pushVC:searchResultTVC];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Networking Request

- (void)hotSearchRequest {
    
    [[[HJHotSearchAPI hotSearch]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - setting && getting

- (HJSearchBar *)searchBar {
    
    if (!_searchBar) {
        
        _searchBar = [HJSearchBar lh_createByFrame:CGRectMake(0, 0, WidthScaleSize(220), 30)];
        _searchBar.searchTextField.placeholder = @"请输入商品关键字";
        WEAK_SELF();
        _searchBar.searchDoneHandler = ^() {
            
            [weakSelf searchAction];
        };
    }
    
    return _searchBar;
}

- (UIButton *)rightButton
{
    if (_rightButton == nil) {
        _rightButton = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 30, 30) target:self action:@selector(searchAction) title:@"搜索" titleColor:kWhiteColor font:FONT(15) backgroundColor:kClearColor];
    }
    return _rightButton;
}

- (UILabel *)hotSeachLabel
{
    if (!_hotSeachLabel) {
        _hotSeachLabel = [UILabel lh_labelAdaptionWithFrame:CGRectMake(15, 74, 100, 40) text:@"热门搜索" textColor:RGBA(0, 0, 0, 0.5) font:FONT(15) textAlignment:NSTextAlignmentLeft];
    }
    return _hotSeachLabel;
}

@end
