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
        if (dict && [dict isKindOfClass:[NSDictionary class]]) {
            self.numberID     = [dict objectForKey:@"StyleID"];
            self.goodID       = [dict objectForKey:@"GoodID"];
            self.size         = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"Size"] floatValue]];
            self.material     = [dict objectForKey:@"Material"];
            self.totalWeight  = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"TotalWeight"] floatValue]];
            self.CTWeight     = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"CTWeight"] floatValue]];
            self.price        = [NSString stringWithFormat:@"%.2f", [[dict objectForKey:@"Price"] floatValue]];
        }
    }
    return self;
}

@end


@interface JEDetailModel()
@property(nonatomic, assign)NSInteger pageNumber;
@property(nonatomic, strong)NSString  *deviceID;
@end

@implementation JEDetailModel
- (instancetype)initWithId:(NSString*)idNumber{
    self = [super init];
    if (self) {
        self.idNumber = idNumber;
        self.detailListArray = [NSMutableArray arrayWithCapacity:0];
        self.pageNumber = 1;
#if DEBUG_FAKE
        self.title  = @"千足金绿玉吊坠";
        self.price  = @"234324";
        self.category = @"黄金铂金》黄金吊坠";
        self.totalWeight  = @"1220克";
        self.masterWeight = @"100克";
        self.slaveWeight  = @"22克";
        self.address      = @"李四";
        self.phone        = @"18658199525";
        self.praiseCount  = @"10";
        [self initImagesArray];
        [self.detailListArray addObject:[[JEDetailListItem alloc] initWithDictionary:nil]];
        [self.detailListArray addObject:[[JEDetailListItem alloc] initWithDictionary:nil]];
        [self.detailListArray addObject:[[JEDetailListItem alloc] initWithDictionary:nil]];
        [self.detailListArray addObject:[[JEDetailListItem alloc] initWithDictionary:nil]];
#endif
    }
    return self;
}

//- (void)loadWithID:(NSString*)idNumber goodID:(NSString*)goodID deviceID:(NSString*)deviceID completion:(JECompletionBlock)block{
- (void)loadWithID:(NSString*)idNumber goodID:(NSString*)goodID completion:(JECompletionBlock)block{
#if DEBUG_FAKE
    if (block) {
        block(YES);
    }
    return;
#endif
    if ([idNumber length] ==0) {
        return;
    }
    
//#warning xxxx
    //idNumber = @"RTR40004W";
    // http://60.191.108.245:33681/brosapiservice.svc/GetStyleDetail/RTR40004W/0000/1/ 格式里的?goodID={goodID} 是商品编码 可以不选择
    NSString * deviceID = [self deviceID];
    __weak __typeof(self) weakSelf = self;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@GetStyleDetail/%@/%@/%d", kBaseURLString,idNumber,deviceID,self.pageNumber];
    if ([goodID length] >0) {
        [urlStr appendFormat:@"?goodID=%@",goodID];
    }
    NSLog(@">>>loadWithID = %@",urlStr);
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;

    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *jsonDict = (NSDictionary*)JSON;
        id images = [jsonDict objectForKey:@"imageArray"];
        if ([images isKindOfClass:[NSArray class]]) {
            
        } else if ([images isKindOfClass:[NSString class]]) {
            FEImageItem *item1 = [[FEImageItem alloc] initWithTitle:nil imageURL:images tag:0];
            weakSelf.images = @[item1];
        }

        weakSelf.title      = [jsonDict objectForKey:@"styleName"];
        weakSelf.category   = [jsonDict objectForKey:@"category"];
        weakSelf.idNumber   = [jsonDict objectForKey:@"styleID"];
        weakSelf.totalWeight    = [NSString stringWithFormat:@"%.2f", [[jsonDict objectForKey:@"totalWeight"] floatValue]];
        weakSelf.masterWeight   = [NSString stringWithFormat:@"%.2f", [[jsonDict objectForKey:@"masterWeight"] floatValue]];
        weakSelf.slaveWeight    = [NSString stringWithFormat:@"%.2f", [[jsonDict objectForKey:@"slaveWeight"] floatValue]];
        weakSelf.address     = [jsonDict objectForKey:@"address"];
        weakSelf.phone       = [jsonDict objectForKey:@"servicePhone"];
        NSInteger praiseCount = [[jsonDict objectForKey:@"praiseCount"] integerValue];
        weakSelf.praiseCount = [NSString stringWithFormat:@"%d", praiseCount];
        weakSelf.price       = [NSString stringWithFormat:@"%.2f", [[jsonDict objectForKey:@"price"] floatValue]];
        NSArray *detailListArray = [jsonDict objectForKey:@"detailListArray"];
        for (NSDictionary * item  in detailListArray) {
            JEDetailListItem * listItem = [[JEDetailListItem alloc] initWithDictionary:item];
            [weakSelf.detailListArray addObject:listItem];
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

- (void)praiseWithNumberID:(NSString*)idNumber completion:(JECompletionBlock)block{
    //http://60.191.108.245:33681/brosapiservice.svc/SetPraise/APE0002/dfd
    NSString * deviceID = [self deviceID];
    __weak __typeof(self) weakSelf = self;
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@SetPraise/%@/%@", kBaseURLString,idNumber,deviceID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSData   *aData = (NSData*)responseObject;
            NSString *aStr = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
            weakSelf.praiseCount = [aStr stringByReplacingOccurrencesOfString:@"\"" withString:@""];
        }
        if (block) {
            block(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(NO);
        }
    }];
    [operation start];
}

- (void)favoriteWithUserID:(NSString*)userID numberID:(NSString*)numberID  completion:(JECompletionBlock)block{
    NSMutableString *urlStr = [NSMutableString stringWithFormat:@"%@SetCollect/%@/%@", kBaseURLString,numberID,userID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        if ([responseObject isKindOfClass:[NSData class]]) {
            NSData   *aData = (NSData*)responseObject;
            NSString *aStr = [[NSString alloc] initWithData:aData encoding:NSUTF8StringEncoding];
            
        }
        if (block) {
            block(YES);
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if (block) {
            block(NO);
        }
    }];
    [operation start];
}

- (void)resetData{
    [self.detailListArray removeAllObjects];
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

- (NSString*)deviceID{
    if (_deviceID == nil) {
        CFUUIDRef deviceId = CFUUIDCreate (NULL);
        CFStringRef deviceIdStringRef = CFUUIDCreateString(NULL,deviceId);
        CFRelease(deviceId);
        _deviceID = (NSString *)CFBridgingRelease(deviceIdStringRef);
    }
    return _deviceID;
}

- (NSString*)getStringWithObject:(id)object{
    return nil;
}
@end
