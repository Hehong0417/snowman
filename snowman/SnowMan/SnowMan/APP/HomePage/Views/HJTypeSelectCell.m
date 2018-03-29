//
//  HJTypeSelectCell.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/11.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJTypeSelectCell.h"

@interface HJTypeSelectCell ()

@property (weak, nonatomic) IBOutlet UIButton *firstItemButton;
@property (weak, nonatomic) IBOutlet UIButton *secondItemButton;
@property (weak, nonatomic) IBOutlet UIButton *thirdItemButton;
@property (nonatomic, strong) NSArray <UIButton *> *itemButtons;

@end

@implementation HJTypeSelectCell

- (void)awakeFromNib {
    
    [super awakeFromNib];
    // Initialization code
    self.firstItemButton.tag = 0;
    self.secondItemButton.tag = 1;
    self.thirdItemButton.tag = 2;
    
    self.itemButtons = @[_firstItemButton,_secondItemButton,_thirdItemButton];
    

}

- (void)setTypeArray:(NSArray<HJGoodsIntroduceStandardlistModel *> *)typeArray {
    
    if (typeArray != _typeArray) {
        
    _typeArray = typeArray;

    //规格数量多少来显示按钮多少
    [self.itemButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        
        if (idx < typeArray.count) {
            obj.hidden = NO;
        } else {
            
            obj.hidden = YES;
        }
    }];
    
    [typeArray enumerateObjectsUsingBlock:^(HJGoodsIntroduceStandardlistModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        UIButton *button = [self.itemButtons objectOrNilAtIndex:idx];
        [button setTitle:obj.standardName forState:UIControlStateNormal];
        
        if (obj.unitName.length>0) {
            
            button.hidden = YES;
        }
    }];
        
        //默认选中第一个规格size
        [self.firstItemButton setBackgroundColor:kOrangeColor];
        self.selectStandardName = self.firstItemButton.titleLabel.text;
    }
    
    

}

- (IBAction)selectStandardAction:(id)sender {
    
    UIButton *selectButton = sender;
    
    //点击按钮颜色改变
    [self.itemButtons enumerateObjectsUsingBlock:^(UIButton * _Nonnull button, NSUInteger idx, BOOL * _Nonnull stop) {
       
        if (selectButton == button) {
            
            [button setBackgroundColor:kOrangeColor];

        } else {
            
            [button setBackgroundColor:RGB(234, 234, 234)];
        }
        
    }];
    
    //选择规格值size
    self.selectStandardName = selectButton.titleLabel.text;
    
    //选择不同规格型号数据源更改
    !self.selectStandardSizeHandler?:self.selectStandardSizeHandler(sender);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
