//
//  FETabBarView.h
//  Pumpkin
//
//  Created by xxx on 7/15/12.
//  Copyright (c) 2012 XXX. All rights reserved.
//

#import <UIKit/UIKit.h>

#define kTabbarHeight  50

@protocol FETabBarViewDelegate <NSObject>
//Handle tab bar touch events, sending the index of the selected tab
-(void)tabBarSelectedItem:(NSInteger)index;
@end

@interface FETabBarView : UIView
@property(nonatomic,weak)   id<FETabBarViewDelegate> delegate;
@property(nonatomic,readonly) NSInteger curSeletedIndex;

- (void)addTabBarItemsButtonCount:(NSInteger)count;
- (void)setTabBarItemNormalImage:(NSArray*)imageNArray highlightImage:(NSArray*)imageHArray;
- (void)setTabBarItemTitle:(NSArray*)titleArray; 
- (void)setTabBarItemSeletedIndex:(NSInteger)index;
@end
