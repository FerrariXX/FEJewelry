//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEMyPointsModel.h"

@implementation JEMyPointItem
- (instancetype)initWithDictionary:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            self.category     = [dict objectForKey:@"category"];
            self.value       = [dict objectForKey:@"value"];
            self.sourceID     = [dict objectForKey:@"sourceID"];
            self.time  =  [dict objectForKey:@"time"];
        }
    }
    return self;
}
@end


@interface JEMyPointsModel()
@end

@implementation JEMyPointsModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)loadMyPointList:(NSString*)userID completion:(JECompletionBlock)block {
    
    __weak __typeof(self) weakSelf = self;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@GetIntegrationInfo/%@", kBaseURLString,userID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *jsonArray = (NSArray*)JSON;
        for (NSDictionary * dict  in jsonArray) {
            JEMyPointItem * listItem = [[JEMyPointItem alloc] initWithDictionary:dict];
            [weakSelf.myPointList addObject:listItem];
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
