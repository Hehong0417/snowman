//
//  HJShoppingCartTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJShoppingCartTVC.h"
#import "HJShoppingCartListCell.h"
#import "HJShoppingCartSettleBar.h"
#import "HJShoppingCartListHeaderView.h"
#import "HJSureOrderVC.h"
#import "HJShopCartBrandAPI.h"
#import "HJShoppingCartDeleteBar.h"
#import "HJEditBrandAPI.h"
#import "HJRequestParameterListModel.h"
#import "HJExitLoginView.h"

static CGFloat kShoppingCartListCellHeight = 105;
static CGFloat kShoppingCartHeaderViewHeight = 50;
static CGFloat kShoppingCartSettleBarHeight = 50;
static CGFloat kShoppingCartDeleteBarHeight = 60;

@interface HJShoppingCartTVC () <UITableViewDelegate,UITableViewDataSource, HJShoppingCartListHeaderViewDelegate, HJShoppingCartListCellDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HJShoppingCartSettleBar *settleBar;
@property (nonatomic, strong) HJShopCartModel *shopCartModel;
@property (nonatomic, strong) HJShoppingCartDeleteBar *deleteBar;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, assign) BOOL goodsAllSelect;
@property (nonatomic, assign) BOOL boxAllSelect;
@property (nonatomic, assign) BOOL editing;
@property (nonatomic, strong) NSMutableArray *goodsListArray;
@property (nonatomic, strong) NSMutableArray *boxListArray;
@property (nonatomic, assign) CGFloat totalCash;
@end

@implementation HJShoppingCartTVC

#pragma mark - LifeCycle
- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.title = @"购物车";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.settleBar];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:self.rightButton];
    self.navigationItem.leftBarButtonItem = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self getShoppingCartRequest];
    self.settleBar.totalCashLabel.text = @"￥0.00";
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    self.settleBar.totalCashLabel.text = @"￥0.00";
    self.goodsAllSelect = NO;
    self.boxAllSelect = NO;
    self.boxAllSelect = NO;
    self.deleteBar.select = NO;
    self.editing = NO;
    [self.goodsListArray removeAllObjects];
    [self.boxListArray removeAllObjects];
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.shopCartModel.goodsList.count && self.shopCartModel.boxList.count) {
        return 2;
        
    } else if (self.shopCartModel.goodsList.count || self.shopCartModel.boxList.count) {
        return 1;
        
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && self.shopCartModel.goodsList.count) {
        return self.shopCartModel.goodsList.count;
        
    } else {
        return self.shopCartModel.boxList.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    HJShoppingCartListCell *cell = [HJShoppingCartListCell cellWithTableView:tableView];
    cell.delegate = self;
    cell.canEdit = self.editing;
    cell.tag = indexPath.row;
    
    if (indexPath.section == 0 && self.shopCartModel.goodsList.count) {
        HJGoodsListModell *goodsListModel = self.shopCartModel.goodsList[indexPath.row];
        [self.goodsListArray enumerateObjectsUsingBlock:^(HJGoodsListModell  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (obj.goodsId == goodsListModel.goodsId) {
                
                if (obj.priceList.count == 2 && goodsListModel.priceList.count == 2) {
                    cell.select = YES;
                    [self.goodsListArray replaceObjectAtIndex:idx withObject:goodsListModel];

                } else if (obj.priceList.count == 1 && goodsListModel.priceList.count == 1) {
                    HJPriceListModel *PriceListModel = obj.priceList[0];
                    HJPriceListModel *PriceListModel1 = goodsListModel.priceList[0];
                    
                    if (PriceListModel.parameterId == PriceListModel1.parameterId) {
                        cell.select = YES;
                        [self.goodsListArray replaceObjectAtIndex:idx withObject:goodsListModel];
                    }
                }
            };
        }];
        cell.goodsListModel = goodsListModel;
        
    } else {
        HJBoxListModel *boxListModel = self.shopCartModel.boxList[indexPath.row];
        [self.boxListArray enumerateObjectsUsingBlock:^(HJBoxListModel  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.goodsId == boxListModel.goodsId) {
                
                if (obj.priceList.count == 2 && boxListModel.priceList.count == 2) {
                    cell.select = YES;
                    [self.boxListArray replaceObjectAtIndex:idx withObject:boxListModel];
                    
                } else if (obj.priceList.count == 1 && boxListModel.priceList.count == 1) {
                    HJBoxPriceListModel *boxPriceListModel = obj.priceList[0];
                    HJBoxPriceListModel *boxPriceListModel1 = boxListModel.priceList[0];
                    
                    if (boxPriceListModel.parameterId == boxPriceListModel1.parameterId) {
                        cell.select = YES;
                        [self.boxListArray replaceObjectAtIndex:idx withObject:boxListModel];
                    }
                }
            };
        }];
        cell.boxListModel = boxListModel;
    }
    return cell;
}

