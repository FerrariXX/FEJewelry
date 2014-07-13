//
//  JECategory.m
//  Jewelry
//
//  Created by xxx on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JECategory.h"

#define kJECurrentSelectedCategoryKey        @"JECurrentSelectedCategoryKey"

@interface JECategoryItem : NSObject
@property(nonatomic, strong)NSString* categoryID;
@property(nonatomic, strong)NSString* categoryName;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@implementation JECategoryItem
- (instancetype)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.categoryID   = [dict objectForKey:@"categoryID"];
        self.categoryName = [dict objectForKey:@"categoryName"];
    }
    return self;
}
@end
////////////////////////////////////////////////////////////////////////////
@interface JECategory()
@property(nonatomic, strong)NSArray*contentArray;
@property(nonatomic, strong)NSString *currentSelected;
@property(nonatomic, assign)NSInteger currentIndex;

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
    return [FEObjectAtIndex(self.contentArray, indexPath.row) categoryName];
}

- (NSString*)categoryIDAtIndexPath:(NSIndexPath *)indexPath{
    return [FEObjectAtIndex(self.contentArray, indexPath.row) categoryID];
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    self.currentIndex    = indexPath.row;
    self.currentSelected =  [FEObjectAtIndex(self.contentArray, indexPath.row) categoryName];
    [[NSUserDefaults standardUserDefaults] setObject:self.currentSelected forKey:kJECurrentSelectedCategoryKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

- (NSString*)currentSelectedCategory{
    return self.currentSelected;
}

- (NSInteger)currentSelectedIndex{
    return self.currentIndex;
//    if (self.currentSelected) {
//        return [self.contentArray indexOfObject:self.currentSelected];
//    }
    return 0;
}

- (void)loadCategoryWithCompletionBlock:(JECompletionBlock)block{
    
#if DEBUG_FAKE
    if (block) {
        block(YES);
    }
    return;
#endif
    __weak __typeof(self) weakSelf = self;//__typeof(&*self)
    NSString *urlStr = [NSString stringWithFormat:@"%@GetCategory", kBaseURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (JSON && [JSON isKindOfClass:[NSArray class]]) {
            NSArray *jsonArr = (NSArray*)JSON;
            NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *item in jsonArr) {
                JECategoryItem * cateItem = [[JECategoryItem alloc] initWithDictionary:item];
                [items addObject:cateItem];
            }
            
            weakSelf.contentArray = [items copy];
            weakSelf.currentIndex = 0;
            weakSelf.currentSelected = [[weakSelf.contentArray objectAtIndex:weakSelf.currentIndex] categoryName];
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
    NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
    NSArray *content = @[@"全部",@"精美镶嵌",@"手镯",@"佛珠",@"挂件",@"玩件",@"宝宝翡翠",@"缤纷宝石"];
    NSInteger index  = 0;
    for (NSString *value  in content) {
        JECategoryItem *item = [[JECategoryItem alloc] init];
        item.categoryName = value;
        item.categoryID   = [NSString stringWithFormat:@"%2d",index];
        [items addObject:item];
    }
    self.contentArray = [items copy];
    self.currentSelected = [[NSUserDefaults standardUserDefaults] objectForKey:kJECurrentSelectedCategoryKey];
    if ([self.currentSelected length] >0) {
        self.currentSelected = @"全部";
    }
    
}
@end
