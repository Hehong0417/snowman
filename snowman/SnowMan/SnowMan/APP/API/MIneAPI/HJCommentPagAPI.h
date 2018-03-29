//
//  HJCommentPagAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJOrderCommentModel;
@interface HJCommentPagAPI : HJBaseAPI
@property (nonatomic, strong) NSArray *data;
+ (instancetype)commentPag_orderId:(NSNumber *)orderId;
@end

@interface HJOrderCommentModel : HJBaseModel
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, assign) NSInteger isComment;
@property (nonatomic, copy) NSString *goodsIco;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSArray *imageList;
@end

@interface HJImageListModel : HJBaseModel
@property (nonatomic, assign) NSInteger Id;
@property (nonatomic, copy) NSString *imageName;


@end



