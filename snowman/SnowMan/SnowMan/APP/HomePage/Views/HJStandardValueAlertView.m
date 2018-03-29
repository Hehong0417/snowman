//
//  HJStandardValueAlertView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/10.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJStandardValueAlertView.h"
#import "HJStandardValueAlertHeaderView.h"
#import "HJTypeSelectCell.h"
#import "HJStandardSelectCell.h"
#import "HJSelectStandardValueModel.h"
#import "HJGoodsStandardPriceModel.h"

@interface HJStandardValueAlertView () <UITableViewDelegate,UITableViewDataSource>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) HJStandardValueAlertHeaderView *headerView;
@property (nonatomic, strong) NSArray *standardValuesArray;
@property (nonatomic, strong) NSArray *parameterListArray;

@end

@implementation HJStandardValueAlertView

- (UIView *)alertViewContentView {
    
    if (!self.contentView) {
    
    UIView *contentView = [UIView lh_viewWithFrame:CGRectMake(0, 0, kScreenWidth, 300) backColor:kRedColor];
    
    HJStandardValueAlertHeaderView *headerView = [HJStandardValueAlertHeaderView lh_createByFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    [contentView addSubview:headerView];
    self.headerView = headerView;
        
    //点击关闭
    headerView.closeViewBlock = ^() {
            
        [self hideWithCompletion:NULL];
            
    };
    
    UITableView *tableView = [UITableView lh_tableViewWithFrame:CGRectMake(0, headerView.lh_height, kScreenWidth, 150) tableViewStyle:UITableViewStylePlain delegate:self dataSourec:self];
    tableView.rowHeight = 50;
    [tableView lh_registerNibFromCellClassName:[HJTypeSelectCell className]];
    [tableView lh_registerNibFromCellClassName:[HJStandardSelectCell className]];
    tableView.tableFooterView = [UIView new];
    [contentView addSubview:tableView];
    self.tableView = tableView;
    
    UIView *footerView = [UIView lh_viewWithFrame:CGRectMake(0, tableView.lh_bottom, kScreenWidth, 50) backColor:kOrangeColor];
    [contentView addSubview:footerView];
    
    //
    UIButton *sureButton = [UIButton lh_buttonWithFrame:CGRectMake(0, 0, footerView.lh_width, footerView.lh_height) target:self action:@selector(sureAction) title:@"确定" titleColor:kWhiteColor font:FontNormalSize backgroundColor:APP_COMMON_COLOR];
    [footerView addSubview:sureButton];
    
    return contentView;
    }
    
    return self.contentView;
}

- (void)layoutSubviews {
    
    [super layoutSubviews];
    
    //如果是特殊商品frame变化
    
}

#pragma mark - Action

- (void)sureAction {
    
    //确定回传选择规格值在商品详情页面
    NSMutableArray *selectedStandards = [NSMutableArray array];

    if (self.goodsIntroduceModel.isSpecial) {
        
        //

        [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if ([obj isKindOfClass:[HJStandardSelectCell class]]) {
                
                HJStandardSelectCell *standardSelectCell = obj;
                
                NSString *selectParameter = standardSelectCell.selectedParameterValue;
                NSString *selectedGoodsCount = standardSelectCell.selectedGoodsCount;
                NSString *selectedParameterId = standardSelectCell.selectedParameterId;
                NSString *selectedUnitGoodsCount = standardSelectCell.selectedUnitGoodsCount;
                NSString *selectedUnitGoodsName = standardSelectCell.unitName;
                
                HJStandardValueType standardardValueType = standardSelectCell.priceListModel.standardType;
                
                __block NSString *unitPrice;
                
                [self.standardValuesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    
                    HJGoodsIntroducePricelistModel *priceModel = obj;
                    
                    if (standardardValueType == priceModel.standardType) {
                        
                        unitPrice = priceModel.currentPrice;
                    }
                    
                }];
                
                HJSelectStandardValueModel *standardValueModel = [HJSelectStandardValueModel new];
                standardValueModel.parameterValue = selectParameter;
                standardValueModel.goodsCount = selectedGoodsCount;
                standardValueModel.parameterId = selectedParameterId;
                standardValueModel.unitGoodsCount = selectedUnitGoodsCount;
                standardValueModel.standardType = standardardValueType;
                //单位价钱
                standardValueModel.unitGoodsPrice = unitPrice;
                standardValueModel.unitGoodsName = selectedUnitGoodsName;
                
                //商品数量大于0加入规格list
                if (selectedGoodsCount.integerValue > 0) {
                    
                    [selectedStandards addObject:standardValueModel];
                }
            }
        }];

    } else {
        
    HJTypeSelectCell *typeSelectCell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    NSString *standardName = typeSelectCell.selectStandardName;
    
    //
    [self.tableView.visibleCells enumerateObjectsUsingBlock:^(__kindof UITableViewCell * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if ([obj isKindOfClass:[HJStandardSelectCell class]]) {
            
            HJStandardSelectCell *standardSelectCell = obj;
            
            NSString *selectParameter = standardSelectCell.selectedParameterValue;
            NSString *selectedGoodsCount = standardSelectCell.selectedGoodsCount;
            NSString *selectedParameterId = standardSelectCell.selectedParameterId;
            NSString *selectedUnitGoodsCount = standardSelectCell.selectedUnitGoodsCount;
            
            HJStandardValueType standardardValueType = standardSelectCell.priceListModel.standardType;
            
            __block NSString *unitPrice;
            
            [self.standardValuesArray enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                
                    HJGoodsIntroducePricelistModel *priceModel = obj;
                    
                    if (standardardValueType == priceModel.standardType) {
                        
                        unitPrice = priceModel.currentPrice;
                    }
                    
            }];
            
            HJSelectStandardValueModel *standardValueModel = [HJSelectStandardValueModel new];
            standardValueModel.standardName = standardName;
            standardValueModel.parameterValue = selectParameter;
            standardValueModel.goodsCount = selectedGoodsCount;
            standardValueModel.parameterId = selectedParameterId;
            standardValueModel.unitGoodsCount = selectedUnitGoodsCount;
            standardValueModel.standardType = standardardValueType;
            //单位价钱
            standardValueModel.unitGoodsPrice = unitPrice;

            //商品数量大于0加入规格list
            if (selectedGoodsCount.integerValue > 0) {
                
                [selectedStandards addObject:standardValueModel];
            }
        }
    }];
    }
    
