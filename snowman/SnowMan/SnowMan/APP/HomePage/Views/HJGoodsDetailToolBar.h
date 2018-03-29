//
//  HJGoodsDetailToolBar.h
//  Apws
//
//  Created by zhipeng-mac on 15/12/24.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

FOUNDATION_EXPORT NSString * const kJoinGoodsOrder;
FOUNDATION_EXPORT NSString * const kBuyRightNow;

@protocol ContactCustomerdelegate<NSObject>
-(void)pushChatVC:(NSString *)phone and:(NSString *)name;
@end

@interface HJGoodsDetailToolBar : UIView

@property (nonatomic, strong) id<ContactCustomerdelegate>delegate;

@property (nonatomic, strong) NSString *goodsTotalPrice;

@property (nonatomic, copy) idBlock tapHandler;

@end
