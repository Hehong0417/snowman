//
//  HJGoodsDetailVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGoodsDetailVC.h"
#import "HJGoodsDetailHeaderView.h"
#import "HJGoodsDetailsAPI.h"
#import "HJGoodsIntroduceAPI.h"
#import "HJGoodsDetailToolBar.h"
#import "HJStandardValueAlertView.h"
#import "HJSelectStandardValueModel.h"
#import "HJWebViewTCell.h"
#import "HJJoinShopCartAPI.h"
#import "HJRequestParameterIdModel.h"
#import "HJGoodsCommentAPI.h"
#import "HJJoinBoxAPI.h"
#import "HJSureOrderVC.h"
#import "HJGoodsCommentCell.h"

//
typedef NS_ENUM(NSUInteger, HJGoodsDetailSelectedType) {
    HJGoodsDetailSelectedTypeDetail = 0,
    HJGoodsDetailSelectedTypeComment,
};

typedef NS_ENUM(NSUInteger, HJGoodsDetailHandlerType) {
    HJGoodsDetailHandlerTypeNone = 0,
    HJGoodsDetailHandlerTypeJoinBox,
    HJGoodsDetailHandlerTypeJoinShopCart,
    HJGoodsDetailHandlerTypeBuyRightNow,
};


@interface HJGoodsDetailVC () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HJGoodsDetailHeaderView *headerView;
@property (nonatomic, strong) HJGoodsDetailToolBar *toolBar;
@property (nonatomic, strong) HJGoodsIntroduceModel *goodsIntroduceModel;
@property (nonatomic, strong) NSString *selectedStandardString;
@property (nonatomic, strong) NSString *goodsDetailUrlStr;
@property (nonatomic, strong) NSArray <HJSelectStandardValueModel *>*selectedStandardModels;
@property (nonatomic, assign) HJGoodsDetailSelectedType selectedType;
@property (nonatomic, strong) UIView *selectedHeaderView;
@property (nonatomic, strong) UIButton *goodsDetailButton;
@property (nonatomic, strong) UIButton *goodsCommentButton;
@property (nonatomic, strong) UIButton *backButton;
@property (nonatomic, assign) CGFloat webViewHeight;
@property (nonatomic, assign) HJGoodsDetailHandlerType handlerType;

@end

@implementation HJGoodsDetailVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"商品详情";
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.toolBar];
    [self.view addSubview:self.backButton];
    
    [self goodsIntroduceRequest];
}

#pragma mark - LayoutSubViews

