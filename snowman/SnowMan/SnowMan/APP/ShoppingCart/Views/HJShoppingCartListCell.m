//
//  HJShoppingCartListCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJShoppingCartListCell.h"
#import "HJConfigureStandardSizeModel.h"
#import "HJShopCartBrandAPI.h"

@interface HJShoppingCartListCell ()
@end
@implementation HJShoppingCartListCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"shoppingCartListCell";
    HJShoppingCartListCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HJShoppingCartListCell" owner:nil options:nil] lastObject];
    }
    return cell;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
    [self setGoodsListModel:nil];
    [self setBoxListModel:nil];
    self.canEdit = NO;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setGoodsListModel:(HJGoodsListModell *)goodsListModel
{
    _goodsListModel = goodsListModel;
    [self setGoodsName:goodsListModel.goodsName goodIcon:goodsListModel.goodsIco];
    
    HJPriceListModel *priceListModel = [HJPriceListModel new];
    if (!goodsListModel.priceList.count) {
        self.bagPriceLabel.hidden = YES;
        self.bagView.hidden = YES;
        self.boxView.hidden = YES;
        
    } else if (goodsListModel.priceList.count == 1) {
        self.bagView.hidden = YES;
        self.bagPriceLabel.hidden = YES;
        priceListModel = goodsListModel.priceList[0];
        
        if (goodsListModel.isSpecial) {
            [self specialStandardSetStandardName:priceListModel.unitName count:priceListModel.count goodsPrice:priceListModel.currentPrice];
            
        } else {
            
            //
            if (priceListModel.unitName.length > 0) {
                
                //特殊商品变普通
                if ([priceListModel.unitName isEqualToString:priceListModel.unitPrice]) {
                    [self specialStandardSetStandardName:priceListModel.unitName count:priceListModel.count goodsPrice:priceListModel.currentPrice];
                }
                
            }
            else {
            [self oneStandardSetStandardType:priceListModel.standardType count:priceListModel.count goodsPrice:priceListModel.currentPrice];
            }
        }
        
    } else if (goodsListModel.priceList.count == 2) {
        self.bagPriceLabel.hidden = NO;
        
        [goodsListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            HJPriceListModel *priceListModel = obj;
            
            if (priceListModel.standardType == HJStandardValueTypeBox) {
                [self twoStandardSetBoxDetailWithCount:priceListModel.count goodsPrice:priceListModel.currentPrice];
                
            } else if (priceListModel.standardType == HJStandardValueTypeBag) {
                [self twoStandardSetBagDetailWithCount:priceListModel.count goodsPrice:priceListModel.currentPrice];
            }
        }];
    }
}

- (void)setBoxListModel:(HJBoxListModel *)boxListModel
{
    _boxListModel = boxListModel;
    [self setGoodsName:boxListModel.goodsName goodIcon:boxListModel.goodsIco];
    
    HJBoxPriceListModel *boxPriceListModel = [HJBoxPriceListModel new];
    
    if (!boxListModel.priceList.count) {
        self.bagPriceLabel.hidden = YES;
        self.bagView.hidden = YES;
        self.boxView.hidden = YES;
        
    } else if (boxListModel.priceList.count == 1) {
        self.bagPriceLabel.hidden = YES;
        self.bagView.hidden = YES;
        boxPriceListModel = boxListModel.priceList[0];
        
        if (boxListModel.isSpecial) {
            [self specialStandardSetStandardName:boxPriceListModel.unitName count:boxPriceListModel.count goodsPrice:boxPriceListModel.currentPrice];
            
        } else {
            
            [self oneStandardSetStandardType:boxPriceListModel.standardType count:boxPriceListModel.count goodsPrice:boxPriceListModel.currentPrice];
        }
        
        
    } else if (boxListModel.priceList.count == 2) {
        
        self.bagPriceLabel.hidden = NO;
        [boxListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJBoxPriceListModel *boxPriceListModel = obj;
            
            if (boxPriceListModel.standardType == HJStandardValueTypeBox) {
                [self twoStandardSetBoxDetailWithCount:boxPriceListModel.count goodsPrice:boxPriceListModel.currentPrice];
                
            } else if (boxPriceListModel.standardType == HJStandardValueTypeBag) {
                [self twoStandardSetBagDetailWithCount:boxPriceListModel.count goodsPrice:boxPriceListModel.currentPrice];
            }
        }];
    }
}

#pragma mark - method
/**
 *  设置商品名称和图片
 */
