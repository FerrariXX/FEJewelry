//
//  JEJewelryCircleModel.m
//  Jewelry
//
//  Created by xxx on 14-5-22.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEJewelryCircleModel.h"

@implementation JEJewelryCircleItem
- (id)init
{
    self = [super init];
    if (self) {
        //"http://gw2.alicdn.com/bao/uploaded/i3/T1QPnBFmleXXXXXXXX_!!0-item_pic.jpg",
        self.logoURL = @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png";
        self.title  = @"菲尔美床上用品 ";
        self.title  = @"黄金平安锁";
        self.idNumber = @"36978203909";
        self.certificationId = @"43242234234";
        self.price     = @"111.343";
        self.imagesURL = @[ @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png", @"http://gw3.alicdn.com/bao/uploaded/i4/12590030640458113/T1iYQHFotfXXXXXXXX_!!2-item_pic.png"];
    }
    return self;
}
@end

@interface JEJewelryCircleModel()
@property(nonatomic, strong)NSArray *contentArray;
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



#pragma mark - Private Method
- (void)baseInit{
    JEJewelryCircleItem * item = [[JEJewelryCircleItem alloc] init];
    self.contentArray = @[item,[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init],[[JEJewelryCircleItem alloc] init]];
}

@end
