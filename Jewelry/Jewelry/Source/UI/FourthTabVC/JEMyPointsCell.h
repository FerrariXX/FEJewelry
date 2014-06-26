//
//  JEMyPointsCell.h
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEMyPointsModel.h"

@interface JEMyPointsCell : UITableViewCell

@property (strong, nonatomic) IBOutlet UILabel *categoryLabel;

@property (strong, nonatomic) IBOutlet UILabel *pointLabel;

@property (strong, nonatomic) IBOutlet UILabel *sourceLabel;
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;

+ (JEMyPointsCell*)myPointsCell;
- (void)refreshCell:(JEMyPointItem*)myPointItem;
@end
