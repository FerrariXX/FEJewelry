//
//  JEDetailModel.m
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEDetailModel.h"
#import "FEScrollPageView.h"

@implementation JEDetailModel
- (instancetype)initWithId:(NSString*)idNumber{
    self = [super init];
    if (self) {
        self.idNumber = idNumber;
        self.title  = @"千足金绿玉吊坠";
        self.price  = @"234324";
        self.status = @"未售";
        self.category = @"黄金铂金》黄金吊坠";
        self.idNumber = @"1234243y2423";
        self.other    = @"总件重约3克,采用xxx";
        self.onlineDate= @"2014-05-21 14:34:55";
        self.contact   = @"李四";
        self.phone     = @"18658199525";
        [self initImagesArray];
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
    self.images = @[item1,item2,item3,item4,item5];
}

@end
