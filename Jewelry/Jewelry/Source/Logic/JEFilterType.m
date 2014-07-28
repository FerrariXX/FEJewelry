//
//  JEFilterType.m
//  Jewelry
//
//  Created by xxx on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEFilterType.h"


@interface JETypeItem : NSObject
@property(nonatomic, strong)NSString* typeID;
@property(nonatomic, strong)NSString* typeName;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@implementation JETypeItem
- (instancetype)initWithDictionary:(NSDictionary*)dict{
    self = [super init];
    if (self) {
        self.typeID   = [dict objectForKey:@"typeID"];
        self.typeName = [dict objectForKey:@"typeName"];
    }
    return self;
}
@end

//////////////////////////////////////////////////////////
#define kJECurrentSelectedFilterTypeKey        @"JECurrentSelectedFilterTypeKey"

@interface JEFilterType()
@property(nonatomic, strong)NSString *currentSelected;
@property(nonatomic, strong)NSArray  *contentArray;
@property(nonatomic, strong)NSArray  *priceRangeArray;
@property(nonatomic, strong)NSArray  *typeArray;
@property(nonatomic, assign)NSInteger filterType;

@end

@implementation JEFilterType
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
    id obj = FEObjectAtIndex(self.contentArray, indexPath.row);
    if ([obj isKindOfClass:[JETypeItem class]]) {
        return [(JETypeItem*)obj typeName];
    } else if ([obj isKindOfClass:[NSString class]]){
        return obj;
    }
    return nil;
}

- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    id obj = FEObjectAtIndex(self.contentArray, indexPath.row);
    if ([obj isKindOfClass:[JETypeItem class]]) {
        self.currentSelected = [(JETypeItem*)obj typeID];
    }
    else if ([obj isKindOfClass:[NSString class]]){
        self.currentSelected = obj;
    }
}

- (NSString*)currentSelectedFilterType{
    return self.currentSelected;
}

- (NSDictionary*)filterArgs{
    if (self.filterType == 0) {
        if (self.currentSelected) {
            return @{@"typeID": self.currentSelected};
        }
    }else {
        NSInteger index = [self.priceRangeArray indexOfObject:self.currentSelected];
        if (index == 1) {
            return @{@"startPrice":@"0",@"endPrice":@"2000"};
        }else if (index >1){
            return @{@"startPrice":[[self.currentSelected componentsSeparatedByString:@"~"] objectAtIndex:0],@"endPrice":[[self.currentSelected componentsSeparatedByString:@"~"] objectAtIndex:1]};
        }
    }
    
    return nil;
}


- (void)loadFilterTypeWithCompletionBlock:(JECompletionBlock)block{
    
#if DEBUG_FAKE
    if (block) {
        block(YES);
    }
    return;
#endif
    __weak __typeof(self) weakSelf = self;
    NSString *urlStr = [NSString stringWithFormat:@"%@GetType", kBaseURLString];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: [NSURL URLWithString:urlStr]];
    request.timeoutInterval = kTimeoutInterval;
    AFJSONRequestOperation *operation = [AFJSONRequestOperation JSONRequestOperationWithRequest:request success:^(NSURLRequest *request, NSHTTPURLResponse *response, id JSON) {
        if (JSON && [JSON isKindOfClass:[NSArray class]]) {
            NSArray *jsonArr = (NSArray*)JSON;
            NSMutableArray *items = [NSMutableArray arrayWithCapacity:0];
            for (NSDictionary *item in jsonArr) {
                JETypeItem * cateItem = [[JETypeItem alloc] initWithDictionary:item];
                [items addObject:cateItem];
            }
            
            weakSelf.typeArray = [items copy];
            weakSelf.contentArray = self.filterType == 0 ? self.typeArray : self.priceRangeArray;
            [weakSelf setCurrentSelected:((JETypeItem*)[items objectAtIndex:0]).typeID];
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


- (void)setFilterType:(NSInteger)filterType{
    if (_filterType != filterType ) {
        _filterType = filterType;
        self.contentArray = self.filterType == 0 ? self.typeArray : self.priceRangeArray;
    }
}

#pragma mark - Private Method
- (void)baseInit{
    self.priceRangeArray = @[@"全部",@"2000以下",@"2000~5000",@"5000~10000",@"10000~50000",@"50000~100000",@"100000~500000"];
#if DEBUG_FAKE
    self.contentArray = @[@"全部",@"2000以下",@"2000~5000",@"5000~10000",@"10000~50000",@"50000~100000",@"100000~500000"];
    self.currentSelected = [[NSUserDefaults standardUserDefaults] objectForKey:kJECurrentSelectedFilterTypeKey];
    if ([self.currentSelected length] >0) {
        self.currentSelected = @"全部";
    }
#endif
}

- (void)setCurrentSelected:(NSString *)currentSelected{
    if (_currentSelected != currentSelected) {
        _currentSelected = currentSelected;
        [[NSUserDefaults standardUserDefaults] setObject:currentSelected forKey:kJECurrentSelectedFilterTypeKey];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
}
@end
