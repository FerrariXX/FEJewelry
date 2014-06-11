//
//  JEFirstTabbarVC.h
//  Jewelry
//
//  Created by xxx on 14-4-15.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JEHomePageModel;

@interface JEFirstTabbarVC : UITableViewController
@property(nonatomic, strong)NSString *categoryID;
- (void)reloadData;
@end
