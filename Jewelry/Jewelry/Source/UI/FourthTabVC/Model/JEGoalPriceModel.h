//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEGoalPriceItem : NSObject
@property(nonatomic, strong)NSString* goldName;
@property(nonatomic, strong)NSString* price;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@interface JEGoalPriceModel : NSObject
@property(nonatomic, strong)NSMutableArray *goldListArray;
- (void)loadGoldListArray:(JECompletionBlock)block;

@end
