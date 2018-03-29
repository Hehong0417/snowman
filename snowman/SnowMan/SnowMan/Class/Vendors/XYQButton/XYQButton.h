//
//  MyButton.h
//  逛啊
//
//  Created by zhipeng-mac on 15/10/10.
//  Copyright (c) 2015年 mabo. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FontAttributes : NSObject

@property (nonatomic, strong) UIColor *fontColor;
@property (nonatomic, unsafe_unretained) CGFloat fontsize;
@property (nonatomic, strong) UIFont *font;

+ (instancetype)fontAttributesWithFontColor:(UIColor *)fontColor fontsize:(CGFloat)fontsize;

@end

@interface XYQButton : UIButton

typedef NS_ENUM(NSInteger, ContentType){
    
   LeftImageRightTitle,
   TopImageBottomTitle,
   LeftTitleRightImage,
    
};

typedef NS_ENUM(NSInteger, AligmentType){
    
    AligmentTypeLeft,
    AligmentTypeCenter,
    AligmentTypeRight,
};


-(void)setTitleRectForContentRect:(CGRect)titleRect
          imageRectForContentRect:(CGRect)imageRect;

+ (XYQButton *)ButtonWithFrame:(CGRect)frame imgaeName:(NSString *)imageName titleName:(NSString *)titleName contentType:(ContentType)contentType buttonFontAttributes:(FontAttributes *)fontAttributes aligmentType:(AligmentType)aligmentType tapAction:(void (^)(XYQButton *button))tapAction;

@end
