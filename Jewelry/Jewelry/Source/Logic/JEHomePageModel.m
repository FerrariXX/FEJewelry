//
//  FEHomePageModel.m
//  Jewelry
//
//  Created by xxx on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEHomePageModel.h"
#import <AFNetworking/AFNetworking.h>


@implementation JEHomePageItem
- (id)init
{
    self = [super init];
    if (self) {
        //"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg",
        self.imgURL = @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png";
        self.desInfo  = @"菲尔美床上用品 学生单人 颈椎枕头 慢回弹枕芯 枕头zhentou包邮";
        self.idNumber = [NSString stringWithFormat:@"%.6f",[[NSDate date] timeIntervalSince1970]];//@"36978203909";
        self.price    = @"111.343";
    }
    return self;
}

- (instancetype)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        //"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg",
        self.imgURL = [dict objectForKey:@"imageURL"];
        self.desInfo  = [dict objectForKey:@"name"];
        self.idNumber = [dict objectForKey:@"numberID"];
        self.price    = [dict objectForKey:@"price"];
    }
    return self;
}

@end


@interface JEHomePageModel()
@property(nonatomic, strong)NSMutableArray *contentArray;

@end

@implementation JEHomePageModel
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

- (JEHomePageItem*)contentAtIndexPath:(NSInteger)index{
    return FEObjectAtIndex(self.contentArray,index);
}

- (void)loadDataWithCategory:(NSString*)categroy pageNumber:(NSInteger)pageNumber  completionBlock:(JECompletionBlock)block{
    NSString *urlStr = [NSString stringWithFormat:@"%@GetStyleByCategory/%@/%d", kBaseURLString,categroy,pageNumber];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    
    AFJSONRequestOperation *operation1 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
       // NSDictionary *jsonDict = (NSDictionary*)JSON;
        //TODO:
        if (block) {
            block(YES);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (block) {
            block(NO);
        }
    }];
    [operation1 start];
}

- (void)loadDataWithCategory:(NSString*)categroy priceRange:(NSString*)priceRange{
    
    NSArray *item = [priceRange componentsSeparatedByString:@"~"];
    if ([item count]==2) {
        [self loadDataWithCategory:categroy startPrice:[item objectAtIndex:0] endPrice:[item objectAtIndex:1]];
    }
}

- (void)loadDataWithCategory:(NSString*)categroy startPrice:(NSString*)startPrice endPrice:(NSString*)endPrice{

    //TODO:
    return;
    
    __weak __typeof(self) weakSelf = self;//__typeof(&*self)
    NSString *urlStr = [NSString stringWithFormat:@"%@GetStyleByCategoryPrice/{categoryID:01,startPrice:0,endPrice:10000}", kBaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *jsonDict = (NSDictionary*)JSON;
        [weakSelf parserResponseDict:jsonDict];
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        
    }];
    [operation start];
}


#pragma mark - Private Method
- (void)baseInit{
    self.contentArray = [NSMutableArray arrayWithCapacity:0];
    JEHomePageItem * item = [[JEHomePageItem alloc] init];
    NSArray * items = @[item,[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init]];
    [self.contentArray addObjectsFromArray:items];
}

- (void)parserResponseDict:(NSDictionary*)dict{
    if (dict && [dict isKindOfClass:[NSDictionary class]]) {
        NSArray *itemArray = [dict objectForKey:@"categoryListArray"];
        if (itemArray && [itemArray isKindOfClass:[NSArray class]]) {
            for (NSDictionary * item in itemArray) {
                JEHomePageItem *homePageItem = [[JEHomePageItem alloc] initWithDictionary:item];
                [self.contentArray addObject:homePageItem];
            }
        }
    }
}
@end
