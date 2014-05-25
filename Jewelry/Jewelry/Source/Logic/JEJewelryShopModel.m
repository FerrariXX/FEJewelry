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
        self.imagesURL = @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png";
        self.name   = @"黄金平安锁 ";
        self.idNumber = @"36978203909";
        self.price    = @"111.343";
        self.date     = @"2015/5/23";
    }
    return self;
}

@end

@interface JEJewelryShopModel()
@property(nonatomic, strong)NSArray *contentArray;
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

- (NSInteger)numberOfSection{
    return 1;
}

- (NSInteger)numberOfRowsInSection:(NSInteger)section{
    return [self.contentArray count];
}

- (JEJewelryShopItem*)contentAtIndexPath:(NSInteger)index{
    return FEObjectAtIndex(self.contentArray,index);
}

#pragma mark - Private Method
- (void)baseInit{
    JEJewelryShopItem * item = [[JEJewelryShopItem alloc] init];
    self.contentArray = @[item,[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init],[[JEJewelryShopItem alloc] init]];
}


@end
