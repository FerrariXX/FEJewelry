//
//  JEUserInfoModifyModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JEUserInfoModel.h"

@interface JEUserInfoModifyModel : NSObject

@property (nonatomic, strong) JEUserInfoItem  *userInfoItem;
@property (nonatomic, strong)NSString  *result;
- (void)updateNikeName:(NSString*)nikeName completion:(JECompletionBlock)block;
- (void)updateMicroMessageID:(NSString*)microMessageID completion:(JECompletionBlock)block;
@end
