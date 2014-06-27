//
//  JEGoldQuotationCell.h
//  Jewelry
//
//  Created by wuyj on 14-6-3.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JEGoalPriceModel.h"

@interface JEGoldQuotationCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *productNameValue;
@property (strong, nonatomic) IBOutlet UILabel *priceValueLable;

@property (strong, nonatomic) IBOutlet UILabel *dateValueLable;
+ (JEGoldQuotationCell*)goldQuotationCell;
+ (NSDateFormatter*)sharedDateFormatter;
- (void)refreshCell:(JEGoalPriceItem*)priceItem;
@end
