//
//  JECategory.m
//  Jewelry
//
//  Created by xxx on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JECategory.h"

#define kJECurrentSelectedCategoryKey        @"JECurrentSelectedCategoryKey"

@interface JECategory()
@property(nonatomic, strong)NSArray*contentArray;
@property(nonatomic, strong)NSString *currentSelected;

@end

@implementation JECategory
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
    [[NSUserDefaults standardUserDefaults] setObject:self.currentSelected forKey:kJECurrentSelectedCategoryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)currentSelectedCategory{
    return self.currentSelected;
}

- (NSInteger)currentSelectedIndex{
    return [self.contentArray indexOfObject:self.currentSelected];
}


#pragma mark - Private Method
- (void)baseInit{
    self.contentArray = @[@"全部",@"精美镶嵌",@"手镯",@"佛珠",@"挂件",@"玩件",@"宝宝翡翠",@"缤纷宝石"];
    self.currentSelected = [[NSUserDefaults standardUserDefaults] objectForKey:kJECurrentSelectedCategoryKey];
    if ([self.currentSelected length] >0) {
        self.currentSelected = @"全部";
    }
    
}
@end
