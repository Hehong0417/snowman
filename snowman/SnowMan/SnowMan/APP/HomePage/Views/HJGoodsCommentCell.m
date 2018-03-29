//
//  HJGoodsCommentCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/17.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGoodsCommentCell.h"

@interface HJGoodsCommentCell ()

@property (weak, nonatomic) IBOutlet UIImageView *userIconImageView;

@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *commentLabel;

@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *commetnImageView1;
@property (weak, nonatomic) IBOutlet UIImageView *commetnImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *commetnImageView3;

@property (nonatomic, strong) NSArray <UIImageView *> *commentImageViews;

@end

@implementation HJGoodsCommentCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.commentImageViews = @[self.commetnImageView1,self.commetnImageView2,self.commetnImageView3];
}

- (void)setGoodsCommentModel:(HJGoodsCommentModel *)goodsCommentModel {
    
    _goodsCommentModel = goodsCommentModel;
    
    [self.userIconImageView lh_setImageWithImagePartUrlString:goodsCommentModel.userIco placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
    self.userNameLabel.text = goodsCommentModel.userName;
    self.commentLabel.text = goodsCommentModel.content;
    self.dateLabel.text = goodsCommentModel.commentTime;
    
    //
    [self.commentImageViews enumerateObjectsUsingBlock:^(UIImageView * _Nonnull commentImageView, NSUInteger idx, BOOL * _Nonnull stop) {
        
        HJCommentimagelistModel *imageModel = [goodsCommentModel.commentImageList objectOrNilAtIndex:idx];
        
        if (imageModel) {
            
            commentImageView.hidden = NO;
            
            [commentImageView lh_setImageWithImagePartUrlString:imageModel.imageName placeholderImage:[UIImage imageNamed:@"icon_shoplist_default"]];
            
        }else {
            
            commentImageView.hidden = YES;

        }
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
