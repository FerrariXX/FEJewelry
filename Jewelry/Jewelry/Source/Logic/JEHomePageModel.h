//
//  FEHomePageModel.h
//  Jewelry
//
//  Created by lv on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEHomePageItem : NSObject
@property(nonatomic, strong)NSString* imgURL;
@property(nonatomic, strong)NSString* desInfo;
@property(nonatomic, strong)NSString* idNumber;
@property(nonatomic, strong)NSString* price;
@end

@interface JEHomePageModel : NSObject
- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (JEHomePageItem*)contentAtIndexPath:(NSInteger)index;
@end
