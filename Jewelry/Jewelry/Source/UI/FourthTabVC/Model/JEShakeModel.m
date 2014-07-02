//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEShakeModel.h"

@implementation JEShakeItem
- (instancetype)initWithDictionary:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            self.isLottery     = [dict objectForKey:@"isLottery"];
            self.lotteryMessage = [dict objectForKey:@"lotteryMessage"];
        }
    }
    return self;
}

@end


@interface JEShakeModel()
@end

@implementation JEShakeModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)shakeOffAction:(NSString*) userId completion:(JECompletionBlock)block {
    __weak __typeof(self) weakSelf = self;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@SharkItOff/%@", kBaseURLString,userId];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *dictJson = (NSDictionary*)JSON;
        weakSelf.shakeItem = [[JEShakeItem alloc] initWithDictionary:dictJson];
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
