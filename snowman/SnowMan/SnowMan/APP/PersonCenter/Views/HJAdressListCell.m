//
//  HJAdressListCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/15.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJAdressListCell.h"

@interface HJAdressListCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *editViewHeightCons;
@property (weak, nonatomic) IBOutlet UILabel *recievePersonLabel;
@property (weak, nonatomic) IBOutlet UILabel *recieveAddressLabel;
@property (weak, nonatomic) IBOutlet UILabel *recievePhoneLabel;
@property (weak, nonatomic) IBOutlet UIView *editView;
@property (weak, nonatomic) IBOutlet UIImageView *topMarginView;
@property (weak, nonatomic) IBOutlet UIImageView *bottomMarginView;
@property (weak, nonatomic) IBOutlet UIImageView *arrowView;

@property (nonatomic, weak) UILabel *defaultLabel;

@end

@implementation HJAdressListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    //默认不可以编辑
    self.editView.hidden = YES;
    
    self.topMarginView.hidden = YES;
    self.bottomMarginView.hidden = YES;
    self.arrowView.hidden = YES;
    
    //默认是无内容的cell
    [self setAddressModel:nil];
    
}

- (void)setCanEdit:(BOOL)canEdit {
    
    self.editView.hidden = !canEdit;
}

- (void)setShowDefault:(BOOL)showDefault
{
    _showDefault = showDefault;
    
    self.defaultLabel.hidden = !showDefault;
}

- (void)setShowMarginView:(BOOL)showMarginView
{
    _showMarginView = showMarginView;
    self.topMarginView.hidden = !showMarginView;
    self.bottomMarginView.hidden = !showMarginView;
    self.arrowView.hidden = !showMarginView;
}

- (void)setAddressModel:(HJRecieptAddressModel *)addressModel {
    
    _addressModel = addressModel;
    
    self.recievePersonLabel.text = [NSString stringWithFormat:@"收货人：%@",addressModel.userName?:kEmptySrting];
    CGSize size = [self.recievePersonLabel.text lh_sizeWithFont:FONT(16) constrainedToSize:CGSizeMake(MAXFLOAT, 44)];
    
    [self.defaultLabel removeFromSuperview];
    if (addressModel.type) {
        UILabel *defaultLabel = [UILabel lh_labelWithFrame:CGRectMake(size.width + 30, 25, 40, 20) text:@"默认" textColor:kWhiteColor font:FONT(17) textAlignment:NSTextAlignmentCenter backgroundColor:RGB(73, 110, 161)];
        [self.contentView addSubview:defaultLabel];
        self.defaultLabel = defaultLabel;
        defaultLabel.layer.cornerRadius = 3.0f;
        defaultLabel.layer.masksToBounds = YES;
    } 
    
    if (addressModel.areaName.length) {
        self.recieveAddressLabel.text = [NSString stringWithFormat:@"收货地址：%@%@", addressModel.areaName, [addressModel.address lh_notNilString]];
    } else {
        self.recieveAddressLabel.text = [NSString stringWithFormat:@"收货地址:%@", addressModel.address?:kEmptySrting];
    }
    self.recievePhoneLabel.text = [NSString stringWithFormat:@"联系电话：%@",addressModel.phone?:kEmptySrting];
        
    self.defaultAddressButton.selected = addressModel.type;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
