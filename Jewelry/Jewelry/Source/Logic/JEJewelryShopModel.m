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
        self.imageURL = [dict objectForKey:@"imageURL"];
        self.name  = [dict objectForKey:@"name"];
        self.idNumber = [dict objectForKey:@"numberID"];
        self.price    = [dict objectForKey:@"price"];
    }
    return self;
}

@end

@interface JEJewelryShopModel()
@property(nonatomic, strong)NSMutableArray *contentArray;
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
    return @"点撒富士达";
}
- (NSString*)jewelryShopPhone{
    return @"dsfsd";
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

- (void)loadWithShopID:(NSString*)shopID completionBlock:(JECompletionBlock)block{
    [self loadWithShopID:shopID pageNumber:0 completionBlock:block];
}

- (void)loadWithShopID:(NSString*)shopID pageNumber:(NSInteger)pageNumber  completionBlock:(JECompletionBlock)block{

    //TODO:
    if (block) {
        block(YES);
    }
    return;
    
    
    
    __weak __typeof(self) weakSelf = self;//__typeof(&*self)
    NSString *urlStr = [NSString stringWithFormat:@"%@xxx", kBaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *jsonDict = (NSDictionary*)JSON;
        
        NSArray *shopArray = [jsonDict objectForKey:@"shopGoodsArray"];
        for (NSDictionary *dict in shopArray) {
            JEJewelryShopItem *item = [[JEJewelryShopItem alloc] initWithDictionary:dict];
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
    JEJewelryShopItem * item = [[JEJewelryShopItem alloc] init];
    NSArray *fakeItems = @[item,[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init]];
    self.contentArray = [fakeItems copy];
}


@end
