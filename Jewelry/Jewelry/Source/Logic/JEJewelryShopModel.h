//
//  JEJewelryShopModel.h
//  Jewelry
//
//  Created by xxx on 14-5-25.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEJewelryShopItem : NSObject
@property(nonatomic, strong)NSString* imageURL;
@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* idNumber;
@property(nonatomic, strong)NSString* price;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end


@interface JEJewelryShopModel : NSObject
- (NSString*)jewelryShopTitle;
- (NSString*)jewelryShopPhone;

- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (JEJewelryShopItem*)contentAtIndexPath:(NSInteger)index;

- (void)loadWithShopID:(NSString*)shopID completionBlock:(JECompletionBlock)block;
- (void)loadWithShopID:(NSString*)shopID pageNumber:(NSInteger)pageNumber  completionBlock:(JECompletionBlock)block;

@end