#pragma mark - Table view delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return kShoppingCartHeaderViewHeight;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return kShoppingCartListCellHeight;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    HJShoppingCartListHeaderView *headerView = [HJShoppingCartListHeaderView lh_createByFrame:CGRectMake(0, 0, kScreenWidth, kShoppingCartHeaderViewHeight)];
    headerView.tag = section;
    headerView.delegate = self;
    if (section == 0 && self.shopCartModel.goodsList.count) {
        headerView.select = self.goodsAllSelect;
        headerView.myContainerLabel.hidden = YES;
        
    } else if (section == 0 && self.shopCartModel.boxList.count){
        headerView.select = self.boxAllSelect;
        headerView.myContainerLabel.hidden = NO;
        
    } else {
        headerView.select = self.boxAllSelect;
        headerView.myContainerLabel.hidden = NO;
    }
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

#pragma mark - Actions

- (void)settleAction {
    
    if (!(self.goodsListArray.count || self.boxListArray.count)) {
        [SVProgressHUD showInfoWithStatus:@"请选择商品"];
        return;
    }
    
    
    HJSureOrderVC *sureOrderVC = [HJSureOrderVC new];
    sureOrderVC.shopCartArray = self.goodsListArray.mutableCopy;
    sureOrderVC.boxArray = self.boxListArray.mutableCopy;
    sureOrderVC.goodsTotalPrice = self.settleBar.totalCashLabel.text;
    [self.navigationController lh_pushVC:sureOrderVC];
    
    [self.goodsListArray removeAllObjects];
    [self.boxListArray removeAllObjects];
    
    self.boxAllSelect = NO;
    self.goodsAllSelect = NO;
}

- (void)editingShoopingCart:(UIButton *)rightButton
{
    rightButton.tag = !rightButton.tag;
    if (rightButton.tag) {
        [rightButton setTitle:@"完成" forState:UIControlStateNormal];
        [self.settleBar removeFromSuperview];
        [self.view addSubview:self.deleteBar];
        self.editing = YES;
        
    } else {
        [rightButton setTitle:@"编辑" forState:UIControlStateNormal];
        [self.view addSubview:self.settleBar];
        [self.deleteBar removeFromSuperview];
        self.editing = NO;
        
        NSMutableArray *goodsListArray = [NSMutableArray arrayWithArray:self.shopCartModel.goodsList];
        NSMutableArray *boxListArray = [NSMutableArray arrayWithArray:self.shopCartModel.boxList];
        //遍历找出总数为0的商品，并进行移除
        NSMutableArray *editGoodsListArray = [NSMutableArray array];
        [goodsListArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HJGoodsListModell *goodsListModel = obj;
            
            __block NSInteger totalGoodsCount = 0;
            [goodsListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HJPriceListModel *priceListModel = obj;
                totalGoodsCount += priceListModel.count;
            }];
            
            if (totalGoodsCount > 0) {
                
                [editGoodsListArray addObject:goodsListModel];
            }
            
        }];
        
        NSMutableArray *editBoxListArray = [NSMutableArray array];
        [boxListArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HJBoxListModel *boxListModel = obj;
            __block NSInteger totalGoodsCount = 0;

            [boxListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HJBoxPriceListModel *boxPriceListModel = obj;
                
                totalGoodsCount += boxPriceListModel.count;
                
            }];
            
            if (totalGoodsCount > 0) {
                
                [editBoxListArray addObject:boxListModel];
            }
        }];
        
        [self editBrandRequestWithGoodsListArray:editGoodsListArray boxListArray:editBoxListArray];
    }
    
    [self.tableView reloadData];
}

