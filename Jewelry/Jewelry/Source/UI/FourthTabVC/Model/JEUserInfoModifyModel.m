//
//  JEUserInfoModifyModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEUserInfoModifyModel.h"


@interface JEUserInfoModifyModel()
@end

@implementation JEUserInfoModifyModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)updateNikeName:(NSString*)nikeName completion:(JECompletionBlock)block {
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@SetUserNickName/0001/%@", kBaseURLString,nikeName];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    __weak __typeof(self) weakSelf = self;
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *dictResult = (NSDictionary*)JSON;
        weakSelf.userInfoItem = [[JEUserInfoItem alloc] initWithDictionary:dictResult];
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
- (void)updateMicroMessageID:(NSString*)microMessageID completion:(JECompletionBlock)block {
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@SetUserMicroMessageID/0001/%@", kBaseURLString,microMessageID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    __weak __typeof(self) weakSelf = self;
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *dictResult = (NSDictionary*)JSON;
        weakSelf.userInfoItem = [[JEUserInfoItem alloc] initWithDictionary:dictResult];
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
