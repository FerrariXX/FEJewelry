//
//  JEHomePageManager.m
//  Jewelry
//
//  Created by lv on 14-4-28.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEHomePageManager.h"
#import "JEHomePageModel.h"
#import "JECategory.h"
#import "JEPriceRange.h"

@interface JEHomePageManager ()
@property(nonatomic, strong)JEHomePageModel *homePageModel;
@property(nonatomic, strong)JECategory      *jewelryCategory;
@property(nonatomic, strong)JEPriceRange    *jewelryPriceRange;
@end

@implementation JEHomePageManager
+ (instancetype)sharedHomePageManager{
    static JEHomePageManager *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[JEHomePageManager alloc] init];
        [_sharedManager.homePageModel loadDataWithCategory:[_sharedManager.jewelryCategory currentSelectedPriceRange] priceRange:[_sharedManager.jewelryPriceRange currentSelectedPriceRange]];
    });
    return _sharedManager;
}

- (JEHomePageModel *)homePageModel{
    if (_homePageModel == nil) {
        _homePageModel = [[JEHomePageModel alloc] init];
    }
    return _homePageModel;
}

- (JECategory *)jewelryCategory{
    if (_jewelryCategory == nil) {
        _jewelryCategory = [[JECategory alloc] init];
    }
    return _jewelryCategory;
}

- (JEPriceRange *)jewelryPriceRange{
    if (_jewelryPriceRange == nil) {
        _jewelryPriceRange = [[JEPriceRange alloc] init];
    }
    return _jewelryPriceRange;
}

@end
