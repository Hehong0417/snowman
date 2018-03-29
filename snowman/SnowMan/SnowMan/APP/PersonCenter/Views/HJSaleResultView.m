//
//  HJSaleResultView.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJSaleResultView.h"

@implementation HJSaleResultView

+ (instancetype)saleResultView
{
    return [[[NSBundle mainBundle] loadNibNamed:[self className] owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.frame = CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT);
    self.backButton.layer.cornerRadius = 3.0f;
    self.scoreLabel.hidden = YES;
}

- (void)setResultType:(HJResultType)resultType
{
    _resultType = resultType;
    if (resultType == HJResultTypeSale) {
        self.warnLabel.text = @"感谢您的信任与支持，我们会尽快联系您。";
        self.titleLabel.text = @"申请成功";
        [self.backButton setTitle:@"返回首页" forState:UIControlStateNormal];
        
    } else if (resultType == HJResultTypePurchase) {
        self.warnLabel.text = @"感谢您的信任与支持，我们会按时按照您的要求发货，请耐心等待我们的送货大哥送货";
        self.titleLabel.text = @"下单成功";
        [self.backButton setTitle:@"继续购物" forState:UIControlStateNormal];
        
    } else if (resultType == HJResultTypeWish) {
        self.warnLabel.text = @"恭喜您，您的心愿提交成功，我们将在最短的时间内审核您的需求，并在一定的时间内把您需要的商品上架";
        self.titleLabel.text = @"许愿成功";
        [self.backButton setTitle:@"继续许愿" forState:UIControlStateNormal];
        self.orderNoLabel.hidden = YES;
        
    } else if (resultType == HJResultTypeDelete) {
        self.warnLabel.text = @"感谢您的信任和支持，我们在以后的服务中，更为细心的服务您";
        self.titleLabel.text = @"删除成功";
        [self.backButton setTitle:@"返回首页" forState:UIControlStateNormal];
        self.orderNoLabel.hidden = YES;
        
    } else if (resultType == HJResultTypeCertain) {
        self.titleLabel.text = @"完成订单";
        if (self.score.length) {
            self.scoreLabel.hidden = NO;
            self.scoreLabel.text = [NSString stringWithFormat:@"恭喜获得%@积分", self.score];
        }
        self.warnLabel.text = @"感谢您的信任和支持，我们在将提供更细致的服务和急您所需的产品。如果有什么需要可以随时联系我们。";
        [self.backButton setTitle:@"返回首页" forState:UIControlStateNormal];
        
    } else if (resultType == HJResultTypePaySuccess) {
        self.titleLabel.text = @"支付成功";
        self.warnLabel.text = @"感谢您的信任与支持，我们会按时按照您的要求发货，请耐心等待我们的送货大哥送货";
        [self.backButton setTitle:@"返回首页" forState:UIControlStateNormal];
    }
}

@end
