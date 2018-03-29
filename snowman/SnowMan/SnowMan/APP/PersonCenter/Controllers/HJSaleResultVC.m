//
//  HJSaleResultVC.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSaleResultVC.h"
#import "HJSaleResultView.h"
#import "HJTabBarController.h"

@interface HJSaleResultVC ()
@property (nonatomic, strong) HJSaleResultView *saleResultView;
@end

@implementation HJSaleResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.resultType == HJResultTypeSale) {
        self.title = @"申请订单";
    } else if (self.resultType == HJResultTypePurchase) {
        self.title = @"支付成功";
    } else if (self.resultType == HJResultTypeWish) {
        self.title = @"许愿成功";
    } else if (self.resultType == HJResultTypeDelete) {
        self.title = @"删除订单";
    } else if (self.resultType == HJResultTypeCertain) {
        self.title = @"完成订单";
    } else if (self.resultType == HJResultTypePaySuccess) {
        self.title = @"支付成功";
    }
    [self.view addSubview:self.saleResultView];
}

#pragma mark - Action

- (void)backHomeAction
{
    if (self.resultType == HJResultTypeWish) {
        [self.saleResultView removeFromSuperview];
        [self.navigationController lh_popVC];
        
    } else {
        [self.saleResultView removeFromSuperview];
        [UIApplication sharedApplication].keyWindow.rootViewController = [HJTabBarController new];
    }
}

#pragma mark - setting & getting

- (HJSaleResultView *)saleResultView
{
    if (!_saleResultView) {
        _saleResultView = [HJSaleResultView saleResultView];
        _saleResultView.orderNoLabel.text = [NSString stringWithFormat:@"订单编号：%@", self.orderNo];
        if (self.resultType == HJResultTypeCertain) {
            _saleResultView.score = self.score;
        }
        _saleResultView.resultType = self.resultType;
        [_saleResultView.backButton addTarget:self action:@selector(backHomeAction) forControlEvents:UIControlEventTouchUpInside];
    }
    return _saleResultView;
}

@end
