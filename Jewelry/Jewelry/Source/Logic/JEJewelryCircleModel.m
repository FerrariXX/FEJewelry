//
//  JEJewelryCircleModel.m
//  Jewelry
//
//  Created by xxx on 14-5-22.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEJewelryCircleModel.h"
#import "FEMacroDefine.h"
#import "FEScrollPageView.h"

@implementation JEJewelryCircleItem
- (id)init
{
    self = [super init];
    if (self) {
        //"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg",
        self.shopImage = @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png";
        self.shopName  = @"黄金平安锁";
        self.shopID = @"36978203909";
        self.shopAddress = @"的开发但是";
        self.shopPhone = @"43242234234";
        //self.imagesURL = @[ @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png", @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png"];
        [self initImagesArray];
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.shopImage = [dict objectForKey:@"shopImage"];
        self.shopName  = [dict objectForKey:@"shopName"];
        self.shopID = [dict objectForKey:@"shopID"];
        self.shopAddress = [dict objectForKey:@"shopAddress"];
        self.shopPhone = [dict objectForKey:@"shopPhone"];
        NSInteger index = 0;
        NSArray *imageURLs = [dict objectForKey:@"shopGoods"];
        NSMutableArray *imageItems = [NSMutableArray arrayWithCapacity:[imageURLs count]];
        for (NSString *url in imageURLs) {
            FEImageItem *item = [[FEImageItem alloc] initWithTitle:nil imageURL:url tag:index++];
            [imageItems addObject:item];
        }
        self.shopGoodsURL =[imageItems copy];
    }
    return self;
}

#pragma mark - Private Method
- (void)initImagesArray{
    FEImageItem *item1 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:0];
    FEImageItem *item2 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:1];
    FEImageItem *item3 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:2];
    FEImageItem *item4 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:3];
    FEImageItem *item5 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:4];
    self.shopGoodsURL = @[item1,item2,item3,item4,item5];
}
@end

@interface JEJewelryCircleModel()
@property(nonatomic, strong)NSMutableArray *contentArray;
@end

@implementation JEJewelryCircleModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

#pragma mark - Public  Method
- (NSInteger)numberOfSection{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (JEJewelryCircleItem*)contentAtIndexPath:(NSInteger)index{
    return FEObjectAtIndex(self.contentArray,index);
}

- (void)loadWithCompletionBlock:(JECompletionBlock)block{
    __weak __typeof(self) weakSelf = self;//__typeof(&*self)
    NSString *urlStr = [NSString stringWithFormat:@"%@GetJewelryRing", kBaseURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *jsonDict = (NSDictionary*)JSON;
        NSArray *imageURLs = [jsonDict objectForKey:@"salesPromotionArray"];
        NSInteger index = 0;
        NSMutableArray *imageItems = [NSMutableArray arrayWithCapacity:[imageURLs count]];
        for (NSString *url in imageURLs) {
            FEImageItem *item = [[FEImageItem alloc] initWithTitle:nil imageURL:url tag:index++];
            [imageItems addObject:item];
        }
        weakSelf.bannerImages = [imageItems copy];
        
        NSArray *shopArray = [jsonDict objectForKey:@"shopArray"];
        for (NSDictionary *dict in shopArray) {
            JEJewelryCircleItem *item = [[JEJewelryCircleItem alloc] initWithDictionary:dict];
            [weakSelf.contentArray addObject:item];
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


#pragma mark - Private Method
- (void)baseInit{
    
    self.contentArray = [NSMutableArray arrayWithCapacity:0];
    JEJewelryCircleItem * item = [[JEJewelryCircleItem alloc] init];
    self.contentArray = @[item,[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init]];
    FEImageItem *item1 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:0];
    FEImageItem *item2 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:1];
    FEImageItem *item3 = [[FEImageItem alloc] initWithTitle:nil imageURL:@"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg" tag:2];
    self.bannerImages = @[item1,item2,item3];
}

@end
