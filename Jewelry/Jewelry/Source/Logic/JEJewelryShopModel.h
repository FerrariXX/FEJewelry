//
//  JEJewelryShopModel.h
//  Jewelry
//
//  Created by xxx on 14-5-25.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEJewelryShopItem : NSObject
@property(nonatomic, strong)NSString* imagesURL;
@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* idNumber;
@property(nonatomic, strong)NSString* price;
@property(nonatomic, strong)NSString* date;

@end


@interface JEJewelryShopModel : NSObject
- (NSString*)jewelryShopTitle;
- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (JEJewelryShopItem*)contentAtIndexPath:(NSInteger)index;
@end
