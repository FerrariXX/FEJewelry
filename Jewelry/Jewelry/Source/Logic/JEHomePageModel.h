//
//  FEHomePageModel.h
//  Jewelry
//
//  Created by xxx on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEHomePageItem : NSObject
@property(nonatomic, strong)NSString* imgURL;
@property(nonatomic, strong)NSString* desInfo;
@property(nonatomic, strong)NSString* idNumber;
@property(nonatomic, strong)NSString* price;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@interface JEHomePageModel : NSObject
- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (JEHomePageItem*)contentAtIndexPath:(NSInteger)index;

- (void)loadMoreDataWithCategoryID:(NSString*)categroyID completionBlock:(JECompletionBlock)block;
- (void)loadFirstDataWithCategoryID:(NSString*)categroyID completionBlock:(JECompletionBlock)block;
- (BOOL)isHaveMore;
//清空数据
- (void)resetData;
@end
