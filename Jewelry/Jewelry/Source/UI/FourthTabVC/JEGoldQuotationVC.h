//
//  JEGoldQuotationVC.h
//  Jewelry
//
//  Created by wuyj on 14-6-3.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEGoalPriceModel.h"

@interface JEGoldQuotationVC : UIViewController<UITableViewDataSource,UITableViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) JEGoalPriceModel  *goalPriceModel;

@end
