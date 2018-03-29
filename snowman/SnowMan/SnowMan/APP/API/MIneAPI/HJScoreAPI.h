//
//  HJScoreAPI.h
//  SnowMan
//
//  Created by Pro on 16/5/9.
//  Copyright © 2016年 hejing. All rights reserved.
//

#import "HJBaseAPI.h"

@class HJScoreModel;
@interface HJScoreAPI : HJBaseAPI
@property (nonatomic, strong) HJScoreModel *data;
+ (instancetype)score_page:(NSNumber *)page rows:(NSNumber *)rows;

@end

@interface HJScoreModel : HJBaseModel
@property (nonatomic, assign) NSInteger scoreTotal;
@property (nonatomic, strong) NSArray *scoreList;
@end

@interface HJScoreListModel : HJBaseModel
@property (nonatomic, copy) NSString *score;
@property (nonatomic, copy) NSString *scoreType;
@property (nonatomic, copy) NSString *scoreMessage;
@end
