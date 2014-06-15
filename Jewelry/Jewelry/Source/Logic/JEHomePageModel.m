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
        self.imgURL = [dict objectForKey:@"imageArray"];
        self.desInfo  = [dict objectForKey:@"styleName"];
        self.idNumber = [dict objectForKey:@"styleID"];
        self.price    = [NSString stringWithFormat:@"%f",[[dict objectForKey:@"price"] floatValue]];
    }
    return self;
}

- (NSString *)description{
    NSString *str = [NSString stringWithFormat:@"imageURL = %@,name = %@ , numberID=%@ , price=%@", self.imgURL, self.desInfo,self.idNumber,self.price];
    return str;
}

@end


@interface JEHomePageModel()
@property(nonatomic, strong)NSMutableArray *contentArray;
@property(nonatomic, assign)NSInteger       pageNumber;
@property(nonatomic, assign)BOOL            isHaveMore;
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

- (void)loadMoreDataWithCategoryID:(NSString*)categroyID completionBlock:(JECompletionBlock)block{
    self.pageNumber ++ ;
    [self loadDataWithCategory:categroyID pageNumber:self.pageNumber completionBlock:block];
}

- (void)loadFirstDataWithCategoryID:(NSString*)categroyID completionBlock:(JECompletionBlock)block{
    self.pageNumber = 1;
    [self loadDataWithCategory:categroyID pageNumber:self.pageNumber completionBlock:block];
}


- (BOOL)isHaveMore{
    return _isHaveMore;
}

//清空数据
- (void)resetData{
    [self baseInit];
}

#pragma mark - Private Method
- (void)baseInit{
    self.contentArray = [NSMutableArray arrayWithCapacity:0];
    self.isHaveMore   = YES;
    self.pageNumber   = 1;
#if 0
    JEHomePageItem * item = [[JEHomePageItem alloc] init];
    NSArray * items = @[item,[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init]];
    [self.contentArray addObjectsFromArray:items];
#endif
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


- (void)loadDataWithCategory:(NSString*)categroyID pageNumber:(NSInteger)pageNumber  completionBlock:(JECompletionBlock)block{
    NSString *urlStr = [NSString stringWithFormat:@"%@GetStyleByCategory/%@/%d", kBaseURLString,categroyID,pageNumber];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    
    __weak __typeof(self) weakSelf = self;//__typeof(&*self)
    AFJSONRequestOperation *operation1 = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (JSON && [JSON isKindOfClass:[NSArray class]]) {
            NSArray *jsonArr = (NSArray*)JSON;
            if ([jsonArr count] >0) {
                NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
                for (NSDictionary *item in jsonArr) {
                    JEHomePageItem * pageItem = [[JEHomePageItem alloc] initWithDictionary:item];
                    [items addObject:pageItem];
                }
                [weakSelf.contentArray addObjectsFromArray:items];
            } else {
                self.isHaveMore = NO;
            }
        }
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


@end
