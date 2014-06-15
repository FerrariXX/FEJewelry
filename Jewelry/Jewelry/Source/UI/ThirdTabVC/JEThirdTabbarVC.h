//
//  JEThirdTabbarVC.h
//  Jewelry
//
//  Created by xxx on 14-4-16.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MKHorizMenu.h"
#import "JEDiamondModel.h"

@interface JEThirdTabbarVC : UIViewController <MKHorizMenuDataSource, MKHorizMenuDelegate,UITableViewDataSource,UITableViewDelegate>

@property (strong, nonatomic) JEDiamondModel *model;
@property (strong, nonatomic) IBOutlet MKHorizMenu *priceMenu;
@property (strong, nonatomic) IBOutlet MKHorizMenu *stoneMenu;
@property (strong, nonatomic) IBOutlet MKHorizMenu *searchFieldMenu;
@property (strong, nonatomic) IBOutlet MKHorizMenu *colorMenu;
@property (strong, nonatomic) IBOutlet MKHorizMenu *neatnessMenu;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@end
