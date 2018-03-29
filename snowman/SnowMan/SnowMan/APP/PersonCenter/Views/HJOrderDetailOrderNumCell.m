//
//  HJOrderDetailOrderNumCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJOrderDetailOrderNumCell.h"

@interface HJOrderDetailOrderNumCell ()

@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;

@end

@implementation HJOrderDetailOrderNumCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.orderNoLabel.lh_headBaseString = @"订单编号：";
}

- (void)setOrderNo:(NSString *)orderNo {
    
    _orderNo = orderNo;
    
    [self.orderNoLabel lh_headBaseStringAddString:orderNo];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
