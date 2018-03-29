//
//  HJAfterContentCell.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/27.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAfterContentCell.h"
#import "HJAfterSalesInfoAPI.h"

@interface HJAfterContentCell ()
@property (weak, nonatomic) IBOutlet UILabel *refundNoLabel;
@property (weak, nonatomic) IBOutlet UITextView *contentTextView;

@end

@implementation HJAfterContentCell

- (void)awakeFromNib {
    self.contentTextView.layer.cornerRadius = kSmallCornerRadius;
    self.contentView.userInteractionEnabled = NO;
}

- (void)setAfterSalesInfoModel:(HJAfterSalesInfoModel *)afterSalesInfoModel
{
    _afterSalesInfoModel = afterSalesInfoModel;
    self.refundNoLabel.text = [NSString stringWithFormat:@"售后编号：%@", afterSalesInfoModel.refundNo];
    self.contentTextView.text = afterSalesInfoModel.cause;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
