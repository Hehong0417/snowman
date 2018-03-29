//
//  HJHomePageGoodsListCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJHomePageGoodsListCell.h"
#import "HJConfigureStandardSizeModel.h"

@interface HJHomePageGoodsListCell ()

@property (nonatomic, strong) IBOutlet UIImageView *goodsIcoImageView;
@property (weak, nonatomic) IBOutlet UILabel *boxCurrentPriceLable1;
@property (weak, nonatomic) IBOutlet UILabel *boxFormerPriceLabel1;

@property (weak, nonatomic) IBOutlet UILabel *boxCurrentPriceLable2;
@property (weak, nonatomic) IBOutlet UILabel *boxFormerPriceLabel2;

@property (weak, nonatomic) IBOutlet UILabel *bagCurrentPriceLable2;
@property (weak, nonatomic) IBOutlet UILabel *bagFormerPriceLabel2;

@property (weak, nonatomic) IBOutlet UIView *oneView;
@property (weak, nonatomic) IBOutlet UIView *twoView;

@end

@implementation HJHomePageGoodsListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    self.twoView.hidden = YES;
    self.oneView.hidden = NO;
    // Initialization code
}

- (void)setGoodsListModel:(HJHomePageGoodsListModel *)goodsListModel {
    
    _goodsListModel = goodsListModel;
    
    if (goodsListModel) {
        
        [self.goodsIcoImageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(goodsListModel.goodsIco?:kEmptySrting)] placeholderImage:kImageNamed(@"icon_shoplist_default")];
    
            HJStandardlistModel *standardListModel = [goodsListModel.standardList firstObject];
            HJPricelistModel *pricelistModel = [standardListModel.priceList firstObject];
        
            if (goodsListModel.isSpecial) {
                
                self.twoView.hidden = YES;
                self.oneView.hidden = NO;
                [self setBoxLabelOneWithCurrentPrice:pricelistModel.currentPrice standString:standardListModel.unitName formerPrice:pricelistModel.formerPrice];
                
            } else if (standardListModel.priceList.count == 1) {
                self.twoView.hidden = YES;
                self.oneView.hidden = NO;
                
                [self setBoxLabelOneWithCurrentPrice:pricelistModel.currentPrice standString:[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:pricelistModel.standardType] formerPrice:pricelistModel.formerPrice];
            
            } else if (standardListModel.priceList.count == 2) {
                self.oneView.hidden = YES;
                self.twoView.hidden = NO;
            
            [standardListModel.priceList enumerateObjectsUsingBlock:^(HJPricelistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if (obj.standardType == HJStandardValueTypeBox) {
                    //
                    self.boxCurrentPriceLable2.text = [NSString stringWithFormat:@"￥%@元/%@",obj.currentPrice?:kEmptySrting,[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:obj.standardType]];
                    
                    NSMutableAttributedString *attriButtedFormerPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价:¥%@/%@",obj.formerPrice?:kEmptySrting,[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:obj.standardType]]];
                    if (attriButtedFormerPrice.length>0) {
                        
                        NSRange range = NSMakeRange(3,attriButtedFormerPrice.length - 3);
                        [attriButtedFormerPrice addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:range];
                    }
                    
                    self.boxFormerPriceLabel2.attributedText = attriButtedFormerPrice;
                    
                    [self formerPriceLabel:self.boxFormerPriceLabel2 baseOnFormerPrice:obj.formerPrice];
                    
                } else if (obj.standardType == HJStandardValueTypeBag) {
                    
                    self.bagCurrentPriceLable2.text = [NSString stringWithFormat:@"￥%@元/%@",obj.currentPrice?:kEmptySrting,[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:obj.standardType]];
                    
                    NSMutableAttributedString *attriButtedFormerPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价:¥%@/%@",obj.formerPrice?:kEmptySrting,[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:obj.standardType]]];
                    if (attriButtedFormerPrice.length>0) {
                        
                        NSRange range = NSMakeRange(3,attriButtedFormerPrice.length - 3);
                        [attriButtedFormerPrice addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:range];
                    }
                    
                    self.bagFormerPriceLabel2.attributedText = attriButtedFormerPrice;

                    [self formerPriceLabel:self.bagFormerPriceLabel2 baseOnFormerPrice:obj.formerPrice];

                }
            }];
            
        }
       
    }
    
}

- (void)formerPriceLabel:(UILabel *)formerPriceLabel baseOnFormerPrice:(NSString *)formerPrice {
    
    if (formerPrice.floatValue == 0 || [formerPrice isEqualToString:@"null"]||[formerPrice isEqualToString:kEmptySrting]) {
        
        formerPriceLabel.hidden = YES;
    } else {
        
        formerPriceLabel.hidden = NO;
    }
}

- (void)setBoxLabelOneWithCurrentPrice:(NSString *)currentPrice standString:(NSString *)standString formerPrice:(NSString *)formerPrice
{
    self.boxCurrentPriceLable1.text = [NSString stringWithFormat:@"￥%@元/%@",currentPrice?:kEmptySrting,standString];
    
    NSMutableAttributedString *attriButtedFormerPrice = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"原价:¥%@/%@",formerPrice,standString]];
    if (attriButtedFormerPrice.length>0) {
        
        NSRange range = NSMakeRange(3,attriButtedFormerPrice.length - 3);
        [attriButtedFormerPrice addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:range];
    }
    
    self.boxFormerPriceLabel1.attributedText = attriButtedFormerPrice;
    
    [self formerPriceLabel:self.boxFormerPriceLabel1 baseOnFormerPrice:formerPrice];
}

@end
