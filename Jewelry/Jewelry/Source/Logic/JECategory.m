//
//  JECategory.m
//  Jewelry
//
//  Created by lv on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JECategory.h"
@interface JECategory()
@property(nonatomic, strong)NSArray*contentArray;
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

#pragma mark - Private Method
- (void)baseInit{
    self.contentArray = @[@"精美镶嵌",@"手镯",@"佛珠",@"挂件",@"玩件",@"宝宝翡翠",@"缤纷宝石"];
}
@end
