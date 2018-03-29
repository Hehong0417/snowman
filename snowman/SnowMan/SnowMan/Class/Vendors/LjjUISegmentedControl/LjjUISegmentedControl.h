//
//  LjjUIsegumentViewController.h
//  HappyHall
//
//  Created by 李佳佳 on 15/6/30.
//  Copyright (c) 2015年 rencong. All rights reserved.
//
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, LjjUISegmentControlType){
    
    LjjUISegmentControlTypeDefault = 0,
    LjjUISegmentControlTypePattern1,
};


@protocol LjjUISegmentedControlDelegate< NSObject>

@optional
-(void)uisegumentSelectionChange:(NSInteger)selection;

@end

@interface LjjUISegmentedControl : UIView

@property(nonatomic,strong)id <LjjUISegmentedControlDelegate>delegate;

@property(nonatomic,unsafe_unretained)LjjUISegmentControlType segmentControllType;

@property(nonatomic,strong)NSMutableArray* ButtonArray;
@property(strong,nonatomic)UIColor* LJBackGroundColor;
@property(strong,nonatomic)UIColor* titleColor;
@property(strong,nonatomic)UIColor* selectColor;
@property(strong,nonatomic)UIColor* lineColor;
@property(strong,nonatomic)UIFont* titleFont;

-(void)AddSegumentArray:(NSArray *)SegumentArray;
-(instancetype)initWithFrame:(CGRect)frame;
-(void)selectTheSegument:(NSInteger)segument;

@end

