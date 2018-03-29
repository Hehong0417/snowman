//
//  LjjUIsegumentViewController.m
//  HappyHall
//
//  Created by 李佳佳 on 15/6/30.
//  Copyright (c) 2015年 rencong. All rights reserved.
//
//

#import "LjjUISegmentedControl.h"
#import "XYQButton.h"

@interface LjjUISegmentedControl ()<LjjUISegmentedControlDelegate>

{
    CGFloat witdFloat;
    UIView* buttonDown;
    NSInteger selectSeugment;
    CGFloat buttonDownWidth;
}

@end

@implementation LjjUISegmentedControl
-(void)AddSegumentArray:(NSArray *)SegumentArray
{
    
    [self removeAllSubviews];
    
    switch (self.segmentControllType) {
        case LjjUISegmentControlTypeDefault: {
            {
                //*****
                NSInteger seugemtNumber=SegumentArray.count;
                witdFloat=(self.bounds.size.width)/seugemtNumber;
                for (int i=0; i<SegumentArray.count; i++) {
                    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*witdFloat, 0, witdFloat, self.bounds.size.height-2)];
                    [button setTitle:SegumentArray[i] forState:UIControlStateNormal];
                    //        NSLog(@"这里defont%@",[button.titleLabel.font familyName]);
                    
                    [button.titleLabel setFont:self.titleFont];
                    [button setTitleColor:self.titleColor forState:UIControlStateNormal];
                    [button setTitleColor:self.selectColor forState:UIControlStateSelected];
                    [button addTarget:self action:@selector(changeTheSegument:) forControlEvents:
                     UIControlEventTouchUpInside];
                    WEAK_SELF();
                    button = [XYQButton ButtonWithFrame:CGRectMake(i*witdFloat, 0, witdFloat, self.bounds.size.height-2) imgaeName:@"ic_sanjiao" titleName:SegumentArray[i] contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:self.titleColor fontsize:self.titleFont.pointSize] aligmentType:AligmentTypeCenter tapAction:^(XYQButton *button) {
                        
                        [weakSelf changeTheSegument:button];
                        
                    }];
                    
                    //        [button setBackgroundColor:[UIColor redColor]];
                    button.lh_centerX = witdFloat*i + 0.5*witdFloat;
                    [button setTag:i];
                    if (i==0) {
                        buttonDown=[[UIView alloc]initWithFrame:CGRectMake(i*witdFloat, self.bounds.size.height-2, witdFloat, 2)];
                        [buttonDown setBackgroundColor:self.lineColor];
                        [self addSubview:buttonDown];
                    }
                    [self addSubview:button];
                    [self.ButtonArray addObject:button];
                }
                [[self.ButtonArray firstObject] setSelected:YES];
                //*****
                
            }
            break;
        }
        case LjjUISegmentControlTypePattern1: {
            {
                //*****
                NSInteger seugemtNumber=SegumentArray.count;
                witdFloat=(self.bounds.size.width)/seugemtNumber;
                for (int i=0; i<SegumentArray.count; i++) {
                    UIButton* button=[[UIButton alloc]initWithFrame:CGRectMake(i*witdFloat, 0, witdFloat, self.bounds.size.height-2)];
                    [button setTitle:SegumentArray[i] forState:UIControlStateNormal];
                    //        NSLog(@"这里defont%@",[button.titleLabel.font familyName]);
                    
                    [button.titleLabel setFont:self.titleFont];
                    [button setTitleColor:self.titleColor forState:UIControlStateNormal];
                    [button setTitleColor:self.selectColor forState:UIControlStateSelected];
                    [button addTarget:self action:@selector(changeTheSegument:) forControlEvents:
                     UIControlEventTouchUpInside];
                    WEAK_SELF();
                    button = [XYQButton ButtonWithFrame:CGRectMake(i*witdFloat, 0, witdFloat, self.bounds.size.height-2) imgaeName:@"ic_sanjiao" titleName:SegumentArray[i] contentType:LeftTitleRightImage buttonFontAttributes:[FontAttributes fontAttributesWithFontColor:self.titleColor fontsize:self.titleFont.pointSize] aligmentType:AligmentTypeCenter tapAction:^(XYQButton *button) {
                        
                        [weakSelf changeTheSegument:button];
                        
                    }];
                    
                    //        [button setBackgroundColor:[UIColor redColor]];
                    button.lh_centerX = witdFloat*i + 0.5*witdFloat;
                    [button setTag:i];
                    //
                    buttonDownWidth = button.bounds.size.width+40;
                    if (i==0) {
                        buttonDown=[[UIView alloc]initWithFrame:CGRectMake(i*button.bounds.size.width, self.bounds.size.height-2, buttonDownWidth, 2)];
                        buttonDown.center = CGPointMake(button.center.x, buttonDown.center.y);
                        [buttonDown setBackgroundColor:self.lineColor];
                        [self addSubview:buttonDown];
                    }
                    [self addSubview:button];
                    [self.ButtonArray addObject:button];
                    
                    //添加竖分割线
                    CGFloat margin = 10.0f;
                    UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(witdFloat, margin, 1.0, self.frame.size.height-2*margin)];
                    [lineView setBackgroundColor:[UIColor lightGrayColor]];
                    [self addSubview:lineView];
                }
                [[self.ButtonArray firstObject] setSelected:YES];
                //*****
            }
            break;
        }
    }
    
}
-(void)changeTheSegument:(UIButton*)button
{
    [self selectTheSegument:button.tag];
    
}
-(void)selectTheSegument:(NSInteger)segument
{
    //
    switch (self.segmentControllType) {
        case LjjUISegmentControlTypeDefault: {
            {
                //*****
                if (selectSeugment!=segument) {
                    //        NSLog(@"我点击了");
                    [self.ButtonArray[selectSeugment] setSelected:NO];
                    [self.ButtonArray[segument] setSelected:YES];
                    [UIView animateWithDuration:0.3 animations:^{
                        [buttonDown setFrame:CGRectMake(segument*witdFloat,self.bounds.size.height-2, witdFloat, 2)];
                    }];
                    selectSeugment=segument;
                    [self.delegate uisegumentSelectionChange:selectSeugment];
                }
                //*****
            }
            break;
        }
        case LjjUISegmentControlTypePattern1: {
            {
              //*****
                if (selectSeugment!=segument) {
                    //        NSLog(@"我点击了");
                    [self.ButtonArray[selectSeugment] setSelected:NO];
                    UIButton *slectedButton = self.ButtonArray[segument];
                    [slectedButton setSelected:YES];
                    [UIView animateWithDuration:0.3 animations:^{
                        [buttonDown setFrame:CGRectMake(segument*slectedButton.bounds.size.width, self.bounds.size.height-2, buttonDownWidth, 2)];
                        buttonDown.center = CGPointMake(slectedButton.center.x, buttonDown.center.y);
                    }];
                    selectSeugment=segument;
                    [self.delegate uisegumentSelectionChange:selectSeugment];
                }
              //*****
            }
            break;
        }
    }
    
}

-(instancetype)initWithFrame:(CGRect)frame
{
    self.ButtonArray=[NSMutableArray array];
    selectSeugment=0;
    self.titleFont=[UIFont fontWithName:@".Helvetica Neue Interface" size:14.0f];
    self=[super initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, frame.size.width, frame.size.height)];
    self.LJBackGroundColor=[UIColor colorWithRed:253.0f/255 green:239.0f/255 blue:230.0f/255 alpha:1.0f];
    self.titleColor=[UIColor colorWithRed:77.0/255 green:77.0/255 blue:77.0/255 alpha:1.0f];
    self.selectColor=[UIColor colorWithRed:233.0/255 green:97.0/255 blue:31.0/255 alpha:1.0f];
    [self setBackgroundColor:self.LJBackGroundColor];
    return self;
}
//-(void)addTarget:(id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents
//{
//    UISegmentedControl* sgement=[[UISegmentedControl alloc]init];
//    [sgement addTarget:target action:action forControlEvents:controlEvents];
//}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
