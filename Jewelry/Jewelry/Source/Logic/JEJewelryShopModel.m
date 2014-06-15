//
//  JEJewelryShopModel.m
//  Jewelry
//
//  Created by xxx on 14-5-25.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEJewelryShopModel.h"
#import "FEMacroDefine.h"

@implementation JEJewelryShopItem
- (id)init
{
    self = [super init];
    if (self) {
        //"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg",
        self.imageURL = @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png";
        self.name   = @"黄金平安锁 ";
        self.idNumber = @"36978203909";
        self.price    = @"111.343";
    }
    return self;
}
- (instancetype)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        id images = [dict objectForKey:@"imageArray"];
        if ([images isKindOfClass:[NSArray class]]) {
            
        } else if ([images isKindOfClass:[NSString class]]) {
            self.imageURL = [dict objectForKey:@"imageArray"];
        }
        self.name  = [dict objectForKey:@"styleName"];
        self.idNumber = [dict objectForKey:@"styleID"];
        self.price    = [dict objectForKey:@"price"];
    }
    return self;
}

@end

@interface JEJewelryShopModel()
@property(nonatomic, strong)NSMutableArray *contentArray;
@property(nonatomic, assign)NSInteger       pageNumber;
@property(nonatomic, assign)BOOL            isHaveMore;

@property(nonatomic, strong)NSString    *shopName;
@property(nonatomic, strong)NSString    *shopPhone;
@end

@implementation JEJewelryShopModel
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self baseInit];
    }
    return self;
}

#pragma mark - Public  Method
- (NSString*)jewelryShopTitle{
    return self.shopName;
}
- (NSString*)jewelryShopPhone{
    return self.shopPhone;
}

- (NSInteger)numberOfSection{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (JEJewelryShopItem*)contentAtIndexPath:(NSInteger)index{
    return FEObjectAtIndex(self.contentArray,index);
}

- (BOOL)isHaveMore{
    return _isHaveMore;
}

- (void)loadWithShopID:(NSString*)shopID completionBlock:(JECompletionBlock)block{
    __weak __typeof(self) weakSelf = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@GetStoreStyles/%@", kBaseURLString,shopID];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (JSON && [JSON isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary*)JSON;
            weakSelf.shopName  = [jsonDict objectForKey:@"shopName"];
            weakSelf.shopPhone = [jsonDict objectForKey:@"shopPhone"];
            NSArray *shopArray = [jsonDict objectForKey:@"shopGoodsArray"];
            if ([shopArray count] >0) {
                for (NSDictionary *dict in shopArray) {
                    JEJewelryShopItem *item = [[JEJewelryShopItem alloc] initWithDictionary:dict];
                    [weakSelf.contentArray addObject:item];
                }
            } else {
                weakSelf.isHaveMore = NO;
            }
        } else {
            weakSelf.isHaveMore = NO;
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

- (void)loadMoreWithShopID:(NSString*)shopID completionBlock:(JECompletionBlock)block{
    if (self.isHaveMore) {
        self.pageNumber ++ ;
        __weak __typeof(self) weakSelf = self;
        NSString *urlStr = [NSString stringWithFormat:@"%@GetStoreStyleDetails/%@/%d", kBaseURLString,shopID,self.pageNumber];
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
        request.timeoutInterval = kTimeoutInterval;
        AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
            if (JSON && [JSON isKindOfClass:[NSArray class]]) {
                NSArray *jsonArray = (NSArray*)JSON;
                if ([jsonArray count] >0) {
                    for (NSDictionary *dict in jsonArray) {
                        JEJewelryShopItem *item = [[JEJewelryShopItem alloc] initWithDictionary:dict];
                        [weakSelf.contentArray addObject:item];
                    }
                } else {
                    weakSelf.isHaveMore = NO;
                }
            } else {
                weakSelf.isHaveMore = NO;
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
}

- (void)loadWithAPIName:(NSString*)api shopID:(NSString*)shopID pageNumber:(NSInteger)pageNumber  completionBlock:(JECompletionBlock)block{
    if ([shopID length] == 0) {
        if (block) {
            block(NO);
        }
        return;
    }
    __weak __typeof(self) weakSelf = self;//__typeof(&*self)
    NSString *urlStr = [NSString stringWithFormat:@"%@%@/%@", kBaseURLString,api,shopID];
    if (pageNumber >1) {
        urlStr = [urlStr stringByAppendingFormat:@"/%d",pageNumber];
    }
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        

        if (JSON && [JSON isKindOfClass:[NSDictionary class]]) {
            NSDictionary *jsonDict = (NSDictionary*)JSON;
            if (pageNumber ==1) {
                weakSelf.shopName  = [jsonDict objectForKey:@"shopName"];
                weakSelf.shopPhone = [jsonDict objectForKey:@"shopPhone"];
            }
            NSArray *shopArray = [jsonDict objectForKey:@"shopGoodsArray"];
            if ([shopArray count] >0) {
                for (NSDictionary *dict in shopArray) {
                    JEJewelryShopItem *item = [[JEJewelryShopItem alloc] initWithDictionary:dict];
                    [weakSelf.contentArray addObject:item];
                }
            } else {
                weakSelf.isHaveMore = NO;
            }
        } else if(pageNumber >1){
            weakSelf.isHaveMore = NO;
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
    self.pageNumber   = 1;
    self.isHaveMore   = YES;
#if 0
    JEJewelryShopItem * item = [[JEJewelryShopItem alloc] init];
    NSArray *fakeItems = @[item,[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init]];
    self.contentArray = [fakeItems copy];
#endif
    
}


@end
