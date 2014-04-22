//
//  JEPriceRange.h
//  Jewelry
//
//  Created by lv on 14-4-21.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface JEPriceRange : NSObject
- (NSInteger)numberOfSection;
- (NSInteger)numberOfRowsInSection:(NSInteger)section;
- (NSString*)contentAtIndexPath:(NSIndexPath *)indexPath;
@end
