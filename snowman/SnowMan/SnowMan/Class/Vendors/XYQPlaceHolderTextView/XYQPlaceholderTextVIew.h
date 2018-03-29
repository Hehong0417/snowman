//
//  XYQPlaceHolderTextVIew.h
//  Transport
//
//  Created by zhipeng-mac on 15/12/9.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XYQPlaceholderTextVIew : UITextView <UITextViewDelegate>

@property (nonatomic, retain) NSString *placeholder;
@property (nonatomic, retain) UIColor *placeholderColor;

-(void)textChanged:(NSNotification*)notification;

@end
