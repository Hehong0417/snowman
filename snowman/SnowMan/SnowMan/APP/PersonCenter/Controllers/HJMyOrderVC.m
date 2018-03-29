//
//  HJMyOrderVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMyOrderVC.h"
#import "YFViewPager.h"
#import "HJWaitPaidTVC.h"
#import "HJOrderListAPI.h"

static NSString * const kWaitPaidConstantString = @"待付款";
static NSString * const kWaitRecieveGoodsConstantString = @"待收货";
static NSString * const kFinishedConstantString = @"已完成";
static NSString * const kReturnOfGoodsConstantString = @"退换货";


@interface HJMyOrderVC ()

@property (nonatomic, strong) YFViewPager *orderTypeViewPager;//订单状态多选控件

@end

@implementation HJMyOrderVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.title = @"我的订单";
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self.view addSubview:self.orderTypeViewPager];
    
    
    [self.orderTypeViewPager didSelectedBlock:^(id viewPager, NSInteger index) {
        
        self.orderType = index;
        
        //
    }];
    
    //
    WEAK_SELF();
    self.orderTypeViewPager.finishedDraingAction = ^ {
        
        [weakSelf.orderTypeViewPager setSelectIndex:weakSelf.orderType];
        
    };
    
    //
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(changeOrderListSelectedStateNotification:) name:kNotification_ChangeMyOrderListSelectedOrderState object:nil];
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HJWaitPaidTVC *waitPaidTVC = obj;
        
        [waitPaidTVC.tableView.refreshHeader beginRefreshing];
        
    }];
    
}

- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]removeObserver:self];
}

#pragma mark - HJDataHandlerProtocol

#pragma mark - Actions



#pragma mark - Methods

- (HJWaitPaidTVC *)childOrderListTableViewControllerFromIndex:(NSInteger )index{
    
    return self.childViewControllers[index];
}

- (void)changeOrderListSelectedStateNotification:(NSNotification *)notification {
    
    NSNumber *orderState = notification.object;
    
    self.orderType = orderState.integerValue;
    
    [self.orderTypeViewPager setSelectIndex:self.orderType-2];

    HJWaitPaidTVC *waitPaidTVC = self.childViewControllers[self.orderType-2];
    [waitPaidTVC.tableView.refreshHeader beginRefreshing];
}

#pragma mark - Networking Request


#pragma mark - Setter&Getter

- (YFViewPager *)orderTypeViewPager {
    
    if (!_orderTypeViewPager) {
        
        NSArray * titleArray = @[kWaitPaidConstantString,kWaitRecieveGoodsConstantString,kFinishedConstantString,kReturnOfGoodsConstantString];
        
        for (int i = 0; i<4; i++) {
            
            HJWaitPaidTVC *waitPaidVC = [HJWaitPaidTVC new];
            HJOrderState orderType = i+1;
            //已完成状态是4
            if (i == 2) {
                
                orderType = HJOrderStateFinished;
            }
            if (i == 3) {
                
                orderType = HJOrderStateReturnOfGoods;
            }
            waitPaidVC.orderType = orderType;
            [self addChildViewController:waitPaidVC];
        }
        
        NSMutableArray * views = [NSMutableArray array];
        
        [self.childViewControllers enumerateObjectsUsingBlock:^(__kindof UIViewController * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            [views addObject:obj.view];
        }];
        
        YFViewPager * vc = [[YFViewPager alloc]initWithFrame:CGRectMake(0, 64, kScreenWidth, kScreenHeight-64) titles:titleArray views:views];
        vc.tabTitleColor = kWhiteColor;
        vc.tabSelectedTitleColor = kWhiteColor;
        vc.tabBgColor = APP_COMMON_COLOR;
        vc.tabSelectedBgColor = APP_COMMON_COLOR;
        vc.tabSelectedArrowBgColor = kWhiteColor;
        vc.showAnimation = YES;
        vc.showVLine = NO;
        
        _orderTypeViewPager = vc;
    }
    
    return _orderTypeViewPager;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
