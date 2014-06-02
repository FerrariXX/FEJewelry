//
//  JEJewelryCircleModel.h
//  Jewelry
//
//  Created by xxx on 14-5-22.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEJewelryCircleItem : NSObject
@property(nonatomic, strong)NSString* shopID;
@property(nonatomic, strong)NSString* shopName;
@property(nonatomic, strong)NSString* shopImage;
@property(nonatomic, strong)NSString* shopAddress;
@property(nonatomic, strong)NSString* shopPhone;
@property(nonatomic, strong)NSArray * shopGoodsURL;

- (instancetype)initWithDictionary:(NSDictionary*)dict;

@end

@interface JEJewelryCircleModel : NSObject
@property(nonatomic, strong)NSArray *bannerImages;
- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (JEJewelryCircleItem*)contentAtIndexPath:(NSInteger)index;

- (void)loadWithCompletionBlock:(JECompletionBlock)block;
@end
