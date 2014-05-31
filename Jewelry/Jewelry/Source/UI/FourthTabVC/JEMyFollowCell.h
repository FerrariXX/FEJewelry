//
//  JEMyFollowCell.h
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JEMyFollowCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UIImageView *portraitImageView;
@property (strong, nonatomic) IBOutlet UILabel *nameLable;
@property (strong, nonatomic) IBOutlet UILabel *dateLable;

@property (strong, nonatomic) IBOutlet UIImageView *coverImageView;
+ (JEMyFollowCell*)myFollowCell;
@end
