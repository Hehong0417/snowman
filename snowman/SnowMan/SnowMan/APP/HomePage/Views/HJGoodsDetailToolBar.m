//
//  HJGoodsDetailToolBar.m
//  Apws
//
//  Created by zhipeng-mac on 15/12/24.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "HJGoodsDetailToolBar.h"
#import "XYQButton.h"

NSString * const kJoinGoodsOrder = @"加入购物车";
NSString * const kBuyRightNow = @"立即订购";

@interface HJGoodsDetailToolBar (SelfManager)

- (void)selfManagerCollectGoodsWithSuccessBlock:(voidBlock)success;

- (void)selfManagerCancelCollectGoodsWithSuccessBlock:(voidBlock)success;

@end

@implementation HJGoodsDetailToolBar (SelfManager)

- (void)selfManagerCollectGoodsWithSuccessBlock:(voidBlock)success {
}

- (void)selfManagerCancelCollectGoodsWithSuccessBlock:(voidBlock)success {
    
}

@end

@interface HJGoodsDetailToolBar ()

@property (strong, nonatomic) XYQButton *collectionButton;
@property (strong, nonatomic) XYQButton *customerServiceButton;

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet UILabel *goodsTotalPriceLabel;

@end

@implementation HJGoodsDetailToolBar

- (void)awakeFromNib {
    
    self.collectionButton = [XYQButton ButtonWithFrame:CGRectMake(0, 0, self.contentView.lh_width/6.0, self.contentView.lh_height) imgaeName:@"ic_b17_shoucang_pre" titleName:@"收藏" contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes  fontAttributesWithFontColor:kFontGrayColor fontsize:12] aligmentType:AligmentTypeCenter tapAction:^(XYQButton *button) {
        //收藏商品
        if (!button.selected) {
          
            [self selfManagerCollectGoodsWithSuccessBlock:^{
                
                button.selected = !button.selected;
            }];
        }else {
        //取消收藏商品
            [self selfManagerCancelCollectGoodsWithSuccessBlock:^{
                
                button.selected = !button.selected;
            }];
        }
        
    }];
    
    [self.collectionButton setImage:[UIImage imageNamed:@"ic_b5_xingxing_pre"] forState:UIControlStateSelected];
    
//    [self.contentView addSubview:self.collectionButton];
    
    self.customerServiceButton = [XYQButton ButtonWithFrame:CGRectMake(self.collectionButton.lh_width, 0, self.contentView.lh_width/6.0, self.contentView.lh_height) imgaeName:@"ic_b3_kefu" titleName:@"客服" contentType:TopImageBottomTitle buttonFontAttributes:[FontAttributes  fontAttributesWithFontColor:kFontGrayColor fontsize:12] aligmentType:AligmentTypeCenter tapAction:^(XYQButton *button) {
        
    }];
//    [self.contentView addSubview:self.customerServiceButton];
}

- (void)setGoodsTotalPrice:(NSString *)goodsTotalPrice {
    
    _goodsTotalPrice = goodsTotalPrice;
    
    self.goodsTotalPriceLabel.text = goodsTotalPrice;
    
}

- (IBAction)joinStockOrderAction:(id)sender {
    
    self.tapHandler(kJoinGoodsOrder);
}

- (IBAction)buyRightNowAction:(id)sender {
  
    self.tapHandler(kBuyRightNow);
}


@end
