//
//  HJGoodsCommentAPI.m
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJGoodsCommentAPI.h"

@implementation HJGoodsCommentAPI

+ (instancetype)goodsComment_goodsId:(NSString *)goodsId page:(NSNumber *)page rows:(NSNumber *)rows {
    HJGoodsCommentAPI * api = [self new];
    [api.parameters setObject:goodsId forKey:@"goodsId"];
    [api.parameters setObject:page forKey:@"page"];
    [api.parameters setObject:rows forKey:@"rows"];
    api.subUrl = API_GOODS_COMMENT;
    return api;

}

+ (NSDictionary *)objectClassInArray{
    return @{@"data" : [HJGoodsCommentModel class]};
}
@end

@implementation HJGoodsCommentModel

+ (NSDictionary *)objectClassInArray{
    return @{@"commentImageList" : [HJCommentimagelistModel class]};
}

- (void)mj_keyValuesDidFinishConvertingToObject {
    
    self.hasCommentImageList = self.commentImageList.count>0?YES:NO;
}

@end


@implementation HJCommentimagelistModel

@end


