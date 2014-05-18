//
//  FEHomePageModel.m
//  Jewelry
//
//  Created by xxx on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEHomePageModel.h"


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
@end


@interface JEHomePageModel()
@property(nonatomic, strong)NSArray *contentArray;

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

- (void)loadDataWithCategory:(NSString*)categroy priceRange:(NSString*)priceRange{
    //TODO:
}


#pragma mark - Private Method
- (void)baseInit{
    JEHomePageItem * item = [[JEHomePageItem alloc] init];
    self.contentArray = @[item,[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init],[[JEHomePageItem alloc] init]];
}

@end
