//
//  FELogInOrRegisterViewController.h
//  xxx
//
//  Copyright (c) 2014 XXXXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FEAccountManager.h"

@interface FELogInOrRegisterViewController : UIViewController
+ (instancetype)sharedInstance;
- (BOOL)isLogin;
- (void)showLoginVCWithCompletionBlock:(JEAuthCompletionBlock)block;
- (void)dismissLoginVC;
@end
