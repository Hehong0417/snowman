//
//  HJSearchResultTVC.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSearchResultTVC.h"
#import "HJClassifyGoodsListCell.h"
#import "HJGoodsDetailVC.h"
#import "HJSearchBar.h"
#import "HJSearchAPI.h"

@interface HJSearchResultTVC ()
@property (nonatomic, strong) HJSearchBar *searchBar;
@property (nonatomic, strong) UIButton *rightButton;
@end

@implementation HJSearchResultTVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.rowHeight = 102;
    self.navigationItem.titleView = self.searchBar;
    self.searchBar.searchTextField.text = self.goodsName;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    [self.tableView lh_registerNibFromCellClassName:[HJClassifyGoodsListCell className]];
    
    [self searchRequestText:self.goodsName];
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    if ([responseObject isKindOfClass:[HJSearchAPI class]]) {
        
        HJSearchAPI *apiModel = responseObject;
        
        if (!apiModel.data.count) {
            [SVProgressHUD showInfoWithStatus:@"暂无搜索结果"];
        }
        
        self.searchResultArray = apiModel.data;
        [self.tableView reloadData];

        NSLog(@"======%ld",apiModel.data.count);
        
    }
}

#pragma mark - Action

- (void)searchAction {
    [self.view endEditing:YES];
    
    if (self.searchBar.searchTextField.text.length<=0) {
        
        [SVProgressHUD showInfoWithStatus:@"搜索关键字不能为空"];
        
        return;
    }

    [self searchRequestText:self.searchBar.searchTextField.text?:kEmptySrting];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource UITableViewdelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.searchResultArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HJClassifyGoodsListCell *cell = [tableView dequeueReusableCellWithIdentifier:[HJClassifyGoodsListCell className]];
    HJGoodsListModel *goodsListModel = self.searchResultArray[indexPath.row];
    cell.goodsListModel = goodsListModel;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HJGoodsListModel *goodsListModel = self.searchResultArray[indexPath.row];
    HJGoodsDetailVC *goodsDetailVC = [[HJGoodsDetailVC alloc] init];
    goodsDetailVC.goodsId = goodsListModel.goodsId;
    [self.navigationController lh_pushVC:goodsDetailVC];
}

#pragma mark - Networking Request

- (void)searchRequestText:(NSString *)text {
    
    [[[HJSearchAPI search_goodsName:text page:@1 rows:@10]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
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

@end
