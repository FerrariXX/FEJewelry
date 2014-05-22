//
//  JEJewelryCircleModel.h
//  Jewelry
//
//  Created by xxx on 14-5-22.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEJewelryCircleItem : NSObject
@property(nonatomic, strong)NSString* logoURL;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* category;
@property(nonatomic, strong)NSString* idNumber;
@property(nonatomic, strong)NSString* certificationId;//证书编号
@property(nonatomic, strong)NSString* price;
@property(nonatomic, strong)NSArray * imagesURL;

@end

@interface JEJewelryCircleModel : NSObject
- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (JEJewelryCircleItem*)contentAtIndexPath:(NSInteger)index;
@end
