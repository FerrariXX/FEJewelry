//
//  JEHomePageManager.h
//  Jewelry
//
//  Created by xxx on 14-4-28.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@class JEHomePageModel;
@class JECategory;
@class JEFilterType;


@interface JEHomePageManager : NSObject
@property(nonatomic, readonly)JEHomePageModel *homePageModel;
@property(nonatomic, readonly)JECategory      *jewelryCategory;
@property(nonatomic, readonly)JEFilterType    *jewelryFilterType;

+ (instancetype)sharedHomePageManager;
@end
