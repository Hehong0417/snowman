//
//  HJPersonCenterTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJPersonCenterTVC.h"
#import "HJPersonCenterHeaderView.h"
#import "HJMyIntegralVC.h"
#import "HJCommonIssueVC.h"
#import "HJSetTVC.h"
#import "HJMyOrderVC.h"
#import "HJEditPersonDataVC.h"
#import "HJSignAlertView.h"
#import "HJGetUserInfoAPI.h"
#import "HJCheckinAPI.h"

@interface HJPersonCenterTVC ()

@property (nonatomic, strong) HJPersonCenterHeaderView *personCenterHeaderView;

@end

@implementation HJPersonCenterTVC

#pragma mark - LifeCycle

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.automaticallyAdjustsScrollViewInsets = NO;

    
}

- (void)viewWillAppear:(BOOL)animated {
    
    [super viewWillAppear:animated];
    
    [self getUserInfoRequest];
}

#pragma mark - HJDataHandlerProtocol

- (void)netWorkCodeSuccessDealWithResponseObject:(id)responseObject {
    
    if ([responseObject isKindOfClass:[HJGetUserInfoAPI class]]) {
        
        HJGetUserInfoAPI *apiModel = responseObject;
        
        self.personCenterHeaderView.userInfoModel = apiModel.data;
    }
    
    //
    if ([responseObject isKindOfClass:[HJCheckinAPI class]]) {
        
        HJCheckinAPI *apiModel = responseObject;
        
        
        HJSignAlertView *alertView = [HJSignAlertView new];
        alertView.score = apiModel.data.dayScore;
        
        [alertView show];
        [self updateSignButton];
    }
}

#pragma mark - Actions

- (void)checkAllOrderAction:(UIButton *)button {
    
    HJMyOrderVC *orderVC = [HJMyOrderVC new];
    [self.navigationController pushViewController:orderVC animated:YES];
}

- (void)signAction:(UIButton *)button {
    
    [self checkinRequest];
}

#pragma mark - Methods

- (void)updateSignButton
{
    [self.personCenterHeaderView.signButton setTitle:@"已签到" forState:UIControlStateNormal];
}

- (void)goToOrderListBaseOnOrderButtonType:(HJOrderState)orderButtonType {
    
    HJMyOrderVC *myOrderVC = [HJMyOrderVC new];
    myOrderVC.orderType = orderButtonType;
    [self.navigationController lh_pushVC:myOrderVC];
    
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    switch (indexPath.row) {
        case 0:
        {
            HJMyIntegralVC *myIntegralVC = [HJMyIntegralVC new];
            [self.navigationController pushViewController:myIntegralVC animated:YES];
            
        }
            break;
        case 1:
        {
            HJCommonIssueVC *commonIssueVC = [HJCommonIssueVC new];
            [self.navigationController pushViewController:commonIssueVC animated:YES];
            
        }
            break;
        case 2:
        {
            HJSetTVC *setTVC = [HJSetTVC new];
            [self.navigationController pushViewController:setTVC animated:YES];          
        }
            break;

        default:
            break;
    }
}

#pragma mark - NewWorking Request

- (void)getUserInfoRequest {
    
    [[[HJGetUserInfoAPI getUserInfo]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}

- (void)checkinRequest {
    
    [[[HJCheckinAPI checkin]netWorkClient]postRequestInView:self.view networkCodeTypeSuccessDataHandler:self];
}


#pragma mark - Setter&Getter

- (NSArray *)groupTitles {
    
    return @[@[@"我的积分",
             @"常见问题",
             @"设置"]];
}

- (NSArray *)groupIcons {
    
    return @[@[@"ic_e1_06",
             @"ic_e1_07",
             @"ic_e1_08"]];
}

- (UIView *)tableHeaderView {
    
    HJPersonCenterHeaderView *personCenterHeaderView =  [HJPersonCenterHeaderView lh_createByFrame:CGRectMake(0, 0, SCREEN_WIDTH, WidthScaleSize(180)+116)];
    WEAK_SELF();
    personCenterHeaderView.selectOrderButtonAction = ^ (HJOrderState  orderButtonType) {
        
        [weakSelf goToOrderListBaseOnOrderButtonType:orderButtonType];
    };
    
    personCenterHeaderView.userInteractionEnabled = YES;
    [personCenterHeaderView.userIconButton bk_whenTouches:1 tapped:1 handler:^{
        
        HJEditPersonDataVC *editPersonDataVC = [HJEditPersonDataVC new];
        [self.navigationController lh_pushVC:editPersonDataVC];
    }];
    
    [personCenterHeaderView.signButton addTarget:self action:@selector(signAction:) forControlEvents:UIControlEventTouchUpInside];
    [personCenterHeaderView.checkAllOrderButton addTarget:self action:@selector(checkAllOrderAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIView *headerBgView = [UIView lh_viewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, personCenterHeaderView.lh_height+8) backColor:kVCBackGroundColor];
    
    [headerBgView addSubview:personCenterHeaderView];
    
    self.personCenterHeaderView = personCenterHeaderView;
    
    return headerBgView;
}

@end
