//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEDetailModel : NSObject
@property(nonatomic, strong)NSArray* images;
@property(nonatomic, strong)NSString* title;
@property(nonatomic, strong)NSString* status;
@property(nonatomic, strong)NSString* category;
@property(nonatomic, strong)NSString* idNumber;
@property(nonatomic, strong)NSString* other;
@property(nonatomic, strong)NSString* onlineDate;
@property(nonatomic, strong)NSString* contact;
@property(nonatomic, strong)NSString* phone;

- (instancetype)initWithId:(NSString*)idNumber;

@end