- (void)setGoodsName:(NSString *)GoodsName goodIcon:(NSString *)goodIcons
{
    [self.goodsIconView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(goodIcons)] placeholderImage:kImageNamed(@"icon_shoplist_default")];
    self.goodsNameLabel.text = GoodsName;
}

/**
 *  设置只用一种规格的商品规格详情
 */
- (void)oneStandardSetStandardType:(NSInteger)standardType count:(NSInteger)count goodsPrice:(NSString *)goodsPrice
{
    self.bagView.hidden = YES;
    self.boxNumberLabel.text = [NSString stringWithFormat:@"%ld", count];
    self.boxCountLabel.text = [NSString stringWithFormat:@"%ld%@", count, [HJConfigureStandardSizeModel StandardStringConfigureStandardSize:standardType]];
    self.boxLabel.text = [HJConfigureStandardSizeModel StandardStringConfigureStandardSize:standardType];
    self.boxPriceLabel.text = [NSString stringWithFormat:@"￥%@/%@", goodsPrice, [HJConfigureStandardSizeModel StandardStringConfigureStandardSize:standardType]];
}

/**
 *  设置特殊商品规格详情
 */
- (void)specialStandardSetStandardName:(NSString *)standardName count:(NSInteger)count goodsPrice:(NSString *)goodsPrice
{
    self.bagView.hidden = YES;
    self.boxNumberLabel.text = [NSString stringWithFormat:@"%ld", count];
    self.boxCountLabel.text = [NSString stringWithFormat:@"%ld%@", count, standardName];
    self.boxLabel.text = standardName;
    self.boxPriceLabel.text = [NSString stringWithFormat:@"￥%@/%@", goodsPrice, standardName];
}

/**
 *  设置两种规格的 箱 规格显示详情
 */
- (void)twoStandardSetBoxDetailWithCount:(NSInteger)count goodsPrice:(NSString *)goodsPrice
{
    self.boxNumberLabel.text = [NSString stringWithFormat:@"%ld", count];
    self.boxPriceLabel.text = [NSString stringWithFormat:@"￥%@/箱", goodsPrice];
    self.boxCountLabel.text = [NSString stringWithFormat:@"%ld箱", count];
}

/**
 *  设置两种规格的 袋 规格显示详情
 */
- (void)twoStandardSetBagDetailWithCount:(NSInteger)count goodsPrice:(NSString *)goodsPrice
{
    self.bagNumberLabel.text = [NSString stringWithFormat:@"%ld", count];
    self.bagPriceLabel.text = [NSString stringWithFormat:@"￥%@/袋", goodsPrice];
    self.bagCountLabel.text = [NSString stringWithFormat:@"%ld袋", count];
}


- (void)clickCountButton
{
    [self.delegate shoppingCartListCellClicAddOrReduceButton:self];
}

- (IBAction)selectButtonClick:(id)sender {
    self.select = !self.select;
    [self.delegate shoppingCartListCellClickSelectButton:self];
}

#pragma mark - action
- (IBAction)reduceBoxClick:(id)sender {
    
    NSInteger boxCount = [self.boxNumberLabel.text integerValue];
    NSInteger bagCount = [self.bagNumberLabel.text integerValue];
    NSInteger newCount;
    
//    if (self.boxListModel.priceList.count == 1 || self.goodsListModel.priceList.count == 1) {
//        newCount = ((boxCount - 1) > 0) ? (boxCount - 1):1;
//        
//    } else {
//        if (((boxCount + bagCount) > 1) && (boxCount > 0)) {
//            newCount = boxCount - 1;
//            
//        } else if (boxCount == 1) {
//            newCount = 1;
//            
//        } else if (boxCount == 0) {
//            newCount = 0;
//        }
//    }

    newCount = ((boxCount - 1) > 0) ? (boxCount - 1):0;
    
    self.boxNumberLabel.text = [NSString stringWithFormat:@"%ld", newCount];
    
    if (self.goodsListModel.priceList.count == 1) {
        HJPriceListModel *model = self.goodsListModel.priceList[0];
        model.count = newCount;
        
    } else if (self.goodsListModel.priceList.count == 2) {
        [self.goodsListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJPriceListModel *model = obj;
            if (model.standardType == HJStandardValueTypeBox) {
                model.count = newCount;
            }
        }];
        
    } else if (self.boxListModel.priceList.count == 1) {
        HJBoxPriceListModel *model = self.boxListModel.priceList[0];
        model.count = newCount;
        
    } else if (self.boxListModel.priceList.count == 2) {
        [self.boxListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJBoxPriceListModel *model = obj;
            if (model.standardType == HJStandardValueTypeBox) {
                model.count = newCount;
            }
        }];
    }
    
    [self clickCountButton];
}

