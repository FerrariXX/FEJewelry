//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEUserInfoModel.h"

@implementation JEUserInfoItem
- (instancetype)initWithDictionary:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            self.avatarURL     = [dict objectForKey:@"avatarURL"];
            self.nickName       = [dict objectForKey:@"nickName"];
            self.userID     = [dict objectForKey:@"userID"];
            self.microMessageID  =  [dict objectForKey:@"microMessageID"];
            self.salesPromotionURL = [dict objectForKey:@"salesPromotionURL"];
        }
    }
    return self;
}
@end


@interface JEUserInfoModel()
@end

@implementation JEUserInfoModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadUserInfo:(NSString*)userID completion:(JECompletionBlock)block {
    
    __weak __typeof(self) weakSelf = self;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@GetUserInfo/%@", kBaseURLString,userID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *dictJson = (NSDictionary*)JSON;
        weakSelf.userInfo = [[JEUserInfoItem alloc] initWithDictionary:dictJson];
        if (block) {
            block(YES);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (block) {
            block(NO);
        }
    }];
    [operation start];
}

@end
