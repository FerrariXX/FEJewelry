//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEShakeItem : NSObject
@property(nonatomic, strong)NSString *isLottery;
@property(nonatomic, strong)NSString* lotteryMessage;
- (instancetype)initWithDictionary:(NSDictionary*)dict;
@end

@interface JEShakeModel : NSObject
@property(nonatomic, strong)JEShakeItem *shakeItem;
- (void)shakeOffAction:(NSString*) userId completion:(JECompletionBlock)block;

@end
