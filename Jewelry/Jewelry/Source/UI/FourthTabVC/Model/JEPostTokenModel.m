//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEPostTokenModel.h"


@interface JEPostTokenModel()
@end

@implementation JEPostTokenModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (void)postDeviceToken {
    
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@POSTKey", kBaseURLString];
    AFHTTPClient *httpClient = [[AFHTTPClient alloc] initWithBaseURL:[NSURL URLWithString:@""]];
    httpClient.parameterEncoding = AFJSONParameterEncoding;
    [httpClient setDefaultHeader:@"Accept" value:@"text/json"];
    //post json
    NSMutableDictionary *params=[[NSMutableDictionary alloc] init];
    [params setObject:_deviceToken forKey:@"key"];
    
    [httpClient postPath:urlStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
    }];
}

@end