- (void)viewDidLayoutSubviews {
    
    self.tableView.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT - TABBAR_HEIGHT);
    self.headerView.frame = CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize(192)+128);
    
    self.tableView.tableHeaderView = self.headerView;

}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    if ([responseObject isKindOfClass:[HJGoodsIntroduceAPI class]]) {
        
        HJGoodsIntroduceAPI *apiModel = responseObject;
        self.headerView.goodsIntroduceModel = apiModel.data;
        //
        [self.headerView.isBoxButton addTarget:self action:@selector(addBoxAction) forControlEvents:UIControlEventTouchUpInside];
        
        //
        self.goodsIntroduceModel = apiModel.data;
        
        self.toolBar.goodsTotalPrice = self.goodsIntroduceModel.isSpecial ? @"以线下结算为准" : @"¥0.00";

        [self.goodsIntroduceModel.standardList enumerateObjectsUsingBlock:^(HJGoodsIntroduceStandardlistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            DDLogInfo(@"0000000000%@,%ld",obj.standardName,obj.standardSize);
            
        }];
        
        
        
        [self.tableView reloadData];
    }
    
    //
    if ([responseObject isKindOfClass:[HJJoinShopCartAPI class]]) {
        
        [SVProgressHUD showSuccessWithStatus:@"恭喜您，商品已成功添加至购物车"];
    }
    
    //
    if ([responseObject isKindOfClass:[HJGoodsCommentAPI class]]) {
        
        //
        HJGoodsCommentAPI *api = responseObject;
        
        self.tableView.refreshDataSource = api.data.mutableCopy;
        
        [self.tableView reloadData];
    }
    
    //
    if ([responseObject isKindOfClass:[HJJoinBoxAPI class]]) {
        
        //
        [SVProgressHUD showSuccessWithStatus:@"恭喜您，商品已添加至货箱"];
        [self setGoodsDetailHeaderView];
        [self goodsIntroduceRequest];
    }
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 1 && self.selectedType == HJGoodsDetailSelectedTypeComment) {
        
        return tableView.refreshDataSource.count;
    }
    
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 0) {
        
    UITableViewCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[UITableViewCell className]];
    
    cell.textLabel.text = [[[@"已选择：" stringByAppendingString:self.goodsIntroduceModel.goodsName?:kEmptySrting]stringByAppendingString:@"    "]stringByAppendingString:self.selectedStandardString?:@"请选择规格"];
    cell.textLabel.font = FontNormalSize;
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    UIView *lineView = [UIView lh_viewWithFrame:CGRectMake(0, 43, kScreenWidth, 1) backColor:kLineLightColor];
    [cell.contentView addSubview:lineView];
    
    return cell;
        
    } else {
        
        switch (self.selectedType) {
            case HJGoodsDetailSelectedTypeDetail:
            {
                HJWebViewTCell *cell  = [tableView lh_dequeueReusableCellWithCellClassName:[HJWebViewTCell className]];
                cell.urlStr = [HJGoodsDetailsAPI goodsDetail_goodsId:self.goodsId].appendedUrlString;
                WEAK_SELF();
                [cell.webView lh_setFrameAdaptWebViewContent:^(CGRect frame,UIWebView *webView) {
                    //
                    if (weakSelf.webViewHeight != frame.size.height) {
                        
                        weakSelf.webViewHeight = frame.size.height;
                        [weakSelf.tableView reloadData];
                        
                    }
                    
                }];
                
                
                return cell;
                
            }
                break;
            case HJGoodsDetailSelectedTypeComment:
            {
                HJGoodsCommentCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[HJGoodsCommentCell className]];
                HJGoodsCommentModel *goodsCommentModel = tableView.refreshDataSource[indexPath.row];
                cell.goodsCommentModel = goodsCommentModel;
                
                //添加分割线
                if (![cell.contentView viewWithTag:1001]) {
                    
                    UIView *lineView = [UIView lh_viewWithFrame:CGRectMake(0, goodsCommentModel.hasCommentImageList? 169 : 119, kScreenWidth, 1) backColor:kLineLightColor];
                    lineView.tag = 1001;
                    
                    [cell.contentView addSubview:lineView];
                } else {
                    
                    UIView *lineView = [cell.contentView viewWithTag:1001];
                    
                    lineView.frame = CGRectMake(0, goodsCommentModel.hasCommentImageList? 169 : 119, kScreenWidth, 1);
                  
                }
                
                return cell;
            }
                break;
        }
        
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
        
        return 60;
    }
    
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    
    return 0.1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (indexPath.section == 1 && self.selectedType == HJGoodsDetailSelectedTypeComment) {
        
        HJGoodsCommentModel *goodsCommentModel = tableView.refreshDataSource[indexPath.row];
        
        return goodsCommentModel.hasCommentImageList?170:120;
    }
    
    if (indexPath.section == 1 && self.selectedType == HJGoodsDetailSelectedTypeDetail) {
        
        return self.webViewHeight;
    }
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (section == 1) {
    
        
        return self.selectedHeaderView;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.row == 0 && indexPath.section == 0) {

        [self showStandardValueAlertViewAction];
    }
}

#pragma mark - Actions

- (void)backAction
{
    [self.navigationController lh_popVC];
}

- (void)goodsDetailAction:(UIButton *)button {
    
    button.selected = button.selected?:!button.selected;
    
    self.goodsCommentButton.selected = !button.selected;
    
    self.selectedType = HJGoodsDetailSelectedTypeDetail;
    
    [self.tableView reloadData];
}

- (void)goodsCommentAction:(UIButton *)button  {
    
    button.selected = button.selected?:!button.selected;
    
    self.goodsDetailButton.selected = !button.selected;
    
    self.selectedType = HJGoodsDetailSelectedTypeComment;
    
    [self goodsCommentRequest];
}

- (void)addBoxAction {
    
    self.handlerType = HJGoodsDetailHandlerTypeJoinBox;
    
    if (self.selectedStandardModels.count == 0) {
        
        [self showStandardValueAlertViewAction];
        
        return;
    }
    
    [self joinBoxRequest];
}

- (void)joinShopCartAction {
    
    self.handlerType = HJGoodsDetailHandlerTypeJoinShopCart;

    if (self.selectedStandardModels.count == 0) {
        
        [self showStandardValueAlertViewAction];
        
        return;
    }
    
    [self joinShopCartRequestWithGoodsId:self.goodsId parameterList:[HJRequestParameterIdModel parameterListStringFromStandardValueModelArray:self.selectedStandardModels]];
}

