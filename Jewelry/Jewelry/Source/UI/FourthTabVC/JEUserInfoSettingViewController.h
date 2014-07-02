//
//  JFUserInfoSettingViewController.h
//  Jewelry
//
//  Created by wuyj on 14-5-30.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEUserInfoModel.h"

@interface JEUserInfoSettingViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) JEUserInfoModel *userModel;
@end
