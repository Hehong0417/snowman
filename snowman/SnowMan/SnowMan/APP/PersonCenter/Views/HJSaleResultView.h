//
//  HJSaleResultView.h
//  SnowMan
//
//  Created by 邓朝文 on 16/5/19.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJSaleResultView : UIView
@property (weak, nonatomic) IBOutlet UIButton *backButton;
@property (weak, nonatomic) IBOutlet UILabel *orderNoLabel;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *warnLabel;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

@property (nonatomic, assign) HJResultType resultType;
@property (nonatomic, copy) NSString *score;

+ (instancetype)saleResultView;
@end
