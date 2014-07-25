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

- (void)updateAvatarURL:(NSString*)imagePath completion:(JECompletionBlock)block {
    
    AFHTTPClient *uploadFileClient = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:[NSMutableString stringWithFormat:@"http://60.191.108.245:33681/UserAvatar.ashx"]]];
    NSString  *path = [NSString stringWithFormat:@"userID=%@",[[FEAccountManager shareInstance] account]];
    NSMutableURLRequest *fileUpRequest = [uploadFileClient multipartFormRequestWithMethod:@"POST" path:path parameters:nil constructingBodyWithBlock:^(id formData) {
        
//        [formData appendPartWithFileData:[NSData dataWithContentsOfFile:imagePath] name:@"RequestStream" fileName:@"file.jpg" mimeType:@"image/png"];
        [formData appendPartWithFileData:UIImageJPEGRepresentation([UIImage imageWithContentsOfFile:imagePath], 0.5) name:@"image1" fileName:@"image1.jpg" mimeType:@"image/jpeg"];
    }];
    
    AFImageRequestOperation *imageOperation = [AFImageRequestOperation imageRequestOperationWithRequest:fileUpRequest imageProcessingBlock:nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        NSDictionary *dictResult = (NSDictionary*)response;
        NSLog(@"%@",dictResult);
        if (block) {
            block(YES);
        }
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        if (block) {
            block(NO);
        }
    }];
    
//    __weak __typeof(self) weakSelf = self;
//    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:fileUpRequest success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
//        NSDictionary *dictResult = (NSDictionary*)JSON;
//        NSLog(@"%@",dictResult);
////        weakSelf.userInfoItem = [[JEUserInfoItem alloc] initWithDictionary:dictResult];
//        if (block) {
//            block(YES);
//        }
//        
//    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
//        if (block) {
//            block(NO);
//        }
//    }];
    [imageOperation start];
//
//
    
//         AFHTTPRequestOperation *op = [[AFHTTPRequestOperation alloc] initWithRequest:fileUpRequest];
//    
//         [op setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
//                 NSLog(@"上传完成");
//             } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
//                     NSLog(@"上传失败->%@", error);
//                 }];
//    
//        //执行
//        [uploadFileClient.operationQueue addOperation:op];
}

- (void)updateNikeName:(NSString*)nikeName completion:(JECompletionBlock)block {
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@SetUserNickName/%@/%@",kBaseURLString,[[FEAccountManager shareInstance] account],nikeName];
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
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@SetUserMicroMessageID/%@/%@", kBaseURLString,[[FEAccountManager shareInstance] account],microMessageID];
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