- (void)buyRightNowAction {
    
    self.handlerType = HJGoodsDetailHandlerTypeBuyRightNow;
    
    if (self.selectedStandardModels.count == 0) {
        
        [self showStandardValueAlertViewAction];
        
        return;
    }
    
    HJSureOrderVC *sureOrderVC = [HJSureOrderVC new];
    sureOrderVC.goodsIntroduceModel = self.goodsIntroduceModel;
    sureOrderVC.selectedStandardModels = self.selectedStandardModels;
    sureOrderVC.goodsTotalPrice = self.goodsIntroduceModel.isSpecial ? @"以线下结算为准" : self.toolBar.goodsTotalPrice;
    [self.navigationController lh_pushVC:sureOrderVC];
}

- (void)showStandardValueAlertViewAction {
    
    HJStandardValueAlertView *standardAlertView = [HJStandardValueAlertView new];
    standardAlertView.goodsIntroduceModel = self.goodsIntroduceModel;
    standardAlertView.goodsPrice = self.headerView.goodsPrice;
    standardAlertView.formerGoodsPrice = self.headerView.formerGoodsPrice;
    
    //点击规格弹框确定按钮
    standardAlertView.sureHandler = ^(NSArray *selectStandards) {
        
        NSMutableArray *selectedStandardStrings = [NSMutableArray array];
        //选中多少规格商品计算
        
        __block CGFloat totalGoodsPrice;
        
        
        [selectStandards enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HJSelectStandardValueModel *standardValueModel = obj;
            NSMutableDictionary *standValueDict = standardValueModel.mj_keyValues.mutableCopy;
            //移除参数Id显示
            [standValueDict removeObjectForKey:@"parameterId"];
            [standValueDict removeObjectForKey:@"goodsCount"];
            [standValueDict removeObjectForKey:@"unitGoodsPrice"];
            [standValueDict removeObjectForKey:@"standardType"];
            [standValueDict removeObjectForKey:@"unitGoodsName"];
            
            NSMutableArray *standValueArray = standValueDict.allValues.mutableCopy;
            
            if (!self.goodsIntroduceModel.isSpecial) {
                
                HJGoodsIntroduceStandardlistModel *standardlistModel = [self.goodsIntroduceModel.standardList objectOrNilAtIndex:0];
                
                if (standardlistModel.unitName.length == 0) {
                    
                    [standValueArray exchangeObjectAtIndex:0 withObjectAtIndex:1];
                }
            }
            
            NSMutableArray *appendingStandardValueArray = [NSMutableArray array];
            
            [standValueArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSString *standardString = obj;
                
                [appendingStandardValueArray addObject:[standardString lh_appendingStringWithPrefixString:@"\"" suffixString:@"\""]];
                
            }];
            
            NSString *standardValue = [appendingStandardValueArray componentsJoinedByString:@","];
            
            [selectedStandardStrings addObject:standardValue];
            
            //商品总价计算
            totalGoodsPrice += standardValueModel.goodsCount.integerValue * standardValueModel.unitGoodsPrice.floatValue;
            
        }];
        
        //选中规格参数赋值属性
        self.selectedStandardModels = selectStandards;
        
        self.selectedStandardString = [selectedStandardStrings componentsJoinedByString:@"  "];
        
        [self.tableView reloadData];
        
        //商品总价赋值
        self.toolBar.goodsTotalPrice = self.goodsIntroduceModel.isSpecial ? @"以线下结算为准" : [NSString stringWithFormat:@"¥%.2f",totalGoodsPrice];
        
        //点击确定执行相应操作，选择规格存在才进行操作
        if (self.selectedStandardModels.count > 0) {
            
        switch (self.handlerType) {
            case HJGoodsDetailHandlerTypeJoinBox: {
                {
                    //
                    [self joinBoxRequest];
                }
                break;
            }
            case HJGoodsDetailHandlerTypeJoinShopCart: {
                {
                    
                    //
                    [self joinShopCartAction];
                }
                break;
            }
            case HJGoodsDetailHandlerTypeBuyRightNow: {
                {
                    
                    //
                    [self buyRightNowAction];
                }
                break;
            }

        }
            
        }
    };
    
    [standardAlertView showFromBottomAnimated:YES];
}

#pragma mark - Methods
- (void)setGoodsDetailHeaderView
{
    [self.headerView.isBoxButton setImage:kImageNamed(@"ic_b10_01_pre") forState:UIControlStateNormal];
    self.headerView.joinBoxLabel.text = @"已进入货箱";
}


#pragma mark - Networking Request

