//
//  HJExitLoginView.h
//  Enjoy
//
//  Created by 邓朝文 on 16/5/11.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJExitLoginView : UIView
@property (weak, nonatomic) IBOutlet UIView *baseView;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIButton *certanButton;
@property (weak, nonatomic) IBOutlet UILabel *warnLabel;
- (IBAction)cancelClick:(id)sender;
- (IBAction)certanClick:(id)sender;
@property (nonatomic, copy) voidBlock certanBlock;
+ (instancetype)exitLoginView;
+ (instancetype)exitLoginViewWithWarnTitle:(NSString *)warnTitle;
@end
