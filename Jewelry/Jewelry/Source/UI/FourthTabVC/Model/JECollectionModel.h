//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JECollectionItem : NSObject
@property(nonatomic, strong)NSString* name;
@property(nonatomic, strong)NSString* numberID;
@property(nonatomic, strong)NSString* price;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@interface JECollectionModel : NSObject
@property(nonatomic, strong)NSMutableArray *collectionList;
- (void)loadCollectionList:(NSString*)userId completion:(JECompletionBlock)block;

@end
