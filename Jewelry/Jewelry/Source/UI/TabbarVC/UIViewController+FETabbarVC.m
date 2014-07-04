//
//  UIViewController+FETabbarVC.m
//  Jewelry
//
//  Created by xxxx on 14-7-4.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import "UIViewController+FETabbarVC.h"

@implementation UIViewController (FETabbarVC)
- (FETabBarViewController *)tabbarViewController{
    UIViewController * viewController = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    if ([viewController isKindOfClass:[FETabBarViewController class]]) {
        return (FETabBarViewController*)viewController;
    }
    return nil;
}

@end