- (void)allSelectAction
{
    if (self.deleteBar.select) {
        self.goodsAllSelect = YES;
        self.boxAllSelect = YES;
        [self.goodsListArray removeAllObjects];
        
        for (int i = 0; i<self.shopCartModel.goodsList.count; i++) {
            [self.goodsListArray addObject:self.shopCartModel.goodsList[i]];
        }
        
        [self.boxListArray removeAllObjects];
        for (int i = 0; i<self.shopCartModel.boxList.count; i++) {
            [self.boxListArray addObject:self.shopCartModel.boxList[i]];
        }
        
    } else {
        self.goodsAllSelect = NO;
        self.boxAllSelect = NO;
        [self.goodsListArray removeAllObjects];
        [self.boxListArray removeAllObjects];
    }
    [self refreshTotalCash];
    [self.tableView reloadData];
}

- (void)deleteShoppingCartAction
{
    HJExitLoginView *WarnView = [HJExitLoginView exitLoginView];
    WarnView.warnLabel.text = [NSString stringWithFormat:@"您确定删除这%ld种商品吗？", self.goodsListArray.count + self.boxListArray.count];
    [self.view addSubview:WarnView];
    
    WarnView.certanBlock = ^{
        
        [self.goodsListArray enumerateObjectsUsingBlock:^(HJGoodsListModell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self.shopCartModel.goodsList containsObject:obj]) {
                [self.shopCartModel.goodsList removeObject:obj];
            }
        }];
        
        [self.boxListArray enumerateObjectsUsingBlock:^(HJBoxListModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if ([self.shopCartModel.boxList containsObject:obj]) {
                [self.shopCartModel.boxList removeObject:obj];
            }
        }];
        
        [self.goodsListArray removeAllObjects];
        [self.boxListArray removeAllObjects];
        self.goodsAllSelect = NO;
        self.boxAllSelect = NO;
        [self editBrandRequestWithGoodsListArray:self.shopCartModel.goodsList boxListArray:self.shopCartModel.boxList];
    };
}

#pragma mark - Methods

- (void)refreshDeleteBarButton
{
    if (self.shopCartModel.goodsList.count && self.shopCartModel.boxList.count) {
        if (self.goodsAllSelect && self.boxAllSelect) {
            self.deleteBar.select = YES;
        }
    } else if (self.goodsAllSelect || self.boxAllSelect) {
        self.deleteBar.select = YES;
    }
}

- (void)setSettleBarAndrightBarButtonItem
{
    if (!self.shopCartModel.goodsList.count && !self.shopCartModel.boxList.count) {
        self.settleBar.hidden = YES;
        self.rightButton.hidden = YES;
        self.deleteBar.hidden = YES;
    } else {
        self.settleBar.hidden = NO;
        self.rightButton.hidden = NO;
        self.deleteBar.hidden = NO;
    }
}

