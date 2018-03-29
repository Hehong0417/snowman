//
//  HJStoryBoardItem.m
//  Apws
//
//  Created by zhipeng-mac on 15/12/21.
//  Copyright (c) 2015年 hejing. All rights reserved.
//

#import "HJStoryBoardItem.h"

@implementation HJStoryBoardItem

+ (instancetype)itemWithStroyBoardName:(NSString *)storyBoardName identifier:(NSString *)identifier viewControllerExist:(BOOL)viewControllerExist {
    
    HJStoryBoardItem *item = [[HJStoryBoardItem alloc]init];
    
    item.storyBoardName = storyBoardName;
    item.identifier = identifier;
    item.viewControllerExist = viewControllerExist;
    
    return item;
}

- (UIViewController *)correspondingViewController {
    
    UIViewController *controller = nil;
    
    if (!self.viewControllerExist) {
        
        controller = (UIViewController *)[[NSClassFromString(self.identifier) alloc]init];
        
        return controller;
    }
    
    controller = [UIViewController lh_createFromStoryboardName:self.storyBoardName WithIdentifier:self.identifier];
    
    return controller;
}

@end
