//
//  HJShoppingCartListHeaderView.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJShoppingCartListHeaderView;
@protocol HJShoppingCartListHeaderViewDelegate <NSObject>
- (void)ShoppingCartListHeaderViewClickAllSelectButton:(HJShoppingCartListHeaderView *)headerView;
@end

@interface HJShoppingCartListHeaderView : UIView

@property (nonatomic, assign) BOOL select;
@property (nonatomic, weak) id<HJShoppingCartListHeaderViewDelegate> delegate;
@property (weak, nonatomic) IBOutlet UIButton *selectButton;
@property (weak, nonatomic) IBOutlet UILabel *myContainerLabel;

- (IBAction)selectButtonClick:(id)sender;

@end