//    [self hideWithCompletion:NULL];
    if (!selectedStandards.count) {
        [SVProgressHUD showInfoWithStatus:@"请选择商品数量"];
        
    } else {
        [self hideWithCompletion:NULL];
    }
    
    !self.sureHandler?:self.sureHandler(selectedStandards);
    
}

#pragma mark - Table view dataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (self.goodsIntroduceModel.isSpecial) {
        
        return 2;
    }
    
    NSUInteger rowsNum = (self.goodsIntroduceModel!=nil) + self.standardValuesArray.count;
    
    return rowsNum;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    if (indexPath.row == 0) {
        
        HJTypeSelectCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[HJTypeSelectCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        cell.typeArray = self.goodsIntroduceModel.standardList;
        WEAK_SELF();;
        cell.selectStandardSizeHandler = ^(UIButton *button) {
            
            STRONG_SELF();
            
            HJGoodsIntroduceStandardlistModel *standardListModel = [strongSelf.goodsIntroduceModel.standardList objectOrNilAtIndex:button.tag];
            //点击改变头部价格
            self.headerView.goodsPriceLabel.text = [HJGoodsStandardPriceModel goodsStandardPriceBaseOnStandardPriceList:standardListModel.priceList isCurrentPrice:YES];
            
            //以前价格range
            NSString *formerGoodsPrice = [@"原价：" stringByAppendingString:[HJGoodsStandardPriceModel goodsStandardPriceBaseOnStandardPriceList:standardListModel.priceList isCurrentPrice:NO]];
            NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:formerGoodsPrice];
            NSRange beforeRange = NSMakeRange(3,formerGoodsPrice.length-3);
            [attributedString addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:beforeRange];
            
            self.headerView.goodsFormerPriceLabel.attributedText = attributedString;

            //原价是否隐藏
            self.headerView.goodsFormerPriceLabel.hidden = ![HJGoodsStandardPriceModel goodsStandardPriceExistBaseOnStandardPriceList:standardListModel.priceList isCurrentPrice:NO];
            
            //点击改变规格值
            strongSelf.standardValuesArray = standardListModel.priceList;
            [tableView reloadData];//tableview strongSelf？？？？
            
            DDLogInfo(@"model = %@", standardListModel);
            
        };
        
        [cell lh_setSeparatorInsetZero];
        
        return cell;
        
    } else {
        
        //特殊产品
        if (self.goodsIntroduceModel.isSpecial) {
            
            HJStandardSelectCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[HJStandardSelectCell className]];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            [cell lh_setSeparatorInsetZero];
            
            HJGoodsIntroduceStandardlistModel *standardlistModel = self.goodsIntroduceModel.standardList[indexPath.row-1];
            cell.priceListModel = [standardlistModel.priceList firstObject];
            cell.unitName = standardlistModel.unitName;
            cell.unitPrice = standardlistModel.unitPrice;
            
            return cell;
        }

        
        HJStandardSelectCell *cell = [tableView lh_dequeueReusableCellWithCellClassName:[HJStandardSelectCell className]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        [cell lh_setSeparatorInsetZero];
        
        cell.alertView = self;
        
        HJGoodsIntroducePricelistModel *priceListModel = self.standardValuesArray[indexPath.row-1];
        cell.priceListModel = priceListModel;
        
        HJGoodsIntroduceStandardlistModel *standardlistModel = self.goodsIntroduceModel.standardList[indexPath.row-1];

        //特殊商品变普通
        if (standardlistModel.unitName.length > 0) {
            
            cell.unitName = standardlistModel.unitName;
            cell.unitPrice = standardlistModel.unitPrice;

        }
        
        //
//        HJGoodsIntroduceStandardlistModel *standardListModel = [self.goodsIntroduceModel.standardList objectOrNilAtIndex:indexPath.row-1];
//        cell.standardValueType = standardListModel.standardId;

        
        return cell;
    }
    
}

