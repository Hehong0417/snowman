//
//  HJStandardSelectCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/11.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJStandardSelectCell.h"
#import "HJConfigureStandardSizeModel.h"
#import "XYQButton.h"

@interface HJStandardSelectCell ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UILabel *standardEveryLabel;
@property (nonatomic, strong) IBOutlet UIButton *standardNumSelectButton;
@property (nonatomic, strong) UITableView *standardNumTableView;
@property (weak, nonatomic) IBOutlet UIImageView *detailArrowImageView;


@end

@implementation HJStandardSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    [self.standardNumSelectButton lh_setCornerRadius:0 borderWidth:1 borderColor:kLineLightColor];
    [self.standardNumSelectButton addTarget:self action:@selector(standardNumSelectAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.selectedGoodsCount = self.goodsCountLabel.text;

}

#pragma mark - Action

- (IBAction)increaseAction:(id)sender {
    
    //购物车数量增加
    [self.goodsCountLabel lh_shopCartNumIncrease];
    [self changeGoodsCountAction];
}


- (IBAction)reduceAction:(id)sender {
    
    [self.goodsCountLabel lh_shopCartNumReduce];
    //选择规格数量
    [self changeGoodsCountAction];
}

- (void)changeGoodsCountAction {
    
    //选择规格数量
    if (self.unitPrice) {
        
        //特殊商品
        self.selectedUnitGoodsCount = [self.goodsCountLabel.text stringByAppendingString:self.unitPrice];
        
        
    } else {
        self.selectedUnitGoodsCount = [self.goodsCountLabel.text stringByAppendingString:[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:self.priceListModel.standardType]];
    }
    
    self.selectedGoodsCount = self.goodsCountLabel.text;
}

- (void)standardNumSelectAction:(UIButton *)button {
    
    [self.alertView.contentView addSubview:self.standardNumTableView];
    [self.standardNumTableView reloadData];
}

#pragma mark - Table view dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.priceListModel.parameterList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[UITableViewCell className]];
    HJParameterlistModel *model = [self.priceListModel.parameterList objectAtIndex:indexPath.row];
    
//    NSString *standardTypeStr;
//    
//    if (self.priceListModel.standardType == HJStandardValueTypeBox) {
//        
//        standardTypeStr = [NSString stringWithFormat:@"袋装"];
//    }
//    
//    if (self.priceListModel.standardType == HJStandardValueTypeBag) {
//        
//        standardTypeStr = [NSString stringWithFormat:@"斤装"];
//    }
//    
//    if (self.priceListModel.standardType == HJStandardValueTypeKG) {
//        
//        standardTypeStr = [NSString stringWithFormat:@"斤装"];
//    }
//    
    
    cell.textLabel.text = model.remark;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [self.standardNumTableView removeFromSuperview];
    
    UITableViewCell *selectCell = [tableView cellForRowAtIndexPath:indexPath];
    //
    HJParameterlistModel *selectParamterModel =
    [self.priceListModel.parameterList objectAtIndex:indexPath.row];
    [self.standardNumSelectButton setTitle:selectCell.textLabel.text forState:UIControlStateNormal];
    //选择规格参数
    self.selectedParameterValue = selectCell.textLabel.text;
    self.selectedParameterId = [NSString stringWithFormat:@"%ld",selectParamterModel.parameterId];
    
}

#pragma mark - Setter&Getter

- (void)setPriceListModel:(HJGoodsIntroducePricelistModel *)priceListModel {
    
    _priceListModel = priceListModel;
    
    if (priceListModel.standardType == HJStandardValueTypeBox) {
        
        self.standardEveryLabel.text = [NSString stringWithFormat:@"规格%@",[@"箱" lh_appendingStringWithPrefixString:@"(" suffixString:@")"]];
//        [self.standardNumSelectButton setTitle:@"1袋装" forState:normal];
        
        //
        [priceListModel.parameterList enumerateObjectsUsingBlock:^(HJParameterlistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [self.standardNumSelectButton setTitle:obj.remark forState:UIControlStateNormal];
                self.selectedParameterId = [NSString stringWithFormat:@"%ld",obj.parameterId];
                
            }
            
        }];
        
    }
    
    if (priceListModel.standardType == HJStandardValueTypeBag) {
        
        self.standardEveryLabel.text = [NSString stringWithFormat:@"规格%@",[@"袋" lh_appendingStringWithPrefixString:@"(" suffixString:@")"]];
//        [self.standardNumSelectButton setTitle:@"1斤装" forState:normal];
        
        //
        [priceListModel.parameterList enumerateObjectsUsingBlock:^(HJParameterlistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (idx == 0) {
                
                [self.standardNumSelectButton setTitle:obj.remark forState:UIControlStateNormal];
                self.selectedParameterId = [NSString stringWithFormat:@"%ld",obj.parameterId];
                
            }
            
        }];

    }
    
    if (priceListModel.standardType == HJStandardValueTypeKG) {
        
        self.standardEveryLabel.text = [NSString stringWithFormat:@"规格／斤"];
        [self.standardNumSelectButton setTitle:@"1斤装" forState:normal];
    }
    
    //规格为袋的话不能点击选择
    if (priceListModel.standardType == HJStandardValueTypeBag) {
        
        self.standardNumSelectButton.enabled = NO;
    } else {
        
        self.standardNumSelectButton.enabled = YES;
    }
    
    //选择规格参数
    self.selectedParameterValue = self.standardNumSelectButton.titleLabel.text;
    //选择规格数量
    self.selectedUnitGoodsCount = [self.goodsCountLabel.text stringByAppendingString:[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:self.priceListModel.standardType]];
    self.selectedGoodsCount = self.goodsCountLabel.text;
    //选择规格参数Id
    HJParameterlistModel *model = [priceListModel.parameterList firstObject];
    self.selectedParameterId = [NSString stringWithFormat:@"%ld",model.parameterId];
    
}

- (void)setUnitName:(NSString *)unitName {
    
    _unitName = unitName;
    //
    //特殊商品隐藏
    self.standardNumSelectButton.hidden = YES;
    self.detailArrowImageView.hidden = YES;
    
}

- (void)setUnitPrice:(NSString *)unitPrice {
    
    _unitPrice = unitPrice;
    
    //
    self.standardEveryLabel.text = [NSString stringWithFormat:@"规格%@",[unitPrice lh_appendingStringWithPrefixString:@"(" suffixString:@")"]];

    //选择规格数量
    if (unitPrice) {
        
        //特殊商品
        self.selectedUnitGoodsCount = [self.goodsCountLabel.text stringByAppendingString:unitPrice];
        self.selectedParameterValue = nil;
        
    } else {
        self.selectedUnitGoodsCount = [self.goodsCountLabel.text stringByAppendingString:[HJConfigureStandardSizeModel StandardStringConfigureStandardSize:self.priceListModel.standardType]];
    }

    
}

- (UITableView *)standardNumTableView {
    
    if (!_standardNumTableView) {
        
        //
        _standardNumTableView = [UITableView lh_tableViewWithFrame:CGRectMake(0, 0, 200, _alertView.alertViewContentView.lh_height) tableViewStyle:UITableViewStylePlain delegate:self dataSourec:self];
        [_standardNumTableView lh_registerClassFromCellClassName:[UITableViewCell className]];
        _standardNumTableView.tableFooterView = [UIView new];
        //去除规格页面隐藏效果
//        [_standardNumTableView bk_whenTapped:^{
//            
//            
//        }];
    }
    
    return _standardNumTableView;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
