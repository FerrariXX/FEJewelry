//
//  JEDetailModel.m
//  Jewelry
//
//  Created by lv on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "JEDetailModel.h"

@implementation JEDetailModel
- (instancetype)initWithId:(NSString*)idNumber{
    self = [super init];
    if (self) {
        self.idNumber = idNumber;
    }
    return self;
}


@end
