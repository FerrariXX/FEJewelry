//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEDetailModel.h"
#import "FEScrollPageView.h"

@implementation JEDetailListItem
- (instancetype)initWithDictionary:(NSDictionary*)dict;
{
    self = [super init];
    if (self) {
        self.numberID     = [dict objectForKey:@"numberID"];
        self.goodID       = [dict objectForKey:@"goodID"];
        self.size         = [dict objectForKey:@"size"];
        self.material     = [dict objectForKey:@"material"];
        self.totalWeight  = [dict objectForKey:@"totalWeight"];
        self.CTWeight     = [dict objectForKey:@"CTWeight"];
        self.price        = [dict objectForKey:@"price"];
    }
    return self;
}

@end
@implementation JEDetailModel
- (instancetype)initWithId:(NSString*)idNumber{
    self = [super init];
    if (self) {
        self.idNumber = idNumber;
        self.title  = @"千足金绿玉吊坠";
        self.price  = @"234324";
        self.category = @"黄金铂金》黄金吊坠";
        self.idNumber = @"1234243y2423";
        self.totalWeight  = @"1220克";
        self.masterWeight = @"100克";
        self.slaveWeight  = @"22克";
        self.address      = @"李四";
        self.phone        = @"18658199525";
        self.praiseCount  = @"10";
        [self initImagesArray];
        self.detailListArray = [NSMutableArray arrayWithCapacity:0];
        [self.detailListArray addObject:[[JEDetailListItem alloc] initWithDictionary:nil]];
        [self.detailListArray addObject:[[JEDetailListItem alloc] initWithDictionary:nil]];
        [self.detailListArray addObject:[[JEDetailListItem alloc] initWithDictionary:nil]];
        [self.detailListArray addObject:[[JEDetailListItem alloc] initWithDictionary:nil]];

    }
    return self;
}

//- (void)loadWithID:(NSString*)idNumber goodID:(NSString*)goodID deviceID:(NSString*)deviceID completion:(JECompletionBlock)block{
- (void)loadWithID:(NSString*)idNumber goodID:(NSString*)goodID completion:(JECompletionBlock)block{

    //TODO:
    NSString * deviceID = nil;//都要带上
    if (block) {
        block(YES);
    }
    return;

    

    __weak __typeof(self) weakSelf = self;//__typeof(&*self)
    NSString *urlStr = [NSString stringWithFormat:@"%@xxx", kBaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    
//    [[AFHTTPClient clientWithBaseURL:urlStr] postPath:<#(NSString *)#> parameters:<#(NSDictionary *)#> success:<#^(AFHTTPRequestOperation *operation, id responseObject)success#> failure:<#^(AFHTTPRequestOperation *operation, NSError *error)failure#>]
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *jsonDict = (NSDictionary*)JSON;
        weakSelf.images     = [jsonDict objectForKey:@"imageArray"];
        weakSelf.title      = [jsonDict objectForKey:@"name"];
        weakSelf.category   = [jsonDict objectForKey:@"category"];
        weakSelf.idNumber   = [jsonDict objectForKey:@"numberID"];
        weakSelf.totalWeight    = [jsonDict objectForKey:@"totalWeight"];
        weakSelf.masterWeight   = [jsonDict objectForKey:@"masterWeight"];
        weakSelf.slaveWeight    = [jsonDict objectForKey:@"slaveWeight"];
        weakSelf.address     = [jsonDict objectForKey:@"address"];
        weakSelf.phone       = [jsonDict objectForKey:@"servicePhone"];
        weakSelf.praiseCount = [jsonDict objectForKey:@"praiseCount"];
        NSArray *detailListArray = [jsonDict objectForKey:@"detailListArray"];
        for (NSDictionary * item  in detailListArray) {
            JEDetailListItem * listItem = [[JEDetailListItem alloc] initWithDictionary:item];
            [weakSelf.detailListArray addObject:listItem];
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];
    [operation start];
}

- (NSInteger)praiseWithNumberID:(NSString*)numberID{
    //TODO:
    return 0;
}

- (BOOL)favoriteWithUserID:(NSString*)userID numberID:(NSString*)numberID{
    //TODO:
    return YES;
}

#pragma mark - Private Method
- (void)initImagesArray{
    FEImageItem *item1 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:0];
    FEImageItem *item2 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:1];
    FEImageItem *item3 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:2];
    FEImageItem *item4 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:3];
    FEImageItem *item5 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:4];
    self.images = @[item1,item2,item3,item4,item5];
}

@end
