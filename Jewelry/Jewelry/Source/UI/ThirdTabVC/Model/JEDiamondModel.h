//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEDiamondListItem : NSObject
@property(nonatomic, strong)NSString* shopName;
@property(nonatomic, strong)NSString* certificationID;
@property(nonatomic, strong)NSString* weight;
@property(nonatomic, strong)NSString* neatness;
@property(nonatomic, strong)NSString* color;
@property(nonatomic, strong)NSString* price;
@property(nonatomic, strong)NSString* detailURL;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@interface JEDiamondModel : NSObject
@property(nonatomic, strong)NSMutableArray *diamondList;
@property(nonatomic, assign)BOOL           isHaveMore;
- (void)loadDiamondList:(NSString*)pageNumber neatness:(NSString*)neatness color:(NSString*)color
weightID:(NSString*)weightID priceID:(NSString*)priceID completion:(JECompletionBlock)block;

@end
