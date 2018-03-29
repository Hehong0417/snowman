//
//  HJSearchBar.h
//  SnowMan
//
//  Created by zhipeng-mac on 16/4/21.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HJSearchBar : UIView <UITextFieldDelegate>


@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UITextField *searchTextField;
@property (nonatomic, strong) voidBlock searchDoneHandler;

@end
