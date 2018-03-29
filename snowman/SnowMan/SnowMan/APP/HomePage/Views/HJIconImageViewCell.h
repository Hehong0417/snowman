//
//  HJIconImageViewCell.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/18.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJOrderCommentModel;
@interface HJIconImageViewCell : UICollectionViewCell

@property (weak, nonatomic) IBOutlet UIImageView *iconImageView;
@property (weak, nonatomic) IBOutlet UIButton *deleleButton;
@property (nonatomic, strong) HJOrderCommentModel *orderCommentModel;
@end
