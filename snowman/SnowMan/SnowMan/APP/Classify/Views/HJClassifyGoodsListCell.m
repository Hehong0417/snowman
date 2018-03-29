//
//  HJClassifyGoodsListCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJClassifyGoodsListCell.h"
#import "HJWeeklySaleListAPI.h"

@interface HJClassifyGoodsListCell ()

@property (weak, nonatomic) IBOutlet UIImageView *goodsIcoImageVIew;
@property (weak, nonatomic) IBOutlet UILabel *brandNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *firstStandardLabel;
@property (weak, nonatomic) IBOutlet UILabel *secondStandardLabel;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;

@end

@implementation HJClassifyGoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.firstStandardLabel.textColor = kFontBlackColor;
    self.secondStandardLabel.textColor = kFontBlackColor;
}

- (void)setGoodsListModel:(HJGoodsListModel *)goodsListModel {
    
    _goodsListModel = goodsListModel;
    
    if (goodsListModel) {
        
        //
        [self.goodsIcoImageVIew sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(goodsListModel.goodsIco)] placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
        self.goodsNameLabel.text = goodsListModel.goodsName;
        self.brandNameLabel.text = [NSString stringWithFormat:@"品牌：%@",goodsListModel.brandName];
        
        //
        [goodsListModel.standardList enumerateObjectsUsingBlock:^(HJStandardlistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
            //显示几个规格值
            if (obj.priceList.count == 0) {
                
                self.firstStandardLabel.hidden = YES;
                self.secondStandardLabel.hidden = YES;
            }
            if (obj.priceList.count == 1) {
                
                self.firstStandardLabel.hidden = NO;
                self.secondStandardLabel.hidden = YES;
            }
            if (obj.priceList.count == 2) {
                
                self.firstStandardLabel.hidden = NO;
                self.secondStandardLabel.hidden = NO;
            }

            //
            [obj.priceList enumerateObjectsUsingBlock:^(HJPricelistModel * _Nonnull priceListModel, NSUInteger idx, BOOL * _Nonnull stop) {
                
                //第一个规格值
                if (idx == 0) {
                    
                    //特殊商品
                    if (obj.unitName.length>0) {
                        
                        NSString *currentUnitPrice = [NSString stringWithFormat:@"%@/%@",priceListModel.currentPrice,obj.unitName];
                        NSString *formerUnitPrice = [NSString stringWithFormat:@"%@/%@",priceListModel.formerPrice,obj.unitName];
                        
                        self.firstStandardLabel.attributedText = [NSString lh_currentPrice:currentUnitPrice currentPriceColor:kOrangeColor formerPrice:formerUnitPrice formerPriceColor:kFontBlackColor];
                        
                    } else {
                    
                    [self configureLabel:self.firstStandardLabel pricelistModel:priceListModel];
                        
                    }
                }
                
                //第二个规格值
                if (idx == 1) {
                    
                    [self configureLabel:self.secondStandardLabel pricelistModel:priceListModel];
                }
            }];
                
            }
        }];
        
    }
}

- (void)configureLabel:(UILabel *)label pricelistModel:(HJPricelistModel *)pricelistModel {
    
    //
    if (pricelistModel.standardType == HJStandardValueTypeBox) {
        
        NSString *currentUnitPrice = [NSString stringWithFormat:@"%@/箱",pricelistModel.currentPrice];
        NSString *formerUnitPrice = [NSString stringWithFormat:@"%@/箱",pricelistModel.formerPrice];

        label.attributedText = [NSString lh_currentPrice:currentUnitPrice currentPriceColor:kOrangeColor formerPrice:formerUnitPrice formerPriceColor:kFontBlackColor];
        
    }
    
    if (pricelistModel.standardType == HJStandardValueTypeBag) {
        
        NSString *currentUnitPrice = [NSString stringWithFormat:@"%@/袋",pricelistModel.currentPrice];
        NSString *formerUnitPrice = [NSString stringWithFormat:@"%@/袋",pricelistModel.formerPrice];
        if (pricelistModel.formerPrice.floatValue == 0 || [pricelistModel.formerPrice isEqualToString:@"null"]||[pricelistModel.formerPrice isEqualToString:kEmptySrting]) {
            
            formerUnitPrice = kEmptySrting;
        }
        
        label.attributedText = [NSString lh_currentPrice:currentUnitPrice currentPriceColor:kOrangeColor formerPrice:formerUnitPrice formerPriceColor:kFontBlackColor];
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
