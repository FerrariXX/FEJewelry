//
//  JEDiamondListCell.h
//  Jewelry
//
//  Created by wuyj on 14-5-31.
//  Copyright (c) 2014年 FE. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JEDiamondListCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *shopNameLabel;
@property (strong, nonatomic) IBOutlet UILabel *certificateLabel;
@property (strong, nonatomic) IBOutlet UILabel *stoneWeightLabel;
@property (strong, nonatomic) IBOutlet UILabel *cleanlinessLabel;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;
@property (strong, nonatomic) IBOutlet UILabel *priceLabel;

+ (JEDiamondListCell*)diamondListCellCell;
+ (CGFloat)height;

+ (UIView*)diamondListCellHeaderView;

@end
