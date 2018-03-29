//
//  HJClassifyHeaderTitleView.m
//  SnowMan
//
//  Created by zhipeng-mac on 16/5/5.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJClassifyHeaderTitleView.h"
#import "XYQButton.h"

@interface HJClassifyHeaderTitleView ()

@property (weak, nonatomic) IBOutlet UIView *contentView;

@end

@implementation HJClassifyHeaderTitleView

- (void)awakeFromNib {
    
    XYQButton *allClassButton = [XYQButton ButtonWithFrame:CGRectMake(kScreenWidth/3.0, 0, kScreenWidth/3.0, self.lh_height) imgaeName:@"ic_list_xia" titleName:@"全部类别" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kBlackColor fontsize:16] aligmentType:AligmentTypeCenter tapAction:^(XYQButton *button) {
        
        
    }];
                                 
    [allClassButton setImage:[UIImage imageNamed:@"ic_list_shang"] forState:UIControlStateSelected];
    
    [self.contentView addSubview:allClassButton];
    self.allClassItemButton = allClassButton;
    
    XYQButton *allBrandItemButton = [XYQButton ButtonWithFrame:CGRectMake(allClassButton.lh_right, 0, kScreenWidth/3.0, self.lh_height) imgaeName:@"ic_list_xia" titleName:@"全部品牌" contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:kBlackColor fontsize:16] aligmentType:AligmentTypeCenter tapAction:^(XYQButton *button) {
        
        
    }];
    [allBrandItemButton setImage:[UIImage imageNamed:@"ic_list_shang"] forState:UIControlStateSelected];
    
    [self.contentView addSubview:allBrandItemButton];
    self.allBrandItemButton = allBrandItemButton;
    
//    [self setButtonSelectedTitleColor:self.classItemButton];
//    [self setButtonSelectedTitleColor:self.allClassItemButton];
//    [self setButtonSelectedTitleColor:self.allBrandItemButton];
    
}

- (void)setButtonSelectedTitleColor:(UIButton *)button {
    
    [button setTitleColor:APP_COMMON_COLOR forState:UIControlStateSelected];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
