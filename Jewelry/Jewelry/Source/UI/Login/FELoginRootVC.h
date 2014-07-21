//
//  FELoginRootVC.h
//  Jewelry
//
//  Created by admin on 14-7-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEAccountManager.h"

@interface FELoginRootVC : UIViewController
+ (BOOL)isLogin;
+ (void)showLoginVCWithCompletionBlock:(JEAuthCompletionBlock)block;
+ (void)dismissLoginVC;
@end
