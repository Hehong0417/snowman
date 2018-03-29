//
//  HJGoodsCommentAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJGoodsCommentModel,HJCommentimagelistModel;
@interface HJGoodsCommentAPI : HJBaseAPI

@property (nonatomic, strong) NSArray<HJGoodsCommentModel *> *data;

+ (instancetype)goodsComment_goodsId:(NSString *)goodsId page:(NSNumber *)page rows:(NSNumber *)rows;

@end
@interface HJGoodsCommentModel : NSObject

@property (nonatomic, assign) NSInteger userId;

@property (nonatomic, copy) NSString *content;

@property (nonatomic, copy) NSString *userName;

@property (nonatomic, copy) NSString *commentTime;

@property (nonatomic, copy) NSString *userIco;

@property (nonatomic, strong) NSArray<HJCommentimagelistModel *> *commentImageList;

@property (nonatomic, assign) NSInteger commentId;

@property (nonatomic, assign) BOOL hasCommentImageList;

@end

@interface HJCommentimagelistModel : NSObject

@property (nonatomic, assign) NSInteger ID;

@property (nonatomic, copy) NSString *imageName;

@end