- (void)goodsIntroduceRequest {
    
    [[[HJGoodsIntroduceAPI goodsIntroduce_goodsId:self.goodsId]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)goodsDetailsRequest {
    
    [[[HJGoodsDetailsAPI goodsDetail_goodsId:self.goodsId]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)joinShopCartRequestWithGoodsId:(NSString *)goodsId parameterList:(NSString *)parameterList {
    
    [[[HJJoinShopCartAPI joinShopCart_goodsId:goodsId parameterList:parameterList]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)goodsCommentRequest {
    
    [[[HJGoodsCommentAPI goodsComment_goodsId:self.goodsId page:@1 rows:@20]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)joinBoxRequest {
    
    [[[HJJoinBoxAPI joinBox_goodsId:self.goodsId parameterList:[HJRequestParameterIdModel parameterListStringFromStandardValueModelArray:self.selectedStandardModels]]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
    
}

#pragma mark - Setter&Getter

- (UITableView *)tableView {
    
    if (!_tableView) {
        
        _tableView = [UITableView lh_tableViewWithFrame:CGRectZero tableViewStyle:UITableViewStyleGrouped delegate:self dataSourec:self];
        _tableView.backgroundColor = kVCBackGroundColor;
        [_tableView lh_registerClassFromCellClassName:[UITableViewCell className]];
        [_tableView lh_registerNibFromCellClassName:[HJWebViewTCell className]];
        [_tableView lh_registerNibFromCellClassName:[HJGoodsCommentCell className]];
    }
    
    return _tableView;
}

- (HJGoodsDetailHeaderView *)headerView {
    
    if (!_headerView) {
        
        _headerView = [HJGoodsDetailHeaderView lh_createByFrame:CGRectZero];
    }
    
    return _headerView;
}

- (HJGoodsDetailToolBar *)toolBar {
    
    if (!_toolBar) {
        
        _toolBar = [[[NSBundle mainBundle]loadNibNamed:@"HJGoodsDetailToolBar" owner:self options:nil]firstObject];
        [_toolBar setFrame:CGRectMake(0, kScreenHeight-TABBAR_HEIGHT, SCREEN_WIDTH, TABBAR_HEIGHT)];
        WEAK_SELF();
        _toolBar.tapHandler = ^ (NSString *handlerType) {
            
            if ([handlerType isEqualToString:kJoinGoodsOrder]) {
                
                [weakSelf joinShopCartAction];
            }
            
            if ([handlerType isEqualToString:kBuyRightNow]) {
                
                [weakSelf buyRightNowAction];
            }
        };
    }
    
    return _toolBar;
}

- (UIView *)selectedHeaderView {
    
    if (!_selectedHeaderView) {
        
        UIView *headerView = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, 60) backColor:kVCBackGroundColor];
        
        UIButton *goodsDetailButton = [UIButton lh_buttonWithFrame:CGRectMake(0, 10, headerView.lh_width/2.0, headerView.lh_height-10) target:self action:@selector(goodsDetailAction:) title:@"商品详情" titleColor:kFontBlackColor font:FontBigSize backgroundColor:kWhiteColor];
        [goodsDetailButton setTitleColor:APP_COMMON_COLOR forState:UIControlStateSelected];
        goodsDetailButton.selected = YES;
        [headerView addSubview:goodsDetailButton];
        self.goodsDetailButton = goodsDetailButton;
        
        UIButton *goodsCommentButton = [UIButton lh_buttonWithFrame:CGRectMake(goodsDetailButton.lh_right, goodsDetailButton.lh_top, headerView.lh_width/2.0, goodsDetailButton.lh_height) target:self action:@selector(goodsCommentAction:) title:@"商品评论" titleColor:kFontBlackColor font:FontBigSize backgroundColor:kWhiteColor];
        [goodsCommentButton setTitleColor:APP_COMMON_COLOR forState:UIControlStateSelected];
        [headerView addSubview:goodsCommentButton];
        self.goodsCommentButton = goodsCommentButton;
        
        UIView *lineView = [UIView lh_viewWithFrame:CGRectMake(0, headerView.lh_height-1, headerView.lh_width, 1) backColor:kLineLightColor];
        [headerView addSubview:lineView];
        
        _selectedHeaderView = headerView;
    }
    
    return _selectedHeaderView;
}

- (UIButton *)backButton
{
    if (!_backButton) {
        _backButton = [UIButton lh_buttonWithFrame:CGRectMake(15, STATUSBAR_HEIGHT, 30, 30) target:self action:@selector(backAction) image:[UIImage imageNamed:@"ic_b12_fanhui"]];
    }
    return _backButton;
}

@end
