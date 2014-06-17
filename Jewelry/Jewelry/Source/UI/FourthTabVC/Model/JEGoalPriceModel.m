//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEGoalPriceModel.h"

@implementation JEGoalPriceItem
- (instancetype)initWithDictionary:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            self.name     = [dict objectForKey:@"name"];
            self.price         = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"price"] floatValue]];
        }
    }
    return self;
}

@end


@interface JEGoalPriceModel()
@end

@implementation JEGoalPriceModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _goldListArray = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (void)loadGoldListArray:(JECompletionBlock)block {
    __weak __typeof(self) weakSelf = self;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@GetGoldPrices", kBaseURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *jsonArray = (NSArray*)JSON;
        for (NSDictionary * dict  in jsonArray) {
            JEGoalPriceItem * goalPrice = [[JEGoalPriceItem alloc] initWithDictionary:dict];
            [weakSelf.goldListArray addObject:goalPrice];
        }
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
