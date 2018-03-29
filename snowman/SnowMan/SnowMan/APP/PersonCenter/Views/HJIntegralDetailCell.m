//
//  HJIntegralDetailCell.m
//  SnowMan
//
//  Created by 邓朝文 on 16/5/16.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJIntegralDetailCell.h"
#import "HJScoreAPI.h"

@interface HJIntegralDetailCell ()
@property (weak, nonatomic) IBOutlet UILabel *consumeTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *consumeNumberLabel;


@end
@implementation HJIntegralDetailCell

+ (instancetype)cellWithTableView:(UITableView *)tableView
{
    static NSString *ID = @"integralDetailCell";
    HJIntegralDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"HJIntegralDetailCell" owner:nil options:nil] lastObject];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)setScoreListModel:(HJScoreListModel *)scoreListModel
{
    _scoreListModel = scoreListModel;
    self.consumeTypeLabel.text = scoreListModel.scoreMessage;
    if ([scoreListModel.scoreType isEqualToString:@"0"]) {
        self.consumeNumberLabel.text = [NSString stringWithFormat:@"+%@", scoreListModel.score];
    } else {
        self.consumeNumberLabel.text = [NSString stringWithFormat:@"-%@", scoreListModel.score];
    }
}

- (void)awakeFromNib {
}

@end
