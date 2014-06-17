//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JECollectionModel.h"

@implementation JECollectionItem
- (instancetype)initWithDictionary:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            self.name     = [dict objectForKey:@"name"];
            self.numberID       = [dict objectForKey:@"numberID"];
            self.price         = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"price"] floatValue]];
        }
    }
    return self;
}

@end


@interface JECollectionModel()
@property(nonatomic, assign)NSInteger pageNumber;
@end

@implementation JECollectionModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        _collectionList = [[NSMutableArray alloc] initWithCapacity:1];
    }
    return self;
}

- (void)loadCollectionList:(NSString*)userId completion:(JECompletionBlock)block {
    __weak __typeof(self) weakSelf = self;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@GetIntegrationInfo/%@", kBaseURLString,userId];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSArray *jsonArray = (NSArray*)JSON;
        for (NSDictionary * collectionItem  in jsonArray) {
            JECollectionItem * listItem = [[JECollectionItem alloc] initWithDictionary:collectionItem];
            [weakSelf.collectionList addObject:listItem];
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
