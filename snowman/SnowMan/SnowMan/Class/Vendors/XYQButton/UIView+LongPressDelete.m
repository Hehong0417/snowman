//
//  UIView+LongPressDelete.m
//  Transport
//
//  Created by zhipeng-mac on 15/12/11.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "UIView+LongPressDelete.h"
#import "XYQButton.h"

@implementation UIView (LongPressDelete)

#define kDeleteButtonSize 36

- (void)longPressDeleteWhenTapDelete:(DeleteBlock)deleteBlock{
    
    WS(weakSelf);
    
    [self lh_setLongPressActionWithBlock:^{
        
        XYQButton *deleteButton=[XYQButton ButtonWithFrame:CGRectMake(weakSelf.lh_width-kDeleteButtonSize, 0, kDeleteButtonSize, kDeleteButtonSize) imgaeName:@"ic_shanchu" titleName:@"" contentType:TopImageBottomTitle buttonFontAttributes:nil aligmentType:AligmentTypeCenter tapAction:^(XYQButton *button) {
            
            !deleteBlock?:deleteBlock();
        }];
        CGFloat image_size = deleteButton.imageView.image.size.width;
        
        [deleteButton setTitleRectForContentRect:CGRectZero imageRectForContentRect:CGRectMake(deleteButton.lh_width-image_size,0, image_size, image_size)];
        
//        [deleteButton setBackgroundColor:[UIColor redColor]];

        [weakSelf addSubview:deleteButton];
     
    }];
}

@end