#pragma mark - Setter&Getter

- (void)setGoodsIntroduceModel:(HJGoodsIntroduceModel *)goodsIntroduceModel {
    
    _goodsIntroduceModel = goodsIntroduceModel;
    
    //
    [self.headerView.goodsIconImageView sd_setImageWithURL:[NSURL URLWithString:kAPIImageFromUrl(_goodsIntroduceModel.goodsIco)] placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
    self.headerView.goodsNameLabel.text = goodsIntroduceModel.goodsName;
    //tableView数据源赋值，型号，规格,初始化时默认选中第一个standardSize
    HJGoodsIntroduceStandardlistModel *standardListModel = [self.goodsIntroduceModel.standardList objectOrNilAtIndex:0];
    self.standardValuesArray = standardListModel.priceList;
    [self.tableView reloadData];
    
}

- (void)setGoodsPrice:(NSString *)goodsPrice {
    
    _goodsPrice = goodsPrice;
    
    self.headerView.goodsPriceLabel.text = goodsPrice;
}

- (void)setFormerGoodsPrice:(NSString *)formerGoodsPrice {
    
    _formerGoodsPrice = formerGoodsPrice;
    
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc]initWithString:formerGoodsPrice];
    
    //以前价格range
    NSRange beforeRange = NSMakeRange(3,formerGoodsPrice.length-3);
    [attributedString addAttributes:@{NSStrikethroughStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]} range:beforeRange];
    
    self.headerView.goodsFormerPriceLabel.attributedText = attributedString
    ;
    
    //隐藏原价判断
    HJGoodsIntroduceStandardlistModel *standardListModel = [self.goodsIntroduceModel.standardList objectAtIndex:0];
    self.headerView.goodsFormerPriceLabel.hidden = ![HJGoodsStandardPriceModel goodsStandardPriceExistBaseOnStandardPriceList:standardListModel.priceList isCurrentPrice:NO];

}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect {
 // Drawing code
 }
 */

@end
