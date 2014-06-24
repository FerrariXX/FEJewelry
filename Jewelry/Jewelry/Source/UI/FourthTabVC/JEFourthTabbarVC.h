//
//  JEFourthTabbarVC.h
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEUserInfoModel.h"

@interface JEFourthTabbarVC : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) JEUserInfoModel *userModel;
@end
