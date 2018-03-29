//
//  HJGoodsCommentCell.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/22.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HJOrderCommentCell;
@protocol HJOrderCommentCellDelegate <NSObject>
@optional
- (void)orderCommentCellClickComment:(HJOrderCommentCell *)orderCommentCell goodId:(NSInteger)goodId icoArrayData:(NSArray *)icoArrayData contentText:(NSString *)contentText;
@end

@class HJOrderCommentModel;
@interface HJOrderCommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *goodsIconView;
@property (weak, nonatomic) IBOutlet UICollectionView *photoCollectionView;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;
@property (weak, nonatomic) IBOutlet UILabel *warnLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;

@property (nonatomic, strong) HJOrderCommentModel *orderCommentModel;

@property (nonatomic, weak) id<HJOrderCommentCellDelegate> delegate;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end
