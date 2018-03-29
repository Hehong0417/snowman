//
//  HJShoppingCartDeleteBar.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJShoppingCartDeleteBar;
@protocol HJShoppingCartDeleteBarDelegate <NSObject>
@optional
- (void)shoppingCartDeleteBarClickAllSelectButton:(HJShoppingCartDeleteBar *)HJShoppingCartDeleteBar;
- (void)shoppingCartDeleteBarClickDeleteButton:(HJShoppingCartDeleteBar *)HJShoppingCartDeleteBar;
@end

@interface HJShoppingCartDeleteBar : UIView

@property (weak, nonatomic) IBOutlet UIButton *allSelectButton;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (nonatomic, assign) BOOL select;

@property (nonatomic, weak) id<HJShoppingCartDeleteBarDelegate> delegate;

- (IBAction)allSelectButtonClick:(id)sender;
- (IBAction)deleteButtonClick:(id)sender;
@end
