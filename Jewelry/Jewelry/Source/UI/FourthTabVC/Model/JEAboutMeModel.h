//
//  JEDetailModel.h
//  Jewelry
//
//  Created by xxx on 14-5-5.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface JEAboutMeModel : NSObject
@property(nonatomic, strong)NSString  *aboutMeUrl;
- (void)getAboutMeH5Url:(JECompletionBlock)block;

@end