- (void)refreshTotalCash
{
    self.totalCash = 0;
    __block BOOL haveSpeicalGoods = NO;
    WEAK_SELF()
    [self.goodsListArray enumerateObjectsUsingBlock:^(HJGoodsListModell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.isSpecial) {
            haveSpeicalGoods = YES;
        }
        
        if (obj.priceList.count) {
            
            [obj.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                HJPriceListModel *priceListModel = obj1;
                weakSelf.totalCash = weakSelf.totalCash + [priceListModel.currentPrice floatValue] * priceListModel.count;
            }];
        }
    }];

    [self.boxListArray enumerateObjectsUsingBlock:^(HJBoxListModel  *_Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (obj.isSpecial) {
            haveSpeicalGoods = YES;
        }
        if (obj.priceList.count) {
            
            [obj.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj1, NSUInteger idx, BOOL * _Nonnull stop) {
                
                HJBoxPriceListModel *boxPriceListModel = obj1;
                weakSelf.totalCash = weakSelf.totalCash + [boxPriceListModel.currentPrice floatValue] * boxPriceListModel.count;
            }];
        }
    }];
    
    if (haveSpeicalGoods) {
        self.settleBar.totalCashLabel.text = @"以线下结算为准";
        
    } else {
        self.settleBar.totalCashLabel.text = [NSString stringWithFormat:@"¥%.2f", self.totalCash];
    }
    
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJEditBrandAPI class]]) {
        [self getShoppingCartRequest];
    }
}

- (void)netWorkRequestSuccessDealWithResponseObject:(id)responseObject
{
    if ([responseObject isKindOfClass:[HJShopCartBrandAPI class]]) {
        HJShopCartBrandAPI *api = responseObject;
        self.shopCartModel = api.data;
        [self setSettleBarAndrightBarButtonItem];
        [self.tableView reloadData];
    }
}

#pragma mark - HJShoppingCartListHeaderViewDelegate
- (void)ShoppingCartListHeaderViewClickAllSelectButton:(HJShoppingCartListHeaderView *)headerView
{
    if (headerView.tag == 0 && headerView.select) {
        if (self.shopCartModel.goodsList.count) {
            self.goodsAllSelect = YES;
            [self.goodsListArray removeAllObjects];
            
            for (int i = 0; i<self.shopCartModel.goodsList.count; i++) {
                [self.goodsListArray addObject:self.shopCartModel.goodsList[i]];
            }
        } else if (self.shopCartModel.boxList.count) {
            self.boxAllSelect = YES;
            [self.boxListArray removeAllObjects];
            for (int i = 0; i<self.shopCartModel.boxList.count; i++) {
                [self.boxListArray addObject:self.shopCartModel.boxList[i]];
            }
        }
        
    } else if (headerView.tag == 0 && headerView.select == NO){
        if (self.shopCartModel.goodsList.count) {
            self.goodsAllSelect = NO;
            self.deleteBar.select = NO;
            [self.goodsListArray removeAllObjects];
        } else if (self.shopCartModel.boxList.count) {
            self.boxAllSelect = NO;
            self.deleteBar.select = NO;
            [self.boxListArray removeAllObjects];
        }
    }
    
    if (headerView.tag == 1 && headerView.select) {
        self.boxAllSelect = YES;
        [self.boxListArray removeAllObjects];
        for (int i = 0; i<self.shopCartModel.boxList.count; i++) {
            [self.boxListArray addObject:self.shopCartModel.boxList[i]];
        }
        
    } else if (headerView.tag == 1 && headerView.select == NO) {
        self.boxAllSelect = NO;
        self.deleteBar.select = NO;
        [self.boxListArray removeAllObjects];
    }
    [self refreshTotalCash];
    [self refreshDeleteBarButton];
    [self.tableView reloadSection:headerView.tag withRowAnimation:UITableViewRowAnimationNone];
}

