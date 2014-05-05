//
//  JEPriceRange.m
//  Jewelry
//
//  Created by lv on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEPriceRange.h"

#define kJECurrentSelectedPriceRangeKey        @"JECurrentSelectedPriceRangeKey"

@interface JEPriceRange()
@property(nonatomic, strong)NSString *currentSelected;
@property(nonatomic, strong)NSArray  *contentArray;
@end

@implementation JEPriceRange
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

- (NSString*)contentAtIndexPath:(NSIndexPath *)indexPath{
    return FEObjectAtIndex(self.contentArray, indexPath.row);
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentSelected =  FEObjectAtIndex(self.contentArray, indexPath.row);
    [[NSUserDefaults standardUserDefaults] setObject:self.currentSelected forKey:kJECurrentSelectedPriceRangeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)currentSelectedPriceRange{
    return self.currentSelected;
}


#pragma mark - Private Method
- (void)baseInit{
    self.contentArray = @[@"全部",@"200以下",@"200~500",@"500~2000",@"2000~5000",@"5000~10000",@"10000~50000",@"50000~100000",@"100000~500000"];
    self.currentSelected = [[NSUserDefaults standardUserDefaults] objectForKey:kJECurrentSelectedPriceRangeKey];
    if ([self.currentSelected length] >0) {
        self.currentSelected = @"全部";
    }
    
}
@end
