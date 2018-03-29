//
//  HJStoryBoardItem.h
//  Apws
//
//  Created by zhipeng-mac on 15/12/21.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HJStoryBoardItem : NSObject

@property (nonatomic, copy) NSString *storyBoardName;
@property (nonatomic, copy) NSString *identifier;

/**
 *  @author hejing
 *
 *  对应的控制器是否存在，默认为No,表示存在
 */
@property (nonatomic, unsafe_unretained) BOOL viewControllerExist;

+ (instancetype)itemWithStroyBoardName:(NSString *)storyBoardName identifier:(NSString *)identifier viewControllerExist:(BOOL)viewControllerExist;

- (UIViewController *)correspondingViewController;

@end
