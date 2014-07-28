//
//  JEFilterType.h
//  Jewelry
//
//  Created by xxx on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEFilterType : NSObject
- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString*)contentAtIndexPath:(NSIndexPath *)indexPath;
- (void)didSelectRowAtIndexPath:(NSIndexPath *)indexPath;

- (NSString*)currentSelectedFilterType;
- (NSDictionary*)filterArgs;
- (void)loadFilterTypeWithCompletionBlock:(JECompletionBlock)block;

- (void)setFilterType:(NSInteger)filterType;
@end
