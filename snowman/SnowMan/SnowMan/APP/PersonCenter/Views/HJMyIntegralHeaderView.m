//
//  HJMyintegralHeaderView.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJMyIntegralHeaderView.h"
#import "HJScoreAPI.h"

@interface HJMyIntegralHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *integralLabel;

@end

@implementation HJMyIntegralHeaderView
+ (instancetype)myIntegralHeaderView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"HJMyIntegralHeaderView" owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    
}

- (void)setScorceModel:(HJScoreModel *)scorceModel
{
    _scorceModel = scorceModel;
    self.integralLabel.text = [NSString stringWithFormat:@"%d", scorceModel.scoreTotal];
}


@end
