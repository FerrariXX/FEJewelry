//
//  FETabBarViewController.h
//  Pumpkin
//
//  Created by xxx on 7/15/12.
//  Copyright (c) 2012 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FETabBarView.h"

@interface FETabBarViewController : UITabBarController <FETabBarViewDelegate>
{
	FETabBarView*	customTabBarView_;
}
- (void)setTabBarItemNormalImage:(NSArray*)imageNArray highlightImage:(NSArray*)imageHArray;
- (void)setTabBarItemTitle:(NSArray*)titleArray; 
- (void)setFrame:(CGRect)frame;
- (void)setCustomTabBarHide:(BOOL)isHide;
- (void)setCustomSelectedIndex:(NSUInteger)selectedIndex;
@end
