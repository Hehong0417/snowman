//
//  HJSetTVC.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/14.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSetTVC.h"
#import "HJNavigationController.h"
#import "HJBaseLoginVC.h"
#import "HJExitLoginView.h"
#import "HJUser.h"

@interface HJSetTVC ()
@property (nonatomic, weak) UIButton *backButton;
@end

@implementation HJSetTVC


#pragma mark - LifeCycle

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = YES;
    self.title = @"设置";
    [self setupBackButton];
}

#pragma mark - Actions
- (void)backLoginAction
{
    HJExitLoginView *exitView = [HJExitLoginView exitLoginView];
    [self.view addSubview:exitView];
    exitView.certanBlock = ^{
        HJUser *user = [HJUser sharedUser];
        user.isLogin = NO;
        [user write];
        HJNavigationController *nav =[[HJNavigationController alloc]initWithRootViewController:[HJBaseLoginVC new]];
        [UIApplication sharedApplication].keyWindow.rootViewController = nav;
    };
}


#pragma mark - Methods



#pragma mark - HJDataHandlerProtocol


#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"tel://08336526651"]];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


#pragma mark - Setter&Getter

- (NSArray *)groupTitles {
    
    return @[@[@"联系客服"]];
}

- (NSArray *)groupDetials {
    
    return @[@[@"0663667890"]];

}

- (CGFloat)firstGroupSpacing {
    
    return 0.1;
}

- (void)setupBackButton
{
    UIButton *backButton = [UIButton lh_buttonWithFrame:CGRectMake(15, SCREEN_HEIGHT - 70 - self.navigationController.navigationBar.lh_height, SCREEN_WIDTH - 30, 35) target:self action:@selector(backLoginAction) title:@"退出登录" titleColor:kWhiteColor font:FONT(16) backgroundColor:RGB(253, 118, 48)];
    backButton.layer.cornerRadius = 3;
    [self.view addSubview:backButton];
}


@end
