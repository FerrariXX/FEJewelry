//
//  JEModifyUserInfoViewController.h
//  Jewelry
//
//  Created by wuyj on 14-7-1.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEUserInfoModifyModel.h"

@interface JEModifyUserInfoViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UILabel *titleLable;
@property (nonatomic, strong) JEUserInfoModifyModel *modifyModel;

- (IBAction)backAction:(id)sender;
- (IBAction)updateAction:(id)sender;

@property (nonatomic, assign) NSInteger   type;
@property (nonatomic, strong) NSString    *modifyText;
@end
