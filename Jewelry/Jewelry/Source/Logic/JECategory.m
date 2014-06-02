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
    if (self.currentSelected) {
        return [self.contentArray indexOfObject:self.currentSelected];
    }
    return 0;
}

- (void)loadCategoryWithCompletionBlock:(JECompletionBlock)block{
    
    //TODO:
    return;
    
    __weak __typeof(self) weakSelf = self;//__typeof(&*self)
    NSString *urlStr = [NSString stringWithFormat:@"%@xxx", kBaseURLString];
    NSURLRequest *request = [NSURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        NSDictionary *jsonDict = (NSDictionary*)JSON;
        if ([[jsonDict objectForKey:@"categoryArray"] count] >0) {
            weakSelf.contentArray = [jsonDict objectForKey:@"categoryArray"];
            weakSelf.currentSelected = [weakSelf.contentArray objectAtIndex:0];
            [[NSUserDefaults standardUserDefaults] setObject:weakSelf.currentSelected forKey:kJECurrentSelectedCategoryKey];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
        if (block) {
            block(YES);
        }
        
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error, id JSON) {
        if (block) {
            block(NO);
        }
    }];
    [operation start];
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
