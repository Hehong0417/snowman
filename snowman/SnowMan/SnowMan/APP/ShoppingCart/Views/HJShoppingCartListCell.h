//
//  HJShoppingCartListCell.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJShoppingCartListCell;
@protocol HJShoppingCartListCellDelegate <NSObject>
@optional
- (void)shoppingCartListCellClickSelectButton:(HJShoppingCartListCell *)HJShoppingCartListCell;
- (void)shoppingCartListCellClicAddOrReduceButton:(HJShoppingCartListCell *)shoppingCartListCell;
- (void)shoppingCartListCellGoodsCountZero:(HJShoppingCartListCell *)HJShoppingCartListCell;

@end

@class HJGoodsListModell;
@class HJBoxListModel;
@interface HJShoppingCartListCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UIImageView *goodsIconView;
@property (weak, nonatomic) IBOutlet UILabel *goodsNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *boxPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *bagPriceLabel;
@property (weak, nonatomic) IBOutlet UILabel *boxNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *bagNumberLabel;
@property (weak, nonatomic) IBOutlet UIView *bagView;
@property (weak, nonatomic) IBOutlet UIView *boxView;
@property (weak, nonatomic) IBOutlet UILabel *boxLabel;
@property (weak, nonatomic) IBOutlet UILabel *boxCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *bagCountLabel;

- (IBAction)reduceBoxClick:(id)sender;
- (IBAction)addBoxClick:(id)sender;
- (IBAction)reduceBagClick:(id)sender;
- (IBAction)addBagClick:(id)sender;
- (IBAction)selectButtonClick:(id)sender;

@property (nonatomic, strong) HJGoodsListModell *goodsListModel;
@property (nonatomic, strong) HJBoxListModel *boxListModel;

@property (nonatomic, assign, getter = isSelect) BOOL select;
@property (nonatomic, assign, getter = isCanEdit) BOOL canEdit;
@property (nonatomic, weak) id<HJShoppingCartListCellDelegate> delegate;



+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
