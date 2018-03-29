//
//  HJGoodsDetailHeaderView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGoodsDetailHeaderView.h"
#import "HJConfigureStandardSizeModel.h"
#import "HJGoodsStandardPriceModel.h"

@interface HJGoodsDetailHeaderView ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsIconImageView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *areaLabel;
@property (weak, nonatomic) IBOutlet UILabel *brandLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *specailTagLabel;
@property (weak, nonatomic) IBOutlet UILabel *formerPriceLabel;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *specialTagLabelWidthCons;

@end

@implementation HJGoodsDetailHeaderView

- (void)awakeFromNib {
    
    [self setGoodsIntroduceModel:nil];
}

- (IBAction)returnAction:(id)sender {
    
    [self.viewController.navigationController lh_popVC];
}


- (void)setGoodsIntroduceModel:(HJGoodsIntroduceModel *)goodsIntroduceModel {
    
    _goodsIntroduceModel = goodsIntroduceModel;
    
        //
        [self.goodsIconImageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(_goodsIntroduceModel.goodsIco)] placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
        self.goodsNameLabel.text = goodsIntroduceModel.goodsName;
        self.areaLabel.text = [NSString stringWithFormat:@"产地：%@",goodsIntroduceModel.area];
        self.brandLabel.text = [NSString stringWithFormat:@"品牌：%@",goodsIntroduceModel.brandName];
        self.isBoxButton.selected = goodsIntroduceModel.isBox;
    
        HJGoodsIntroduceStandardlistModel *standardListModel = [goodsIntroduceModel.standardList firstObject];
    
        //特殊商品价格判断
    if (goodsIntroduceModel.isSpecial) {
        //
        self.specailTagLabel.text = @"【称重类商品】";
        
        HJGoodsIntroducePricelistModel *priceListModel = [standardListModel .priceList firstObject];
        self.goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@/%@（此类商品需线下称重付款）",priceListModel.currentPrice,standardListModel.unitName];
        //以前价格
        NSMutableAttributedString *attriButtedFormerPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价：¥%@/%@",priceListModel.formerPrice,standardListModel.unitName]];
        if (attriButtedFormerPrice.length>0) {
            
            NSRange range = NSMakeRange(3,attriButtedFormerPrice.length - 3);
            [attriButtedFormerPrice addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:range];
        }

        self.formerPriceLabel.attributedText = attriButtedFormerPrice;

    } else {
        
        self.specailTagLabel.text = @"  ";

        //特殊商品变为普通商品
        if (standardListModel.unitName.length>0) {
            
            HJGoodsIntroducePricelistModel *priceListModel = [standardListModel .priceList firstObject];
            self.goodsPriceLabel.text = [NSString stringWithFormat:@"¥%@/%@",priceListModel.currentPrice,standardListModel.unitName];
            //以前价格
            NSMutableAttributedString *attriButtedFormerPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价：¥%@/%@",priceListModel.formerPrice,standardListModel.unitName]];
            if (attriButtedFormerPrice.length>0) {
                
                NSRange range = NSMakeRange(3,attriButtedFormerPrice.length - 3);
                [attriButtedFormerPrice addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:range];
            }
            
            self.formerPriceLabel.attributedText = attriButtedFormerPrice;
 
            
        }
        else {
        //
        
        self.goodsPriceLabel.text = [[HJGoodsStandardPriceModel goodsStandardPriceBaseOnStandardPriceList:standardListModel.priceList isCurrentPrice:YES] stringByAppendingString:@""];
        //以前价格
        NSMutableAttributedString *attriButtedFormerPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价：%@",[HJGoodsStandardPriceModel goodsStandardPriceBaseOnStandardPriceList:standardListModel.priceList isCurrentPrice:NO]]];
        if (attriButtedFormerPrice.length>0) {
            NSRange range = NSMakeRange(3,attriButtedFormerPrice.length - 3);
            [attriButtedFormerPrice addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:range];
            self.formerPriceLabel.attributedText = attriButtedFormerPrice;
        }
        
        //隐藏原价判断
        self.formerPriceLabel.hidden = ![HJGoodsStandardPriceModel goodsStandardPriceExistBaseOnStandardPriceList:standardListModel.priceList isCurrentPrice:NO];
        }
    }

    
    self.goodsPrice = self.goodsPriceLabel.text;
    self.formerGoodsPrice = self.formerPriceLabel.text;
    self.specialTagLabelWidthCons.constant = goodsIntroduceModel.isSpecial?70:0;
    
    [self.isBoxButton setImage:kImageNamed(goodsIntroduceModel.isBox ? @"ic_b10_01_pre" : @"ic_b10_01") forState:UIControlStateNormal];
    self.joinBoxLabel.text = goodsIntroduceModel.isBox ? @"已加入货箱" : @"加入货箱";
}



@end
