//
//  JESettingUserInfoCell.h
//  Jewelry
//
//  Created by wuyj on 14-5-28.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JESettingUserInfoCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *accountLable;
@property (strong, nonatomic) IBOutlet UILabel *orzLable;

+ (JESettingUserInfoCell*)settingUserInfoCell;
+ (CGFloat)height;
@end
