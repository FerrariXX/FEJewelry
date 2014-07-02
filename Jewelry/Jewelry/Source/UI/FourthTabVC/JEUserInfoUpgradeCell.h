//
//  JEUserInfoUpgradeCell.h
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JEUserInfoUpgradeCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;

- (void)refreshCell:(NSString*)avatarURL;
+ (JEUserInfoUpgradeCell*)userInfoUpgradeCell;
+ (CGFloat)height;

@end