- (IBAction)addBoxClick:(id)sender {
    NSInteger newCount = [self.boxNumberLabel.text integerValue] + 1;
    self.boxNumberLabel.text = [NSString stringWithFormat:@"%ld", newCount];
    
    if (self.goodsListModel.priceList.count == 1) {
            HJPriceListModel *model = self.goodsListModel.priceList[0];
            model.count = newCount;
        
    } else if (self.goodsListModel.priceList.count == 2) {
        [self.goodsListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJPriceListModel *model = obj;
            if (model.standardType == HJStandardValueTypeBox) {
                model.count = newCount;
            }
        }];
        
    } else if (self.boxListModel.priceList.count == 1) {
        HJBoxPriceListModel *model = self.boxListModel.priceList[0];
        model.count = newCount;
        
    } else if (self.boxListModel.priceList.count == 2) {
        [self.boxListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJBoxPriceListModel *model = obj;
            if (model.standardType == HJStandardValueTypeBox) {
                model.count = newCount;
            }
        }];
    }
    [self clickCountButton];
}

- (IBAction)reduceBagClick:(id)sender {
    NSInteger boxCount = [self.boxNumberLabel.text integerValue];
    NSInteger bagCount = [self.bagNumberLabel.text integerValue];
    NSInteger newCount;
    
//    if (self.boxListModel.priceList.count == 1 || self.goodsListModel.priceList.count == 1) {
//        newCount = ((bagCount - 1) > 0) ? (bagCount - 1):1;
//    } else {
//        if (((bagCount + boxCount) > 1) && (bagCount > 0)) {
//            newCount = bagCount - 1;
//        } else if (bagCount == 1) {
//            newCount = 1;
//        } else if (bagCount == 0) {
//            newCount = 0;
//        }
//    }
    newCount = ((bagCount - 1) > 0) ? (bagCount - 1):0;

    
    self.bagNumberLabel.text = [NSString stringWithFormat:@"%ld", newCount];
    
    if (self.goodsListModel.priceList.count == 2) {
        [self.goodsListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJPriceListModel *model = obj;
            if (model.standardType == HJStandardValueTypeBag) {
                model.count = newCount;
            }
        }];
        
    } else if (self.boxListModel.priceList.count == 2) {
        [self.boxListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJBoxPriceListModel *model = obj;
            if (model.standardType == HJStandardValueTypeBag) {
                model.count = newCount;
            }
        }];
    }
    
    [self clickCountButton];
}

- (IBAction)addBagClick:(id)sender {
    NSInteger newCount = [self.bagNumberLabel.text integerValue] + 1;
    self.bagNumberLabel.text = [NSString stringWithFormat:@"%ld", newCount];
    
    if (self.goodsListModel.priceList.count == 2) {
        [self.goodsListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJPriceListModel *model = obj;
            if (model.standardType == HJStandardValueTypeBag) {
                model.count = newCount;
            }
        }];
        
    } else if (self.boxListModel.priceList.count == 2) {
        [self.boxListModel.priceList enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            HJBoxPriceListModel *model = obj;
            if (model.standardType == HJStandardValueTypeBag) {
                model.count = newCount;
            }
        }];
    }
    [self clickCountButton];
}


#pragma mark - setting & getting

- (void)setSelect:(BOOL)select
{
    _select = select;
    if (self.isSelect) {
        [self.selectButton setImage:kImageNamed(@"ic_b15_xuanzhong_pre") forState:UIControlStateNormal];
    } else {
        [self.selectButton setImage:kImageNamed(@"ic_b15_xuanzhong") forState:UIControlStateNormal];
    }
}

- (void)setCanEdit:(BOOL)canEdit
{
    _canEdit = canEdit;
    if (canEdit) {
        self.boxView.hidden = NO;
        self.boxCountLabel.hidden = YES;
        self.bagView.hidden = NO;
        self.bagCountLabel.hidden = YES;
    } else {
        self.boxView.hidden = YES;
        self.boxCountLabel.hidden = NO;
        self.bagView.hidden = YES;
        self.bagCountLabel.hidden = NO;
    }
}

@end