#pragma mark - HJShoppingCartListCellDelegate
- (void)shoppingCartListCellClickSelectButton:(HJShoppingCartListCell *)HJShoppingCartListCell
{
    if (HJShoppingCartListCell.select && HJShoppingCartListCell.goodsListModel) {
        [self.goodsListArray addObject:HJShoppingCartListCell.goodsListModel];
        
        self.goodsAllSelect = YES;
        [self.shopCartModel.goodsList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![self.goodsListArray containsObject:obj]) {
                self.goodsAllSelect = NO;
            }
        }];
        
    } else if (!HJShoppingCartListCell.select && HJShoppingCartListCell.goodsListModel) {
        [self.goodsListArray removeObject:HJShoppingCartListCell.goodsListModel];
        self.goodsAllSelect = NO;
        self.deleteBar.select = NO;
        
    } else if (HJShoppingCartListCell.select && HJShoppingCartListCell.boxListModel) {
        [self.boxListArray addObject:HJShoppingCartListCell.boxListModel];

        self.boxAllSelect = YES;
        [self.shopCartModel.boxList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            if (![self.boxListArray containsObject:obj]) {
                self.boxAllSelect = NO;
            }
        }];
        
    } else if (!HJShoppingCartListCell.select && HJShoppingCartListCell.boxListModel) {
        [self.boxListArray removeObject:HJShoppingCartListCell.boxListModel];
        self.boxAllSelect = NO;
        self.deleteBar.select = NO;
    }
    [self refreshTotalCash];
    [self refreshDeleteBarButton];
    [self.tableView reloadData];
}

- (void)shoppingCartListCellClicAddOrReduceButton:(HJShoppingCartListCell *)shoppingCartListCell
{
    if (shoppingCartListCell.boxNumberLabel.text.integerValue+shoppingCartListCell.bagNumberLabel.text.integerValue == 0) {
        //
        
        
    }
    
    [self refreshTotalCash];
}

#pragma mark - Networking Request

- (void)getShoppingCartRequest {
    [[[HJShopCartBrandAPI shopCartBrand] netWorkClient] postRequestInView:self.view networkRequestSuccessDataHandler:self];
}

- (void)editBrandRequestWithGoodsListArray:(NSMutableArray *)goodsListArray boxListArray:(NSMutableArray *)boxListArray {
    
    [[[HJEditBrandAPI editBrandWithGoodsList:[HJRequestParameterListModel parameterGoodsListStringFromGoodsListModelArray:goodsListArray] boxList:[HJRequestParameterListModel parameterGoodsListStringFromBoxListModelArray:boxListArray]] netWorkClient] postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

#pragma mark - Setter&Getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [UITableView lh_tableViewWithFrame:CGRectMake(0, STATUS_NAV_HEIGHT, kScreenWidth, kScreenHeight - STATUS_NAV_HEIGHT - TABBAR_HEIGHT - kShoppingCartSettleBarHeight) tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
    }
    return _tableView;
}

- (HJShoppingCartSettleBar *)settleBar {
    if (!_settleBar) {
        
        _settleBar = [HJShoppingCartSettleBar lh_createByFrame:CGRectMake(0, kScreenHeight - TABBAR_HEIGHT - kShoppingCartSettleBarHeight, kScreenWidth, kShoppingCartSettleBarHeight)];
        [_settleBar.settleButton addTarget:self action:@selector(settleAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _settleBar;
}

- (HJShoppingCartDeleteBar *)deleteBar
{
    if (!_deleteBar) {
        _deleteBar = [HJShoppingCartDeleteBar lh_createByFrame:CGRectMake(0, kScreenHeight - TABBAR_HEIGHT - kShoppingCartDeleteBarHeight, kScreenWidth, kShoppingCartDeleteBarHeight)];
        [_deleteBar.deleteButton addTarget:self action:@selector(deleteShoppingCartAction) forControlEvents:UIControlEventTouchUpInside];
        [_deleteBar.allSelectButton addTarget:self action:@selector(allSelectAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _deleteBar;
}

- (UIButton *)rightButton
{
    if (_rightButton == nil) {
        _rightButton = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, 40, 30) target:self action:@selector(editingShoopingCart:) title:@"编辑" titleColor:kWhiteColor font:FONT(16) backgroundColor:kClearColor];
        _rightButton.tag = 0;
    }
    return _rightButton;
}

- (NSMutableArray *)goodsListArray
{
    if (!_goodsListArray) {
        _goodsListArray = [NSMutableArray array];
    }
    return _goodsListArray;
}

- (NSMutableArray *)boxListArray
{
    if (!_boxListArray) {
        _boxListArray = [NSMutableArray array];
    }
    return _boxListArray;
}
@end
