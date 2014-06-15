//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEDetailListItem : NSObject
@property(nonatomic, strong)NSString* numberID;
@property(nonatomic, strong)NSString* goodID;
@property(nonatomic, strong)NSString* size;
@property(nonatomic, strong)NSString* material;
@property(nonatomic, strong)NSString*totalWeight;
@property(nonatomic, strong)NSString*CTWeight;
@property(nonatomic, strong)NSString*price;

- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@interface JEDetailModel : NSObject
@property(nonatomic, strong)NSArray* images;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)NSString* price;
@property(nonatomic, strong)NSString* category;
@property(nonatomic, strong)NSString* idNumber;
@property(nonatomic, strong)NSString* goodID;//可选
@property(nonatomic, strong)NSString* totalWeight;
@property(nonatomic, strong)NSString* masterWeight;
@property(nonatomic, strong)NSString* slaveWeight;
@property(nonatomic, strong)NSString* address;
@property(nonatomic, strong)NSString* phone;
@property(nonatomic, strong)NSString* praiseCount;
@property(nonatomic, strong)NSMutableArray *detailListArray;

- (instancetype)initWithId:(NSString*)idNumber;
- (void)loadWithID:(NSString*)idNumber goodID:(NSString*)goodID completion:(JECompletionBlock)block;
- (void)praiseWithNumberID:(NSString*)idNumber completion:(JECompletionBlock)block;
- (void)favoriteWithUserID:(NSString*)userID numberID:(NSString*)numberID completion:(JECompletionBlock)block;

@end
