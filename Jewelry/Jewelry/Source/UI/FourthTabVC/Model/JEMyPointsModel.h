//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEMyPointItem : NSObject
@property(nonatomic, strong)NSString* category;
@property(nonatomic, strong)NSString* value;
@property(nonatomic, strong)NSString* sourceID;
@property(nonatomic, strong)NSString* time;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end


@interface JEMyPointsModel : NSObject
@property(nonatomic, strong)NSMutableArray *myPointList;
@property(nonatomic, assign)NSInteger      integration;
- (void)loadMyPointList:(NSString*)userID completion:(JECompletionBlock)block;

@end
