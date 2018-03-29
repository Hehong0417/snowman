//
//  HJSeachCVC.h
//  Cancer
//
//  Created by IMAC on 16/2/15.
//  Copyright (c) 2016年 hejing. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger,HJSearchType ){
    HJSearchTypePressDown =0,
    HJSearchTypePressUp,
};

@interface HJSeachCVC : UICollectionViewController

@property (nonatomic, assign) HJSearchType HJSearchType;

@end
