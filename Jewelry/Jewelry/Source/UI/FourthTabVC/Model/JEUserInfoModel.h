//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEUserInfoItem : NSObject
@property(nonatomic, strong)NSString* avatarURL; //头像
@property(nonatomic, strong)NSString* nickName;  //昵称
@property(nonatomic, strong)NSString* userID;  //我的帐号
@property(nonatomic, strong)NSString* microMessageID; //微信号
@property(nonatomic, strong)NSString* salesPromotionURL;//促销url
- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@interface JEUserInfoModel : NSObject
@property(nonatomic, strong)JEUserInfoItem *userInfo;
- (void)loadUserInfo:(NSString*)userID completion:(JECompletionBlock)block;

@end
